package com.appfactory.strick_haekelbuch

import android.app.Application
import android.app.Notification
import android.app.NotificationManager
import android.content.Intent
import java.util.Locale
import java.math.BigDecimal
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [24, 35], application = Application::class)
class AppLocaleTest {
    private val context get() = RuntimeEnvironment.getApplication()
    private val notifications get() = context.getSystemService(NotificationManager::class.java)

    @Before fun setup() {
        shadowOf(context).grantPermissions("android.permission.POST_NOTIFICATIONS")
        AppLocaleBridge.setChoice(context, "system")
    }

    @Test fun systemResolutionUsesPreferredOrderAndEnglishFallback() {
        assertEquals("fr", AppLocaleBridge.resolve(listOf(Locale.forLanguageTag("sv-SE"), Locale.CANADA_FRENCH, Locale.GERMANY)).language)
        assertEquals("en", AppLocaleBridge.resolve(listOf(Locale.forLanguageTag("nb-NO"))).language)
        assertEquals("en", AppLocaleBridge.resolve(emptyList()).language)
        assertEquals("pt-BR", AppLocaleBridge.resolve(listOf(Locale.forLanguageTag("pt-PT"))).toLanguageTag())
    }

    @Test fun allSixLanguagesWorkWithoutAFlutterEngineAndKeepUserNames() {
        val translations = mapOf("de" to "Stricken", "en" to "Knitting", "es" to "Punto", "fr" to "Tricot", "it" to "Maglia", "pt-BR" to "Tricô")
        for ((locale, technique) in translations) {
            notifications.cancelAll()
            assertTrue(AppLocaleBridge.setChoice(context, locale))
            assertEquals(locale, AppLocaleBridge.choice(context))
            assertEquals("posted", ReminderNotifier.showTest(context, "project", "Mein eigener Schal", "knitting", "Stricken", "48", "Reihen", false, "48", 0))
            val notification = shadowOf(notifications).allNotifications.single()
            val title = notification.extras.getCharSequence(Notification.EXTRA_TITLE).toString()
            assertTrue(title, title.contains(technique))
            assertTrue(title, title.contains("Mein eigener Schal"))
            val body = notification.extras.getCharSequence(Notification.EXTRA_TEXT).toString()
            assertTrue(body, body.contains("48"))
            if (locale != "de") assertFalse(body, body.contains("Reihen"))
        }
    }

    @Test fun oldCachedValuesAreNotReparsedAndExactDigitsAreOptional() {
        AppLocaleBridge.setChoice(context, "en")
        val old = StoredReminder("id", "name", "knitting", "Stricken", "1.234,500", "Reihen", "daily", 1, null, 9, 0, "normal")
        val restored = StoredReminder.fromJson(old.toJson())!!
        assertNull(restored.latestDigits)
        assertTrue(AppLocaleBridge.progress(context, restored.latestValue, restored.latestUnit, null, null).contains("1.234,500"))
        val precise = old.copy(latestDigits = "900719925474099312345", latestScale = 3)
        assertEquals(precise, StoredReminder.fromJson(precise.toJson()))
        val text = AppLocaleBridge.progress(context, precise.latestValue, precise.latestUnit, precise.latestDigits, precise.latestScale)
        assertTrue(text, text.contains("345"))
    }

    @Test fun quantitiesKeepExactSingularAndRegionalPluralRules() {
        val labels = mapOf("de" to ("Reihe" to "Reihen"), "en" to ("Row" to "Rows"), "es" to ("Fila" to "Filas"), "fr" to ("Rang" to "Rangs"), "it" to ("Riga" to "Righe"), "pt-BR" to ("Carreira" to "Carreiras"))
        for ((locale, names) in labels) {
            AppLocaleBridge.setChoice(context, locale)
            assertEquals(names.first, AppLocaleBridge.unit(context, "Reihen", BigDecimal("1.000")))
            assertEquals(names.first, AppLocaleBridge.unit(context, "Reihen", BigDecimal("-1")))
            assertEquals(if (locale == "fr") names.first else names.second, AppLocaleBridge.unit(context, "Reihen", BigDecimal.ZERO))
            assertEquals(if (locale in listOf("fr", "pt-BR")) names.first else names.second, AppLocaleBridge.unit(context, "Reihen", BigDecimal("1.00000000000000000001")))
        }
    }

    @Test fun languageChangesDoNotMovePendingAlarmsOrChangeChannelIdentity() {
        val reminder = StoredReminder("id", "name", "knitting", "Stricken", null, null, "daily", 1, null, 9, 0, "normal")
        assertTrue(ReminderScheduler.update(context, reminder))
        val due = ReminderStore.nextTrigger(context, "id")
        val normalId = ReminderNotifier.channelId(false)
        val exactId = ReminderNotifier.channelId(true)
        AppLocaleBridge.setChoice(context, "fr")
        MeterReminderReschedule(context)
        assertEquals(due, ReminderStore.nextTrigger(context, "id"))
        assertEquals(normalId, ReminderNotifier.channelId(false))
        assertEquals(exactId, ReminderNotifier.channelId(true))
        if (android.os.Build.VERSION.SDK_INT >= 26) {
            assertEquals("Rappels de projets", notifications.getNotificationChannel(normalId).name.toString())
        }
    }

    private fun MeterReminderReschedule(context: Application) {
        ReminderRescheduleReceiver().onReceive(context, Intent(Intent.ACTION_LOCALE_CHANGED))
    }
}
