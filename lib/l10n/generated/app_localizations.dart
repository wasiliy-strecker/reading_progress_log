import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// Löschen Context: lib/app/widgets/confirm_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Abbrechen Context: lib/app/widgets/confirm_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Änderungen verwerfen Context: lib/app/widgets/confirm_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get discardChanges;

  /// Weiter bearbeiten Context: lib/app/widgets/confirm_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Continue editing'**
  String get continueEditing;

  /// Projektprotokoll wird erstellt Context: lib/app/widgets/pdf_export_progress_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Creating project report'**
  String get creatingProjectReport;

  /// Bitte kurz warten … Context: lib/app/widgets/pdf_export_progress_dialog.dart
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get pleaseWait;

  /// Test-Erinnerung wurde an Android übergeben. Ziehe die Benachrichtigungsleiste herunter. Die Test-Erinnerung verschwindet nach einer Minute.{p0} Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'Test reminder sent to Android. Open the notification shade. The test reminder disappears after one minute.{p0}'**
  String testReminderSentToAndroidOpenTheNotificationShade(String p0);

  ///  „Nicht stören“ ist aktiv. Ton und Banner können unterdrückt werden. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **' Do Not Disturb is on. Sound and banners may be suppressed.'**
  String get doNotDisturbIsOnSoundAndBannersMay;

  /// Benachrichtigungen sind nicht erlaubt. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'Notifications are not allowed.'**
  String get notificationsAreNotAllowed;

  /// Diese Erinnerungsart ist in Android gesperrt. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'This reminder category is blocked in Android.'**
  String get thisReminderCategoryIsBlockedInAndroid;

  /// Test-Erinnerung konnte nicht angezeigt werden. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'Could not show the test reminder.'**
  String get couldNotShowTheTestReminder;

  /// Test-Erinnerungen werden auf diesem Gerät nicht unterstützt. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'Test reminders are not supported on this device.'**
  String get testRemindersAreNotSupportedOnThisDevice;

  /// Die stündliche Erinnerung benötigt einen Startzeitpunkt. Context: lib/core/reminders/local_notification_reminder_repository.dart
  ///
  /// In en, this message translates to:
  /// **'An hourly reminder requires a start time.'**
  String get anHourlyReminderRequiresAStartTime;

  /// Daten gespeichert. Die Erinnerung konnte nicht ausgeschaltet werden. Öffne die Erinnerung und speichere erneut. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. Could not turn off the reminder. Open the reminder and save again.'**
  String get dataSavedCouldNotTurnOffTheReminderOpen;

  /// Daten gespeichert. Erinnerungen sind in Android blockiert. Öffne die Erinnerung und dann die Android-Einstellungen. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. Reminders are blocked in Android. Open the reminder, then Android settings.'**
  String get dataSavedRemindersAreBlockedInAndroidOpenThe;

  /// Daten gespeichert. Erinnerungen werden auf diesem Gerät nicht unterstützt. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. Reminders are not supported on this device.'**
  String get dataSavedRemindersAreNotSupportedOnThisDevice;

  /// Daten gespeichert. Die Erinnerung konnte nicht bestätigt werden. Öffne die Erinnerung und speichere erneut. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. The reminder could not be confirmed. Open the reminder and save again.'**
  String get dataSavedTheReminderCouldNotBeConfirmedOpen;

  /// Daten gespeichert. Für eine pünktliche Erinnerung öffne „Alarme & Erinnerungen“ in den Android-Einstellungen. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. For an on-time reminder, open Alarms & reminders in Android settings.'**
  String get dataSavedForAnOnTimeReminderOpenAlarms;

  /// Daten gespeichert. Der Erinnerungsstatus konnte nicht geprüft werden. Öffne die Erinnerung und speichere erneut. Context: lib/core/reminders/reminder_save_feedback.dart
  ///
  /// In en, this message translates to:
  /// **'Data saved. Could not check reminder status. Open the reminder and save again.'**
  String get dataSavedCouldNotCheckReminderStatusOpenThe;

  /// Wozu dient das Projektprotokoll? Context: lib/core/integrity/integrity_copy.dart
  ///
  /// In en, this message translates to:
  /// **'What is the project report for?'**
  String get whatIsTheProjectReportFor;

  /// Du wählst vor dem Erstellen: kompakt ohne Fotos oder mit allen aktuellen Fotos. Projektstand, Zeitpunkt und Notizen sind in beiden Varianten enthalten – zum Speichern, Drucken oder Teilen. Context: lib/core/integrity/integrity_copy.dart
  ///
  /// In en, this message translates to:
  /// **'Before creating it, choose a compact report without photos or one with all current photos. Both include progress, dates and notes, ready to save, print or share.'**
  String get beforeCreatingItChooseACompactReportWithoutPhotos;

  /// Es dokumentiert deinen Projektfortschritt anhand deiner bestätigten Angaben. Context: lib/core/integrity/integrity_copy.dart
  ///
  /// In en, this message translates to:
  /// **'It records your project progress using the information you confirmed.'**
  String get itRecordsYourProjectProgressUsingTheInformationYou;

  /// Die PDF bündelt alle Projektstände mit Fortschritt und Notizen. Du wählst: kompakt ohne Fotos oder mit allen aktuellen Fotos jedes Projektstands – zum Speichern, Drucken oder Teilen. Context: lib/core/integrity/integrity_copy.dart
  ///
  /// In en, this message translates to:
  /// **'The PDF brings together all progress entries and notes. Choose a compact report without photos or include all current photos for each entry, ready to save, print or share.'**
  String get thePDFBringsTogetherAllProgressEntriesAndNotes;

  /// Private Dokumentation deines Projektfortschritts. Context: lib/core/integrity/integrity_copy.dart
  ///
  /// In en, this message translates to:
  /// **'Personal record of your project progress.'**
  String get personalRecordOfYourProjectProgress;

  /// Der Foto-Zwischenstand konnte nicht gesichert werden. Context: lib/core/files/photo_draft_store.dart
  ///
  /// In en, this message translates to:
  /// **'Could not save the photo draft.'**
  String get couldNotSaveThePhotoDraft;

  /// Der Foto-Zwischenstand konnte nicht entfernt werden. Context: lib/core/files/photo_draft_store.dart
  ///
  /// In en, this message translates to:
  /// **'Could not remove the photo draft.'**
  String get couldNotRemoveThePhotoDraft;

  /// Eine manuelle Erfassung verwendet keinen Fotozugriff. Context: lib/core/files/meter_photo_store.dart
  ///
  /// In en, this message translates to:
  /// **'Manual entry does not access photos.'**
  String get manualEntryDoesNotAccessPhotos;

  /// Das Foto konnte nicht sicher optimiert werden. Bitte wähle es erneut aus. Context: lib/core/files/meter_photo_store.dart
  ///
  /// In en, this message translates to:
  /// **'Could not safely optimize the photo. Please select it again.'**
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt;

  /// Kompakt ohne Fotos Context: lib/features/evidence/domain/evidence_export.dart
  ///
  /// In en, this message translates to:
  /// **'Compact, without photos'**
  String get compactWithoutPhotos;

  /// Mit aktuellen Fotos Context: lib/features/evidence/domain/evidence_export.dart
  ///
  /// In en, this message translates to:
  /// **'With current photos'**
  String get withCurrentPhotos;

  /// Mit allen Fotos (ältere Version) Context: lib/features/evidence/domain/evidence_export.dart
  ///
  /// In en, this message translates to:
  /// **'With all photos (older version)'**
  String get withAllPhotosOlderVersion;

  /// Für dieses Projekt gibt es noch keine Projektstände. Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'This project has no progress entries yet.'**
  String get thisProjectHasNoProgressEntriesYet;

  /// Die Projektstände gehören nicht zu diesem Projekt. Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'The progress entries do not belong to this project.'**
  String get theProgressEntriesDoNotBelongToThisProject;

  /// Projektprotokoll Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Project report'**
  String get projectReport;

  /// Private Dokumentation eines Projektstands Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Personal record of project progress'**
  String get personalRecordOfProjectProgress;

  /// Seite {p0} von {p1} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Page {p0} of {p1}'**
  String pageOf(String p0, String p1);

  /// Einzelner Projektstand Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Single progress entry'**
  String get singleProgressEntry;

  /// Projektverlauf Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Project history'**
  String get projectHistory;

  /// PDF erstellt am {p0} · {p1} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'PDF created on {p0} · {p1}'**
  String pdfCreatedOn(String p0, String p1);

  /// Aktuelle Projektangaben Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Current project details'**
  String get currentProjectDetails;

  /// Projektangaben bei Erfassung Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Project details when recorded'**
  String get projectDetailsWhenRecorded;

  /// Technik Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Technique'**
  String get technique;

  /// Projektname Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// Garn Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Yarn'**
  String get yarn;

  /// Nadelstärke Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Needle or hook size'**
  String get needleOrHookSize;

  /// Zählweise Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Counting unit'**
  String get countingUnit;

  /// Nr. Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'No.'**
  String get no;

  /// Zeitpunkt Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get dateAndTime;

  /// Projektstand Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry'**
  String get progressEntry;

  /// Fortschritt Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// Nicht angegeben Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// Projektstand {p0} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry {p0}'**
  String progressEntry53(String p0);

  /// Zeitpunkt des Projektstands Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Progress date and time'**
  String get progressDateAndTime;

  /// Projektstand {p0} · {p1} · {p2} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry {p0} · {p1} · {p2}'**
  String progressEntry55(String p0, String p1, String p2);

  /// Niedrigerer Stand: {p0} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Lower count: {p0}'**
  String lowerCount(String p0);

  /// Notiz Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// Früheres Foto {p0} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Earlier photo {p0}'**
  String earlierPhoto(String p0);

  /// Foto {p0} von {p1} Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Photo {p0} of {p1}'**
  String photoOf(String p0, String p1);

  /// Projektstandfoto konnte nicht eingebettet werden. Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'Could not embed the progress photo.'**
  String get couldNotEmbedTheProgressPhoto;

  /// Keine vorbereitete Fotodatei vorhanden. Context: lib/features/evidence/application/evidence_report_service.dart
  ///
  /// In en, this message translates to:
  /// **'No prepared photo file available.'**
  String get noPreparedPhotoFileAvailable;

  /// Erstellt am {p0} Uhr Context: lib/features/evidence/presentation/evidence_export_card.dart
  ///
  /// In en, this message translates to:
  /// **'Created on {p0}'**
  String createdOn(String p0);

  /// Lokal gespeichert Context: lib/features/evidence/presentation/evidence_export_card.dart
  ///
  /// In en, this message translates to:
  /// **'Saved locally'**
  String get savedLocally;

  /// Datei fehlt Context: lib/features/evidence/presentation/evidence_export_card.dart
  ///
  /// In en, this message translates to:
  /// **'File missing'**
  String get fileMissing;

  /// Projektprotokoll löschen Context: lib/features/evidence/presentation/evidence_export_card.dart
  ///
  /// In en, this message translates to:
  /// **'Delete project report'**
  String get deleteProjectReport;

  /// Gespeicherte Projektprotokolle Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Saved project reports'**
  String get savedProjectReports;

  /// Projektprotokolle konnten nicht geladen werden Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load project reports'**
  String get couldNotLoadProjectReports;

  /// Projektprotokolle werden geladen … Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Loading project reports…'**
  String get loadingProjectReports;

  /// Projektprotokolle konnten nicht geladen werden. Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load project reports.'**
  String get couldNotLoadProjectReports73;

  /// Zurück Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Weiter Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// PDF-Datei wird geprüft … Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Checking PDF file…'**
  String get checkingPDFFile;

  /// Dateistatus konnte nicht geprüft werden.
  /// Projektprotokoll vom {p0} Uhr Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Could not check file status.\nProject report from {p0}'**
  String couldNotCheckFileStatusNProjectReportFrom(String p0);

  /// Projektprotokoll · Projektverlauf Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Project report · History'**
  String get projectReportHistory;

  /// {p0} Projektstände enthalten Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} progress entries included'**
  String progressEntriesIncluded(String p0);

  /// Erneut versuchen Context: lib/features/evidence/presentation/saved_history_pdfs.dart
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Drucken Context: lib/features/evidence/presentation/evidence_preview_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// Projektprotokoll aus Strick & Häkelbuch Context: lib/features/evidence/presentation/evidence_preview_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project report from Strick & Häkelbuch'**
  String get projectReportFromStrickHKelbuch;

  /// Teilen Context: lib/features/evidence/presentation/evidence_preview_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// PDF-Inhalt wählen Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'Choose PDF content'**
  String get choosePDFContent;

  /// Wähle, welche Inhalte deine PDF enthalten soll. Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'Choose what to include in your PDF.'**
  String get chooseWhatToIncludeInYourPDF;

  /// Projektstände, Zeitpunkte und Notizen – kompakt ohne Fotos. Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entries, dates and notes, compact without photos.'**
  String get progressEntriesDatesAndNotesCompactWithoutPhotos;

  /// Enthält alle aktuell zugeordneten Fotos dieses Projektstands. Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'Includes all photos currently attached to this progress entry.'**
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry;

  /// Enthält alle aktuell zugeordneten Fotos jedes Projektstands. Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'Includes all photos currently attached to each progress entry.'**
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry;

  /// Keine aktuellen Fotos vorhanden. Context: lib/features/evidence/presentation/evidence_photo_mode_sheet.dart
  ///
  /// In en, this message translates to:
  /// **'No current photos available.'**
  String get noCurrentPhotosAvailable;

  /// Kameraaufnahme Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Camera photo'**
  String get cameraPhoto;

  /// Galerieimport Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Gallery import'**
  String get galleryImport;

  /// Manuell erfasst Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Entered manually'**
  String get enteredManually;

  /// Neuer Projektabschnitt Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'New project section'**
  String get newProjectSection;

  /// Projekt neu begonnen Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Project restarted'**
  String get projectRestarted;

  /// Korrektur eines früheren Projektstands Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Correction of an earlier entry'**
  String get correctionOfAnEarlierEntry;

  /// Anderer Grund Context: lib/features/meters/domain/meter_reading.dart
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get otherReason;

  /// Stricken Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Knitting'**
  String get knitting;

  /// Häkeln Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Crochet'**
  String get crochet;

  /// Reihen Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Rows'**
  String get rows;

  /// Runden Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// Runde Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// Reihe Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Row'**
  String get row;

  /// Aktuelle {p0} Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Current {p0}'**
  String current(String p0);

  /// Minütlich (Dev) Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Every minute (Dev)'**
  String get everyMinuteDev;

  /// Stündlich Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get hourly;

  /// Täglich Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// Wöchentlich Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// Monatlich Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// Jährlich Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// Normale Erinnerung Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Standard reminder'**
  String get standardReminder;

  /// Pünktlich mit Ton Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'On time with sound'**
  String get onTimeWithSound;

  /// Montag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// Dienstag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// Mittwoch Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// Donnerstag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// Freitag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// Samstag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// Sonntag Context: lib/features/meters/domain/meter.dart
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// Fotos werden vorbereitet … Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing photos…'**
  String get preparingPhotos;

  /// Fotos werden vorbereitet: {p0} von {p1} Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing photos: {p0} of {p1}'**
  String preparingPhotosOf(String p0, String p1);

  /// Foto wird entfernt … Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'Removing photo…'**
  String get removingPhoto;

  /// Die Fotoreihenfolge muss alle aktuellen Fotos enthalten. Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'The photo order must include all current photos.'**
  String get thePhotoOrderMustIncludeAllCurrentPhotos;

  /// Fotoreihenfolge wird gesichert … Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'Saving photo order…'**
  String get savingPhotoOrder;

  /// Ungespeicherte Fotos werden entfernt … Context: lib/features/meters/application/reading_photo_session.dart
  ///
  /// In en, this message translates to:
  /// **'Removing unsaved photos…'**
  String get removingUnsavedPhotos;

  /// Die Erinnerung konnte nicht ausgeschaltet werden. Bitte erneut versuchen. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'Could not turn off the reminder. Please try again.'**
  String get couldNotTurnOffTheReminderPleaseTryAgain;

  /// Ein Foto benötigt eine Kamera- oder Galeriequelle. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'A photo requires a camera or gallery source.'**
  String get aPhotoRequiresACameraOrGallerySource;

  /// Fotos und Einzelfoto-Ersatz nicht gleichzeitig übergeben. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'Do not supply photos and a single-photo replacement together.'**
  String get doNotSupplyPhotosAndASinglePhotoReplacement;

  /// Ein geändertes Foto benötigt eine neue Foto-ID. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'A changed photo requires a new photo ID.'**
  String get aChangedPhotoRequiresANewPhotoID;

  /// Fotos benötigen eindeutige IDs, Dateien und eine Fotoquelle. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'Photos require unique IDs, files and a photo source.'**
  String get photosRequireUniqueIDsFilesAndAPhotoSource;

  /// Bitte eine ganze Zahl ab 0 eingeben. Context: lib/features/meters/application/meter_services.dart
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number of 0 or more.'**
  String get enterAWholeNumberOf0OrMore;

  /// Ausschalten fehlgeschlagen Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Could not turn off'**
  String get couldNotTurnOff;

  /// Bitte öffne die Erinnerung und speichere erneut. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Open the reminder and save again.'**
  String get openTheReminderAndSaveAgain;

  /// Erinnerung blockiert Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder blocked'**
  String get reminderBlocked;

  /// Benachrichtigungen sind ausgeschaltet. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off.'**
  String get notificationsAreTurnedOff;

  /// Diese Erinnerungsart ist ausgeschaltet. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'This reminder category is turned off.'**
  String get thisReminderCategoryIsTurnedOff;

  /// Erinnerungen nicht unterstützt Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Reminders not supported'**
  String get remindersNotSupported;

  /// Auf diesem Gerät können keine Erinnerungen angezeigt werden. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'This device cannot show reminders.'**
  String get thisDeviceCannotShowReminders;

  /// Erinnerung nicht geplant Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder not scheduled'**
  String get reminderNotScheduled;

  /// Pünktlichkeit nicht erlaubt Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Exact timing not allowed'**
  String get exactTimingNotAllowed;

  /// Erlaube „Alarme & Erinnerungen“ in Android. Bis dahin kann die Erinnerung verspätet erscheinen. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Allow Alarms & reminders in Android. Until then, the reminder may arrive late.'**
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder;

  /// Pünktliche Planung ausstehend Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Exact scheduling pending'**
  String get exactSchedulingPending;

  /// Der Termin ist noch ungenau geplant. Öffne die Erinnerung und speichere erneut. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'The scheduled time is still approximate. Open the reminder and save again.'**
  String get theScheduledTimeIsStillApproximateOpenTheReminder;

  /// Letzte Zustellung fehlgeschlagen Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Last delivery failed'**
  String get lastDeliveryFailed;

  /// Bitte öffne die Erinnerung und nutze „Erinnerung jetzt testen“. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Open the reminder and choose Test reminder now.'**
  String get openTheReminderAndChooseTestReminderNow;

  /// Planungsstatus unbekannt Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Scheduling status unknown'**
  String get schedulingStatusUnknown;

  /// Der Erinnerungsstatus konnte nicht bestätigt werden. Öffne die Erinnerung zum Prüfen. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Could not confirm reminder status. Open the reminder to check.'**
  String get couldNotConfirmReminderStatusOpenTheReminderTo;

  /// Erinnerung steht noch aus Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder still pending'**
  String get reminderStillPending;

  /// Nächste Erinnerung Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Next reminder'**
  String get nextReminder;

  /// Einstellungen öffnen Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// Erinnerung bearbeiten Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Edit reminder'**
  String get editReminder;

  /// Die Einstellungen konnten nicht geöffnet werden. Suche in den Einstellungen deines Smartphones nach „Alarme & Erinnerungen“ und wähle diese App. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open settings. Search your phone settings for Alarms & reminders and select this app.'**
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor;

  /// Die Einstellungen konnten nicht geöffnet werden. Öffne in den Einstellungen deines Smartphones „Apps“, wähle diese App und dann „Benachrichtigungen“. Context: lib/features/meters/presentation/reminder_schedule_status.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open settings. Open Apps in your phone settings, select this app, then Notifications.'**
  String get couldNotOpenSettingsOpenAppsInYourPhone;

  /// Erfasst am {p0} Uhr Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'Recorded on {p0}'**
  String recordedOn(String p0);

  /// Erfasst · {p0} Uhr Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'Recorded · {p0}'**
  String recorded(String p0);

  /// Einheit seit diesem Projektstand gewechselt Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'Counting unit changed since this entry'**
  String get countingUnitChangedSinceThisEntry;

  /// {p0} Fotos zum Projektstand {p1} Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'{p0, plural, =0{0 photos for progress entry {p1}} one{One photo for progress entry {p1}} other{{p0} photos for progress entry {p1}}}'**
  String photosForProgressEntry(int p0, String p1);

  /// Manuell erfasst: {p0} Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'Entered manually: {p0}'**
  String enteredManually159(String p0);

  /// {p0} Fotos Context: lib/features/meters/presentation/reading_history_tile.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} photos'**
  String photos(String p0);

  /// Foto {p0} von {p1} ansehen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'View photo {p0} of {p1}'**
  String viewPhotoOf(String p0, String p1);

  /// Foto {p0} Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Photo {p0}'**
  String photo(String p0);

  /// Foto {p0} bearbeiten Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Edit photo {p0}'**
  String editPhoto(String p0);

  /// Nach vorne Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Move earlier'**
  String get moveEarlier;

  /// Nach hinten Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Move later'**
  String get moveLater;

  /// Foto ersetzen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Replace photo'**
  String get replacePhoto;

  /// Foto entfernen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// Keine aktuellen Fotos Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'No current photos'**
  String get noCurrentPhotos;

  /// Foto nicht verfügbar Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Photo unavailable'**
  String get photoUnavailable;

  /// Vorheriges Foto Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Previous photo'**
  String get previousPhoto;

  /// Nächstes Foto Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Next photo'**
  String get nextPhoto;

  /// Aktuelle Fotos ({p0}) Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Current photos ({p0})'**
  String currentPhotos(String p0);

  /// Zum Sortieren ein Foto länger gedrückt halten und verschieben. Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Touch and hold a photo, then drag it to reorder.'**
  String get touchAndHoldAPhotoThenDragItTo;

  /// Foto aufnehmen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// Weiteres Foto aufnehmen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Take another photo'**
  String get takeAnotherPhoto;

  /// Fotos aus Galerie hinzufügen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Add photos from gallery'**
  String get addPhotosFromGallery;

  /// Neu fotografieren Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Retake photo'**
  String get retakePhoto;

  /// Aus Galerie wählen Context: lib/features/meters/presentation/reading_photo_gallery.dart
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// Projektstand konnte nicht geladen werden. Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load progress entry.'**
  String get couldNotLoadProgressEntry;

  /// Projektstand nicht gefunden. Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry not found.'**
  String get progressEntryNotFound;

  /// Projektstand bearbeiten Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Edit progress entry'**
  String get editProgressEntry;

  /// Änderungen speichern Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// Änderungen verwerfen? Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChanges183;

  /// Deine Änderungen an diesem Projektstand wurden noch nicht gespeichert. Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your changes to this progress entry have not been saved.'**
  String get yourChangesToThisProgressEntryHaveNotBeen;

  /// Änderungen konnten nicht verworfen werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not discard changes: {p0}'**
  String couldNotDiscardChanges(String p0);

  /// {p0} Fotos hinzugefügt. Nicht verarbeitet: {p1} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0, plural, =0{No photos added.} one{One photo added.} other{{p0} photos added.}} Not processed: {p1}'**
  String photosAddedNotProcessed(int p0, String p1);

  /// Fotos konnten nicht hinzugefügt werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not add photos: {p0}'**
  String couldNotAddPhotos(String p0);

  /// Foto konnte nicht entfernt werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not remove photo: {p0}'**
  String couldNotRemovePhoto(String p0);

  /// Fotoreihenfolge konnte nicht gespeichert werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not save photo order: {p0}'**
  String couldNotSavePhotoOrder(String p0);

  /// Foto-Zwischenstand konnte nicht wiederhergestellt werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not restore photo draft: {p0}'**
  String couldNotRestorePhotoDraft(String p0);

  /// Änderungen gespeichert. Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Changes saved.'**
  String get changesSaved;

  /// Keine Änderungen vorhanden. Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No changes to save.'**
  String get noChangesToSave;

  /// Änderungen konnten nicht gespeichert werden: {p0} Context: lib/features/meters/presentation/edit_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not save changes: {p0}'**
  String couldNotSaveChanges(String p0);

  /// Einstellungen Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Projekt anlegen Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Create project'**
  String get createProject;

  /// Zuletzt bearbeitet Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Last edited'**
  String get lastEdited;

  /// Name A–Z Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Name A–Z'**
  String get nameAZ;

  /// Deine Projekte Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your projects'**
  String get yourProjects;

  /// Deine Projekte, dein Tempo. Merke dir, wo du weitermachst. Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your projects, your pace. Remember where to pick up.'**
  String get yourProjectsYourPaceRememberWhereToPickUp;

  /// Projekte suchen Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Search projects'**
  String get searchProjects;

  /// Name, Technik, Garn oder Nadelstärke Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Name, technique, yarn or needle size'**
  String get nameTechniqueYarnOrNeedleSize;

  /// Suche löschen Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// 1 Projekt Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'1 project'**
  String get text1Project;

  /// {p0} Projekte Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} projects'**
  String projects(String p0);

  /// Noch kein Projektstand Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No progress entries yet'**
  String get noProgressEntriesYet;

  /// Zuletzt bearbeitet: {p0} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Last edited: {p0}'**
  String lastEdited206(String p0);

  /// Erinnern: {p0} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder: {p0}'**
  String reminder(String p0);

  /// Letzte Erinnerung: noch keine Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Last reminder: none yet'**
  String get lastReminderNoneYet;

  /// Letzte Erinnerung: {p0} Uhr Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Last reminder: {p0}'**
  String lastReminder(String p0);

  /// minütlich (Dev) Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'every minute (Dev)'**
  String get everyMinuteDev210;

  /// stündlich ab {p0} Uhr Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'hourly from {p0}'**
  String hourlyFrom(String p0);

  /// täglich um {p0} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'daily at {p0}'**
  String dailyAt(String p0);

  /// wöchentlich am {p0} um {p1} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'weekly on {p0} at {p1}'**
  String weeklyOnAt(String p0, String p1);

  /// monatlich am {p0}. um {p1} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'monthly on day {p0} at {p1}'**
  String monthlyOnDayAt(String p0, String p1);

  /// jährlich am {p0}.{p1}. um {p2} Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'yearly on {p0}/{p1} at {p2}'**
  String yearlyOnAt(String p0, String p1, String p2);

  /// {p0} · pünktlich mit Ton Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} · on time with sound'**
  String onTimeWithSound216(String p0);

  /// Keine passenden Projekte gefunden. Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No matching projects found.'**
  String get noMatchingProjectsFound;

  /// Erstes Projekt anlegen Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Create your first project'**
  String get createYourFirstProject;

  /// Vom ersten Anschlag bis zur letzten Masche: Halte fest, bei welcher Reihe oder Runde du weitermachst – mit Fotos und Notizen, ganz für dich. Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'From the first stitch to the last: remember which row or round to continue with, using photos and notes just for you.'**
  String get fromTheFirstStitchToTheLastRememberWhich;

  /// Erneut laden Context: lib/features/meters/presentation/home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// Projekt konnte nicht geladen werden. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load project.'**
  String get couldNotLoadProject;

  /// Projekt nicht gefunden. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project not found.'**
  String get projectNotFound;

  /// Projekt bearbeiten Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProject;

  /// Projektname * Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project name *'**
  String get projectName224;

  /// Bitte einen Projektname eingeben. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Enter a project name.'**
  String get enterAProjectName;

  /// Garn (optional) Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Yarn (optional)'**
  String get yarnOptional;

  /// Nadelstärke (optional) Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Needle or hook size (optional)'**
  String get needleOrHookSizeOptional;

  /// Zählweise * Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Counting unit *'**
  String get countingUnit228;

  /// Projekterinnerung Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project reminder'**
  String get projectReminder;

  /// Optional und nur lokal auf diesem Gerät Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Optional and only on this device'**
  String get optionalAndOnlyOnThisDevice;

  /// Intervall Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get interval;

  /// Monat Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// Wochentag Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Day of week'**
  String get dayOfWeek;

  /// Tag Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// Dev-Modus: Die nächste Erinnerung wird zum Beginn der nächsten Minute geplant. Normale Erinnerungen können leicht verzögert erscheinen. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Dev mode: the next reminder is scheduled for the start of the next minute. Standard reminders may arrive slightly late.'**
  String get devModeTheNextReminderIsScheduledForThe;

  /// Startdatum Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// Datum ändern Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Change date'**
  String get changeDate;

  /// Startzeit Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get startTime;

  /// Uhrzeit ändern Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Change time'**
  String get changeTime;

  /// Ab dem gewählten Start alle 60 Minuten. Nächste Erinnerung: {p0} Uhr. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Every 60 minutes from the selected start. Next reminder: {p0}.'**
  String every60MinutesFromTheSelectedStartNextReminder(String p0);

  /// Uhrzeit Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Art der Erinnerung Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder type'**
  String get reminderType;

  /// Kann leicht verzögert erscheinen. Die Systemeinstellung „Nicht stören“ wird berücksichtigt. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'May arrive slightly late. Respects the system Do Not Disturb setting.'**
  String get mayArriveSlightlyLateRespectsTheSystemDoNot;

  /// Wird möglichst genau zur gewählten Uhrzeit wie ein Alarm ausgelöst. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Triggers as close as possible to the selected time, like an alarm.'**
  String get triggersAsCloseAsPossibleToTheSelectedTime;

  /// „Alarme & Erinnerungen“ öffnen Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Open Alarms & reminders'**
  String get openAlarmsReminders;

  /// Erinnerung jetzt testen Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Test reminder now'**
  String get testReminderNow;

  /// Prüfe beim Test die Benachrichtigungsleiste. Die Test-Erinnerung wird nach einer Minute automatisch entfernt. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Check the notification shade during the test. The test reminder is automatically removed after one minute.'**
  String get checkTheNotificationShadeDuringTheTestTheTest;

  /// Die Erinnerung ist nicht bestätigt. Mit Speichern wird sie erneut eingerichtet. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The reminder is not confirmed. Saving will set it up again.'**
  String get theReminderIsNotConfirmedSavingWillSetIt;

  /// Wird gespeichert … Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// Alles gespeichert Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Everything saved'**
  String get everythingSaved;

  /// Erinnerung erneut speichern Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Save reminder again'**
  String get saveReminderAgain;

  /// Projekt speichern Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Save project'**
  String get saveProject;

  /// Eingaben verwerfen? Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard input?'**
  String get discardInput;

  /// Deine Änderungen an diesem Projekt wurden noch nicht gespeichert. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your changes to this project have not been saved.'**
  String get yourChangesToThisProjectHaveNotBeenSaved;

  /// Deine Eingaben für das neue Projekt wurden noch nicht gespeichert. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your new project details have not been saved.'**
  String get yourNewProjectDetailsHaveNotBeenSaved;

  /// Eingaben verwerfen Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard input'**
  String get discardInput256;

  /// Für „Pünktlich mit Ton“ fehlt die Android-Berechtigung. Bitte den Modus erneut auswählen und erlauben. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Android permission for On time with sound is missing. Select the mode again and grant permission.'**
  String get androidPermissionForOnTimeWithSoundIsMissing;

  /// Projekt gespeichert. Erinnerungen sind in Android blockiert. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project saved. Reminders are blocked in Android.'**
  String get projectSavedRemindersAreBlockedInAndroid;

  /// Projekt gespeichert. Als Nächstes kannst du den ersten Projektstand erfassen. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project saved. You can now add your first progress entry.'**
  String get projectSavedYouCanNowAddYourFirstProgress;

  /// Änderungen am Projekt gespeichert. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project changes saved.'**
  String get projectChangesSaved;

  /// Speichern fehlgeschlagen: {p0} Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not save: {p0}'**
  String couldNotSave(String p0);

  /// Diese Uhrzeit ist wegen der Zeitumstellung nicht verfügbar. Bitte wähle eine andere Uhrzeit. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'This time is unavailable due to the daylight saving change. Choose another time.'**
  String get thisTimeIsUnavailableDueToTheDaylightSaving;

  /// Die Android-Einstellung „Alarme & Erinnerungen“ konnte nicht geöffnet werden. „Pünktlich mit Ton“ bleibt ausgewählt. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open Android Alarms & reminders settings. On time with sound remains selected.'**
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime;

  /// Die Android-Einstellung „Alarme & Erinnerungen“ ist auf diesem Gerät nicht verfügbar. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Android Alarms & reminders settings are unavailable on this device.'**
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice;

  /// Nach dem Speichern kannst du unter  Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'After saving, use '**
  String get afterSavingUse;

  ///  deinen ersten Projektstand erfassen und protokollieren. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **' to add and record your first progress entry.'**
  String get toAddAndRecordYourFirstProgressEntry;

  /// Für pünktliche Erinnerungen muss Android „Alarme & Erinnerungen“ erlauben. Aktiviere die Freigabe, damit die Erinnerung zuverlässig zur gewählten Zeit mit Ton erscheint. Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Android must allow Alarms & reminders for on-time reminders. Grant access so the reminder can sound at the selected time.'**
  String get androidMustAllowAlarmsRemindersForOnTimeReminders;

  /// Alarme & Erinnerungen erlauben Context: lib/features/meters/presentation/meter_form_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Allow Alarms & reminders'**
  String get allowAlarmsReminders;

  /// Benachrichtigungen sind ausgeschaltet Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off'**
  String get notificationsAreTurnedOff269;

  /// Diese Erinnerungsart ist ausgeschaltet Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'This reminder category is turned off'**
  String get thisReminderCategoryIsTurnedOff270;

  /// „Nicht stören“ ist aktiv Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb is on'**
  String get doNotDisturbIsOn;

  /// Android blockiert Benachrichtigungen für Strick & Häkelbuch. Du kannst sie in den Android-Einstellungen erlauben. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Android is blocking notifications for Strick & Häkelbuch. You can allow them in Android settings.'**
  String get androidIsBlockingNotificationsForStrickHKelbuchYou;

  /// Android blockiert „{p0}“. Du kannst diese Kategorie in den Android-Einstellungen einschalten. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Android is blocking “{p0}”. You can enable this category in Android settings.'**
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0);

  /// Projekterinnerungen Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Project reminders'**
  String get projectReminders;

  /// Pünktliche Projekterinnerungen Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'On-time project reminders'**
  String get onTimeProjectReminders;

  /// Normale Erinnerungen können ohne Ton oder eingeblendetes Banner erscheinen. Prüfe auch die Benachrichtigungsleiste. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Standard reminders may appear without sound or a banner. Check the notification shade too.'**
  String get standardRemindersMayAppearWithoutSoundOrABanner;

  /// Ob ein Alarmton oder Banner erscheint, hängt von deinen „Nicht stören“-Einstellungen und der Alarmlautstärke ab. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Alarm sound and banners depend on your Do Not Disturb settings and alarm volume.'**
  String get alarmSoundAndBannersDependOnYourDoNot;

  /// Android-Einstellungen öffnen Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Open Android settings'**
  String get openAndroidSettings;

  /// „Nicht stören“ öffnen Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Open Do Not Disturb'**
  String get openDoNotDisturb;

  /// Die Systemeinstellungen konnten nicht geöffnet werden. Suche in den Einstellungen deines Smartphones nach „Nicht stören“. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open system settings. Search your phone settings for Do Not Disturb.'**
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings;

  /// Die Systemeinstellungen konnten nicht geöffnet werden. Öffne in den Einstellungen deines Smartphones „Apps“, dann „Strick & Häkelbuch“ und „Benachrichtigungen“. Context: lib/features/meters/presentation/reminder_delivery_hint.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open system settings. In your phone settings, open Apps, then Strick & Häkelbuch, then Notifications.'**
  String get couldNotOpenSystemSettingsInYourPhoneSettings;

  /// Fotos sortieren Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Sort photos'**
  String get sortPhotos;

  /// Projektprotokoll · Einzelner Projektstand Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project report · Single entry'**
  String get projectReportSingleEntry;

  /// Projektstand und Notizen werden für die kompakte PDF zusammengestellt. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing the progress entry and notes for the compact PDF.'**
  String get preparingTheProgressEntryAndNotesForTheCompact;

  /// Die aktuellen Fotos, der Projektstand und die Notizen werden für die PDF zusammengestellt. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing current photos, progress and notes for the PDF.'**
  String get preparingCurrentPhotosProgressAndNotesForThePDF;

  /// PDF konnte nicht erstellt werden: {p0} Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not create PDF: {p0}'**
  String couldNotCreatePDF(String p0);

  /// Die gespeicherte PDF-Datei fehlt. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The saved PDF file is missing.'**
  String get theSavedPDFFileIsMissing;

  /// Projektprotokoll löschen? Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Delete project report?'**
  String get deleteProjectReport288;

  /// Die PDF wird dauerhaft aus Strick & Häkelbuch gelöscht. Bereits geteilte oder außerhalb der App gespeicherte Kopien bleiben erhalten. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The PDF will be permanently deleted from Strick & Häkelbuch. Copies already shared or saved outside the app will remain.'**
  String get thePDFWillBePermanentlyDeletedFromStrickH;

  /// Projektprotokoll gelöscht. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project report deleted.'**
  String get projectReportDeleted;

  /// Projektprotokoll konnte nicht gelöscht werden. Bitte versuche es erneut. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not delete project report. Please try again.'**
  String get couldNotDeleteProjectReportPleaseTryAgain;

  /// Projektstand löschen? Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Delete progress entry?'**
  String get deleteProgressEntry;

  /// Projektstand, alle zugehörigen Anhänge und Einzel-PDFs dieses Projektstands werden dauerhaft gelöscht. Gespeicherte Verlaufs-PDFs bleiben erhalten. Bereits außerhalb der App gespeicherte Kopien bleiben bestehen. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'This entry, its attachments and its individual PDFs will be permanently deleted. Saved history PDFs and copies outside the app will remain.'**
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill;

  /// Projektstand gelöscht. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry deleted.'**
  String get progressEntryDeleted;

  /// Projektstand konnte nicht vollständig gelöscht werden. Bitte versuche es erneut. Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not completely delete the progress entry. Please try again.'**
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry;

  /// Projektprotokoll dieses Projektstands Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Report for this progress entry'**
  String get reportForThisProgressEntry;

  /// Projektprotokoll als PDF erstellen Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Create project report as PDF'**
  String get createProjectReportAsPDF;

  /// Bearbeiten Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Projektstand löschen Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Delete progress entry'**
  String get deleteProgressEntry299;

  /// Quelle Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// Niedrigerer Stand Context: lib/features/meters/presentation/reading_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Lower count'**
  String get lowerCount301;

  /// Projekt Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// Projektstände konnten nicht geladen werden. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load progress entries.'**
  String get couldNotLoadProgressEntries;

  /// Projektstand erfassen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Record progress'**
  String get recordProgress;

  /// {p0} von {p1} Projektständen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} of {p1} progress entries'**
  String ofProgressEntries(String p0, String p1);

  /// Alle Projektstände anzeigen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Show all progress entries'**
  String get showAllProgressEntries;

  /// Projektstände und Notizen werden für die kompakte PDF zusammengestellt. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing progress entries and notes for the compact PDF.'**
  String get preparingProgressEntriesAndNotesForTheCompactPDF;

  /// Projektstände, aktuelle Fotos und Notizen werden für die PDF zusammengestellt. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing progress entries, current photos and notes for the PDF.'**
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe;

  /// Projekt löschen? Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Delete project?'**
  String get deleteProject;

  /// Alle Projektstände, Projektstandfotos und lokal gespeicherten Projektprotokolle dieses Projekts werden dauerhaft entfernt. Bereits extern geteilte Dateien bleiben bestehen. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'All progress entries, progress photos and locally saved reports for this project will be permanently removed. Files already shared outside the app will remain.'**
  String get allProgressEntriesProgressPhotosAndLocallySavedReports;

  /// Projekt gelöscht. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project deleted.'**
  String get projectDeleted;

  /// Projekt konnte nicht vollständig gelöscht werden. Bitte versuche es erneut. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not completely delete the project. Please try again.'**
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain;

  /// Projekt & Erinnerung bearbeiten Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Edit project & reminder'**
  String get editProjectReminder;

  /// Projekt löschen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Delete project'**
  String get deleteProject314;

  /// Projektprotokoll für den Projektverlauf erstellen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Create report for project history'**
  String get createReportForProjectHistory;

  /// Zuletzt am {p0} Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Last recorded on {p0}'**
  String lastRecordedOn(String p0);

  /// Garn: {p0} Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Yarn: {p0}'**
  String yarn317(String p0);

  /// Nadelstärke: {p0} Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Needle or hook size: {p0}'**
  String needleOrHookSize318(String p0);

  /// Erinnerung: {p0} Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Reminder: {p0}'**
  String reminder319(String p0);

  /// Noch kein Projektstand. Trage deine aktuelle Reihe oder Runde ein – mit oder ohne Projektfoto. Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No progress entry yet. Enter your current row or round, with or without a project photo.'**
  String get noProgressEntryYetEnterYourCurrentRowOr;

  /// Ersten Projektstand erfassen Context: lib/features/meters/presentation/meter_detail_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Record first progress entry'**
  String get recordFirstProgressEntry;

  /// Datum & Uhrzeit ändern Context: lib/features/meters/presentation/editable_reading_time_card.dart
  ///
  /// In en, this message translates to:
  /// **'Change date & time'**
  String get changeDateTime;

  /// Stand eintragen Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Enter progress'**
  String get enterProgress;

  /// Projekt fotografieren Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Photograph project'**
  String get photographProject;

  /// Fotos aus Galerie Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Photos from gallery'**
  String get photosFromGallery;

  /// Foto wird vorbereitet … Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing photo…'**
  String get preparingPhoto;

  /// Trage ein, wo du gerade aufgehört hast. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Enter where you left off.'**
  String get enterWhereYouLeftOff;

  /// Optional, z. B. mit dem Ärmel begonnen Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Optional, e.g. started the sleeve'**
  String get optionalEGStartedTheSleeve;

  /// Projektstand speichern Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Save progress entry'**
  String get saveProgressEntry;

  /// Projektstand bestätigen und speichern Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Confirm and save progress'**
  String get confirmAndSaveProgress;

  /// Projektstand verwerfen? Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard progress entry?'**
  String get discardProgressEntry;

  /// Dein Projektstand und die ausgewählten Fotos wurden noch nicht gespeichert. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your progress entry and selected photos have not been saved.'**
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen;

  /// Projektstand verwerfen Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard progress entry'**
  String get discardProgressEntry333;

  /// Die ungespeicherten Fotos konnten nicht entfernt werden. Bitte versuche es erneut. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not remove unsaved photos. Please try again.'**
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain;

  /// Projektstand gespeichert. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entry saved.'**
  String get progressEntrySaved;

  /// Hier machst du weiter Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Pick up from here'**
  String get pickUpFromHere;

  /// Merke dir deine aktuelle Reihe oder Runde. Fotos halten fest, wie dein Projekt gerade aussieht. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Remember your current row or round. Photos capture how your project looks right now.'**
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow;

  /// Deinen Stand trägst du selbst ein. Fotos und Notizen bleiben auf deinem Gerät. Context: lib/features/meters/presentation/capture_reading_screen.dart
  ///
  /// In en, this message translates to:
  /// **'You enter your progress yourself. Photos and notes stay on your device.'**
  String get youEnterYourProgressYourselfPhotosAndNotesStay;

  /// Stricken · Schal Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Knitting · Scarf'**
  String get knittingScarf;

  /// Lege dein Projekt flach hin, damit Form und Muster gut sichtbar sind. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Lay your project flat so its shape and pattern are clearly visible.'**
  String get layYourProjectFlatSoItsShapeAndPattern;

  /// Stricken · Mütze in Runden Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Knitting · Hat in the round'**
  String get knittingHatInTheRound;

  /// Zeige auch die aktive Nadel und den markierten Rundenanfang. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Include the working needle and the marked start of the round.'**
  String get includeTheWorkingNeedleAndTheMarkedStartOf;

  /// Häkeln · Granny Square Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Crochet · Granny square'**
  String get crochetGrannySquare;

  /// Fotografiere das ganze Motiv mit der Stelle, an der du weiterhäkelst. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Photograph the whole motif, including where you will continue.'**
  String get photographTheWholeMotifIncludingWhereYouWillContinue;

  /// Häkeln · Körbchen in Runden Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Crochet · Basket in the round'**
  String get crochetBasketInTheRound;

  /// Ein leicht schräger Blick zeigt den Boden, die Höhe und den Arbeitsrand. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'A slightly angled view shows the base, height and working edge.'**
  String get aSlightlyAngledViewShowsTheBaseHeightAnd;

  /// Beispiele ansehen Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'View examples'**
  String get viewExamples;

  /// Beispielfotos Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Example photos'**
  String get examplePhotos;

  /// Schließen Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Halte dein Projekt bei gutem Licht fest. Deine aktuelle Reihe oder Runde trägst du selbst ein. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Photograph your project in good light. Enter the current row or round yourself.'**
  String get photographYourProjectInGoodLightEnterTheCurrent;

  /// Beispielfoto: {p0} Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Example photo: {p0}'**
  String examplePhoto(String p0);

  /// Beispiel konnte nicht geladen werden. Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Could not load example.'**
  String get couldNotLoadExample;

  /// Vorheriges Beispiel Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Previous example'**
  String get previousExample;

  /// Nächstes Beispiel Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'Next example'**
  String get nextExample;

  /// Noch keine Projektstände vorhanden. Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No progress entries yet.'**
  String get noProgressEntriesYet356;

  /// Treffern Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'matches'**
  String get matches;

  /// Projektständen Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'progress entries'**
  String get progressEntries;

  /// {p0}–{p1} von {p2} {p3} Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0}–{p1} of {p2} {p3}'**
  String of359(String p0, String p1, String p2, String p3);

  /// Projektstände suchen Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Search progress entries'**
  String get searchProgressEntries;

  /// Datum, Reihe/Runde oder Notiz Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Date, row/round or note'**
  String get dateRowRoundOrNote;

  /// Kein passender Projektstand gefunden. Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'No matching progress entry found.'**
  String get noMatchingProgressEntryFound;

  /// Suche nach Datum, aktueller Reihe oder Runde oder einem Wort aus der Notiz. Context: lib/features/meters/presentation/meter_history_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Search by date, current row or round, or a word in the note.'**
  String get searchByDateCurrentRowOrRoundOrA;

  /// Die direkte Speicherortwahl ist auf dieser Plattform noch nicht verfügbar. Context: lib/features/backup/application/backup_file_exporter.dart
  ///
  /// In en, this message translates to:
  /// **'Choosing a save location is not yet available on this platform.'**
  String get choosingASaveLocationIsNotYetAvailableOn;

  /// Strick & Häkelbuch Backup Context: lib/features/backup/application/backup_file_exporter.dart
  ///
  /// In en, this message translates to:
  /// **'Strick & Häkelbuch backup'**
  String get strickHKelbuchBackup;

  /// Projekte Context: lib/features/backup/application/backup_file_exporter.dart
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects366;

  /// Projektstände Context: lib/features/backup/application/backup_file_exporter.dart
  ///
  /// In en, this message translates to:
  /// **'Progress entries'**
  String get progressEntries367;

  /// Datensicherung Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// Verschlüsseltes Backup erstellen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Create encrypted backup'**
  String get createEncryptedBackup;

  /// Projekte, Fotos, Projektprotokolle und Korrekturverläufe Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Projects, photos and project reports'**
  String get projectsPhotosAndProjectReports;

  /// Backup wiederherstellen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get restoreBackup;

  /// Vorhandene neuere Einträge bleiben erhalten Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Newer existing entries are preserved'**
  String get newerExistingEntriesArePreserved;

  /// Datenschutz Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// Fotos, Projektstände und PDFs werden lokal auf deinem Gerät verarbeitet. Die App überträgt deine Projektdaten nicht an einen Server. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Photos, progress entries and PDFs are processed locally on your device. The app does not send your project data to a server.'**
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn;

  /// Deine Daten bleiben lokal auf deinem Gerät gespeichert, bis du sie in der App löschst oder die App-Daten entfernst. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your device until you delete it in the app or remove the app data.'**
  String get yourDataStaysOnYourDeviceUntilYouDelete;

  /// Entwickler und Datenschutzkontakt
  /// Wasiliy Strecker · AppFabrik AI Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Developer and privacy contact\nWasiliy Strecker · AppFabrik AI'**
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI;

  /// Datenschutzerklärung öffnen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Open privacy policy'**
  String get openPrivacyPolicy;

  /// Über Strick & Häkelbuch Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'About Strick & Häkelbuch'**
  String get aboutStrickHKelbuch;

  /// Open Source · MPL 2.0 Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Open source · MPL 2.0'**
  String get openSourceMPL20;

  /// Die Datenschutzerklärung konnte nicht geöffnet werden. Bitte versuche es erneut. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open the privacy policy. Please try again.'**
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain;

  /// Dateien werden vorbereitet … Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing files…'**
  String get preparingFiles;

  /// Backup konnte nicht erstellt werden: {p0} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not create backup: {p0}'**
  String couldNotCreateBackup(String p0);

  /// Backup wird gespeichert … Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Saving backup…'**
  String get savingBackup;

  /// Backup konnte nicht geteilt werden: {p0} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not share backup: {p0}'**
  String couldNotShareBackup(String p0);

  /// Backup gespeichert Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Backup saved'**
  String get backupSaved;

  /// {p0} wurde im gewählten Speicherort abgelegt. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} was saved to the selected location.'**
  String wasSavedToTheSelectedLocation(String p0);

  /// {p0} · {p1} · {p2}
  /// {p3} MB · Erstellt am {p4} Uhr Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} · {p1} · {p2}\n{p3} MB · Created on {p4}'**
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4);

  /// Projektprotokolle Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Project reports'**
  String get projectReports;

  /// Fertig Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Backup konnte nicht gespeichert werden Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not save backup'**
  String get couldNotSaveBackup;

  /// Backup noch nicht gespeichert Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Backup not saved yet'**
  String get backupNotSavedYet;

  /// Die verschlüsselte Datei liegt nur vorübergehend in der App. Wähle einen Speicherort, damit das Backup erhalten bleibt. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The encrypted file is only stored temporarily in the app. Choose a save location to keep the backup.'**
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe;

  /// Backup verwerfen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Discard backup'**
  String get discardBackup;

  /// Speicherort wählen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Choose save location'**
  String get chooseSaveLocation;

  /// Bitte wähle eine Strick & Häkelbuch-Backup-Datei (.shbackup). Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Choose a Strick & Häkelbuch backup file (.shbackup).'**
  String get chooseAStrickHKelbuchBackupFileShbackup;

  /// Die ausgewählte Backup-Datei konnte nicht geöffnet werden. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not open the selected backup file.'**
  String get couldNotOpenTheSelectedBackupFile;

  /// Backup-Datei konnte nicht ausgewählt werden: {p0} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not select backup file: {p0}'**
  String couldNotSelectBackupFile(String p0);

  /// Backup wird geprüft … Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Checking backup…'**
  String get checkingBackup;

  /// Backup wiederherstellen? Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Restore backup?'**
  String get restoreBackup402;

  /// {p0}, {p1} und {p2} werden importiert. Neuere lokale Einträge werden nicht überschrieben. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0}, {p1} and {p2} will be imported. Newer local entries will not be overwritten.'**
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  );

  /// Wiederherstellen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// Backup wird wiederhergestellt … Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Restoring backup…'**
  String get restoringBackup;

  /// {p0} und {p1} wiederhergestellt. {p2} unveränderte oder neuere Einträge übersprungen.{p3}{p4} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Restored {p0} and {p1}. Skipped {p2} unchanged or newer entries.{p3}{p4}'**
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  );

  /// Foto Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo407;

  /// Fotos Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos408;

  ///  Bei {p0} Einträgen konnte die Erinnerung nicht bestätigt werden. Bitte prüfe die Erinnerungen in der Übersicht. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **' Reminders could not be confirmed for {p0} entries. Check reminders in the overview.'**
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0);

  /// Backup konnte nicht wiederhergestellt werden: {p0} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Could not restore backup: {p0}'**
  String couldNotRestoreBackup(String p0);

  /// Das Passwort muss mindestens 6 Zeichen lang sein. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The password must have at least 6 characters.'**
  String get thePasswordMustHaveAtLeast6Characters;

  /// Das Passwort ist falsch oder das Backup wurde verändert. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The password is incorrect or the backup has been changed.'**
  String get thePasswordIsIncorrectOrTheBackupHasBeen;

  /// Eine zu sichernde Datei fehlt: {p0} Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'A file to back up is missing: {p0}'**
  String aFileToBackUpIsMissing(String p0);

  /// Eine Datei im Backup ist beschädigt oder unvollständig. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'A file in the backup is damaged or incomplete.'**
  String get aFileInTheBackupIsDamagedOrIncomplete;

  /// Diese Backup-Version wird nicht unterstützt. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'This backup version is not supported.'**
  String get thisBackupVersionIsNotSupported;

  /// Die ausgewählte Datei ist kein gültiges Strick & Häkelbuch-Backup. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'The selected file is not a valid Strick & Häkelbuch backup.'**
  String get theSelectedFileIsNotAValidStrickH;

  /// Dateien werden vorbereitet Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Preparing files'**
  String get preparingFiles417;

  /// Backup wird verschlüsselt Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Encrypting backup'**
  String get encryptingBackup;

  /// Backup wird abgeschlossen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Finishing backup'**
  String get finishingBackup;

  /// Backup ist bereit Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Backup ready'**
  String get backupReady;

  /// Bitte einen Moment warten. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Please wait a moment.'**
  String get pleaseWaitAMoment;

  /// Fotos und Projektprotokolle werden zusammengestellt. Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Gathering photos and project reports.'**
  String get gatheringPhotosAndProjectReports;

  /// {p0} von {p1} Dateien Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} of {p1} files'**
  String ofFiles(String p0, String p1);

  /// Backup-Passwort festlegen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Set backup password'**
  String get setBackupPassword;

  /// Passwort Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Mindestens 6 Zeichen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get atLeast6Characters;

  /// Passwort wiederholen Context: lib/features/backup/presentation/settings_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **' {p0} = {p1}'**
  String progressEquation(String p0, String p1);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'– (unit changed)'**
  String get unitChanged;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} project report} other{{count} project reports}}'**
  String reportCount(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} progress entry} other{{count} progress entries}}'**
  String entryCount(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} project} other{{count} projects}}'**
  String projectCount(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} photo} other{{count} photos}}'**
  String photoCount(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} match} other{{count} matches}}'**
  String matchCount(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} progress entry included} other{{count} progress entries included}}'**
  String includedEntries(int count);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{p0}{p1}'**
  String reminderDeadline(String p0, String p1);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'. Android has not processed this reminder yet.'**
  String get reminderNotProcessed;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'{p0} {p1} → {p2} = {p3} {p4}'**
  String progressChange(String p0, String p1, String p2, String p3, String p4);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'e.g. My sage sweater'**
  String get projectNameExample;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'e.g. Merino wool, sage'**
  String get yarnExample;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'e.g. {size} mm'**
  String needleSizeExample(String size);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'“Record progress”'**
  String get recordProgressQuoted;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'AI-generated examples · for viewing only'**
  String get examplePhotoDisclaimer;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **' Repaired {p0}.'**
  String repairedFiles(String p0);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Backup password'**
  String get backupPassword;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get systemLanguage;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Numbers and dates continue to follow your device region.'**
  String get languageHelp;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Could not save the language. Please try again.'**
  String get languageSaveFailed;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Could not complete the operation. Please try again.'**
  String get unexpectedError;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match.'**
  String get passwordMismatch;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Current row'**
  String get currentRow;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Current round'**
  String get currentRound;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Last progress: {value} {unit}'**
  String lastProgress(String value, String unit);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Record your current row or round and pick up comfortably later.'**
  String get reminderBody;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Test: {technique} · {name}'**
  String testNotificationTitle(String technique, String name);

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'This is a test reminder. Tap to open the app.'**
  String get testNotificationApp;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'This is a test reminder. Tap to open the project.'**
  String get testNotificationProject;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'Optional reminders to record project progress regularly.'**
  String get normalChannelDescription;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'On-time project reminders with an alarm sound.'**
  String get exactChannelDescription;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'progress'**
  String get reportFilePrefix;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'project_history'**
  String get historyFilePrefix;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'compact'**
  String get compactFilePart;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'with_photos'**
  String get photosFilePart;

  /// Application text. Preserve the meaning of placeholders.
  ///
  /// In en, this message translates to:
  /// **'yearly on {date} at {time}'**
  String annualReminder(String date, String time);

  /// {p0} von {p1} Context: lib/features/meters/presentation/project_photo_examples.dart
  ///
  /// In en, this message translates to:
  /// **'{p0} of {p1}'**
  String positionOfTotal(String p0, String p1);

  /// Unit label for an exact quantity. Count is a safe plural-category representative, never the displayed value.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Row} other{Rows}}'**
  String rowQuantityUnit(num count);

  /// Unit label for an exact quantity. Count is a safe plural-category representative, never the displayed value.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Round} other{Rounds}}'**
  String roundQuantityUnit(num count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
