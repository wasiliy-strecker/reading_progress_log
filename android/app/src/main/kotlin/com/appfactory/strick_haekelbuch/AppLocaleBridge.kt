package com.appfactory.strick_haekelbuch

import android.app.LocaleManager
import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.Build
import android.os.LocaleList
import android.text.format.DateFormat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.math.BigDecimal
import java.math.BigInteger
import java.text.NumberFormat
import java.util.Locale

/** One app-local preference, shared by Flutter and process-independent receivers. */
internal object AppLocaleBridge {
    private const val preferencesName = "app_locale_settings"
    private const val choiceKey = "language"
    private val choices = setOf("system", "de", "en", "es", "fr", "it", "pt-BR")
    private val supported = setOf("de", "en", "es", "fr", "it", "pt")

    fun register(context: Context, messenger: BinaryMessenger) {
        MethodChannel(messenger, "com.appfactory.strick_haekelbuch/localization")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getSettings" -> result.success(mapOf(
                        "choice" to choice(context),
                        "deviceLocales" to systemLocales(context).map { it.toLanguageTag() },
                        "use24HourClock" to DateFormat.is24HourFormat(context),
                    ))
                    "setLanguage" -> {
                        val language = call.argument<String>("choice")
                        if (language !in choices) {
                            result.error("invalid_language", text(context, R.string.l10n_language_save_failed), null)
                        } else {
                            val saved = setChoice(context, language!!)
                            if (saved) ReminderNotifier.refreshChannelNames(context)
                            result.success(saved)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    fun choice(context: Context): String = context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
        .getString(choiceKey, "system").takeIf { it in choices } ?: "system"

    fun setChoice(context: Context, language: String): Boolean {
        require(language in choices)
        return context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
            .edit().putString(choiceKey, language).commit()
    }

    fun systemLocales(context: Context): List<Locale> {
        val list = if (Build.VERSION.SDK_INT >= 33) {
            context.getSystemService(LocaleManager::class.java)?.systemLocales
                ?: Resources.getSystem().configuration.locales
        } else {
            Resources.getSystem().configuration.locales
        }
        return (0 until list.size()).map { list[it] }.ifEmpty { listOf(Locale.US) }
    }

    fun resolve(preferred: List<Locale>): Locale {
        for (locale in preferred) {
            if (locale.language in supported) {
                return if (locale.language == "pt") Locale.forLanguageTag("pt-BR")
                    else Locale.forLanguageTag(locale.language)
            }
        }
        return Locale.ENGLISH
    }

    fun uiLocale(context: Context): Locale {
        val preference = choice(context)
        return resolve(if (preference == "system") systemLocales(context)
            else listOf(Locale.forLanguageTag(preference)))
    }

    fun text(context: Context, resource: Int, vararg arguments: Any): String {
        val configuration = Configuration(context.resources.configuration)
        configuration.setLocales(LocaleList(uiLocale(context)))
        return context.createConfigurationContext(configuration).getString(resource, *arguments)
    }

    fun technique(context: Context, value: String, legacy: String): String = when (value) {
        "knitting" -> text(context, R.string.l10n_knitting)
        "crochet" -> text(context, R.string.l10n_crochet)
        else -> legacy
    }

    fun unit(context: Context, value: String): String = when (value) {
        "Reihen" -> text(context, R.string.l10n_rows)
        "Runden" -> text(context, R.string.l10n_rounds)
        else -> value
    }

    fun progress(context: Context, legacy: String?, unit: String?, digits: String?, scale: Int?): String {
        if (legacy.isNullOrBlank() || unit.isNullOrBlank()) {
            return text(context, R.string.l10n_no_progress_entries_yet)
        }
        // Old cached reminders are displayed verbatim until the normal app
        // synchronization supplies exact digits. Never parse an ambiguous value.
        val value = if (digits != null && scale != null && scale >= 0) {
            try {
                val number = BigDecimal(BigInteger(digits), scale)
                NumberFormat.getNumberInstance(systemLocales(context).first()).apply {
                    minimumFractionDigits = scale
                    maximumFractionDigits = scale
                }.format(number)
            } catch (_: NumberFormatException) { legacy }
        } else legacy
        return text(context, R.string.l10n_last_progress, value, unit(context, unit))
    }
}
