// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get delete => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get continueEditing => 'Weiter bearbeiten';

  @override
  String get creatingProjectReport => 'Projektprotokoll wird erstellt';

  @override
  String get pleaseWait => 'Bitte kurz warten …';

  @override
  String testReminderSentToAndroidOpenTheNotificationShade(String p0) {
    return 'Test-Erinnerung wurde an Android übergeben. Ziehe die Benachrichtigungsleiste herunter. Die Test-Erinnerung verschwindet nach einer Minute.$p0';
  }

  @override
  String get doNotDisturbIsOnSoundAndBannersMay =>
      ' „Nicht stören“ ist aktiv. Ton und Banner können unterdrückt werden.';

  @override
  String get notificationsAreNotAllowed =>
      'Benachrichtigungen sind nicht erlaubt.';

  @override
  String get thisReminderCategoryIsBlockedInAndroid =>
      'Diese Erinnerungsart ist in Android gesperrt.';

  @override
  String get couldNotShowTheTestReminder =>
      'Test-Erinnerung konnte nicht angezeigt werden.';

  @override
  String get testRemindersAreNotSupportedOnThisDevice =>
      'Test-Erinnerungen werden auf diesem Gerät nicht unterstützt.';

  @override
  String get anHourlyReminderRequiresAStartTime =>
      'Die stündliche Erinnerung benötigt einen Startzeitpunkt.';

  @override
  String get dataSavedCouldNotTurnOffTheReminderOpen =>
      'Daten gespeichert. Die Erinnerung konnte nicht ausgeschaltet werden. Öffne die Erinnerung und speichere erneut.';

  @override
  String get dataSavedRemindersAreBlockedInAndroidOpenThe =>
      'Daten gespeichert. Erinnerungen sind in Android blockiert. Öffne die Erinnerung und dann die Android-Einstellungen.';

  @override
  String get dataSavedRemindersAreNotSupportedOnThisDevice =>
      'Daten gespeichert. Erinnerungen werden auf diesem Gerät nicht unterstützt.';

  @override
  String get dataSavedTheReminderCouldNotBeConfirmedOpen =>
      'Daten gespeichert. Die Erinnerung konnte nicht bestätigt werden. Öffne die Erinnerung und speichere erneut.';

  @override
  String get dataSavedForAnOnTimeReminderOpenAlarms =>
      'Daten gespeichert. Für eine pünktliche Erinnerung öffne „Alarme & Erinnerungen“ in den Android-Einstellungen.';

  @override
  String get dataSavedCouldNotCheckReminderStatusOpenThe =>
      'Daten gespeichert. Der Erinnerungsstatus konnte nicht geprüft werden. Öffne die Erinnerung und speichere erneut.';

  @override
  String get whatIsTheProjectReportFor => 'Wozu dient das Projektprotokoll?';

  @override
  String get beforeCreatingItChooseACompactReportWithoutPhotos =>
      'Du wählst vor dem Erstellen: kompakt ohne Fotos oder mit allen aktuellen Fotos. Projektstand, Zeitpunkt und Notizen sind in beiden Varianten enthalten – zum Speichern, Drucken oder Teilen.';

  @override
  String get itRecordsYourProjectProgressUsingTheInformationYou =>
      'Es dokumentiert deinen Projektfortschritt anhand deiner bestätigten Angaben.';

  @override
  String get thePDFBringsTogetherAllProgressEntriesAndNotes =>
      'Die PDF bündelt alle Projektstände mit Fortschritt und Notizen. Du wählst: kompakt ohne Fotos oder mit allen aktuellen Fotos jedes Projektstands – zum Speichern, Drucken oder Teilen.';

  @override
  String get personalRecordOfYourProjectProgress =>
      'Private Dokumentation deines Projektfortschritts.';

  @override
  String get couldNotSaveThePhotoDraft =>
      'Der Foto-Zwischenstand konnte nicht gesichert werden.';

  @override
  String get couldNotRemoveThePhotoDraft =>
      'Der Foto-Zwischenstand konnte nicht entfernt werden.';

  @override
  String get manualEntryDoesNotAccessPhotos =>
      'Eine manuelle Erfassung verwendet keinen Fotozugriff.';

  @override
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt =>
      'Das Foto konnte nicht sicher optimiert werden. Bitte wähle es erneut aus.';

  @override
  String get compactWithoutPhotos => 'Kompakt ohne Fotos';

  @override
  String get withCurrentPhotos => 'Mit aktuellen Fotos';

  @override
  String get withAllPhotosOlderVersion => 'Mit allen Fotos (ältere Version)';

  @override
  String get thisProjectHasNoProgressEntriesYet =>
      'Für dieses Projekt gibt es noch keine Projektstände.';

  @override
  String get theProgressEntriesDoNotBelongToThisProject =>
      'Die Projektstände gehören nicht zu diesem Projekt.';

  @override
  String get projectReport => 'Projektprotokoll';

  @override
  String get personalRecordOfProjectProgress =>
      'Private Dokumentation eines Projektstands';

  @override
  String pageOf(String p0, String p1) {
    return 'Seite $p0 von $p1';
  }

  @override
  String get singleProgressEntry => 'Einzelner Projektstand';

  @override
  String get projectHistory => 'Projektverlauf';

  @override
  String pdfCreatedOn(String p0, String p1) {
    return 'PDF erstellt am $p0 · $p1';
  }

  @override
  String get currentProjectDetails => 'Aktuelle Projektangaben';

  @override
  String get projectDetailsWhenRecorded => 'Projektangaben bei Erfassung';

  @override
  String get technique => 'Technik';

  @override
  String get projectName => 'Projektname';

  @override
  String get yarn => 'Garn';

  @override
  String get needleOrHookSize => 'Nadelstärke';

  @override
  String get countingUnit => 'Zählweise';

  @override
  String get no => 'Nr.';

  @override
  String get dateAndTime => 'Zeitpunkt';

  @override
  String get progressEntry => 'Projektstand';

  @override
  String get progress => 'Fortschritt';

  @override
  String get notSpecified => 'Nicht angegeben';

  @override
  String progressEntry53(String p0) {
    return 'Projektstand $p0';
  }

  @override
  String get progressDateAndTime => 'Zeitpunkt des Projektstands';

  @override
  String progressEntry55(String p0, String p1, String p2) {
    return 'Projektstand $p0 · $p1 · $p2';
  }

  @override
  String lowerCount(String p0) {
    return 'Niedrigerer Stand: $p0';
  }

  @override
  String get note => 'Notiz';

  @override
  String earlierPhoto(String p0) {
    return 'Früheres Foto $p0';
  }

  @override
  String photoOf(String p0, String p1) {
    return 'Foto $p0 von $p1';
  }

  @override
  String get couldNotEmbedTheProgressPhoto =>
      'Projektstandfoto konnte nicht eingebettet werden.';

  @override
  String get noPreparedPhotoFileAvailable =>
      'Keine vorbereitete Fotodatei vorhanden.';

  @override
  String createdOn(String p0) {
    return 'Erstellt am $p0 Uhr';
  }

  @override
  String get savedLocally => 'Lokal gespeichert';

  @override
  String get fileMissing => 'Datei fehlt';

  @override
  String get deleteProjectReport => 'Projektprotokoll löschen';

  @override
  String get savedProjectReports => 'Gespeicherte Projektprotokolle';

  @override
  String get couldNotLoadProjectReports =>
      'Projektprotokolle konnten nicht geladen werden';

  @override
  String get loadingProjectReports => 'Projektprotokolle werden geladen …';

  @override
  String get couldNotLoadProjectReports73 =>
      'Projektprotokolle konnten nicht geladen werden.';

  @override
  String get back => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get checkingPDFFile => 'PDF-Datei wird geprüft …';

  @override
  String couldNotCheckFileStatusNProjectReportFrom(String p0) {
    return 'Dateistatus konnte nicht geprüft werden.\nProjektprotokoll vom $p0 Uhr';
  }

  @override
  String get projectReportHistory => 'Projektprotokoll · Projektverlauf';

  @override
  String progressEntriesIncluded(String p0) {
    return '$p0 Projektstände enthalten';
  }

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get print => 'Drucken';

  @override
  String get projectReportFromStrickHKelbuch =>
      'Projektprotokoll aus Strick & Häkelbuch';

  @override
  String get share => 'Teilen';

  @override
  String get choosePDFContent => 'PDF-Inhalt wählen';

  @override
  String get chooseWhatToIncludeInYourPDF =>
      'Wähle, welche Inhalte deine PDF enthalten soll.';

  @override
  String get progressEntriesDatesAndNotesCompactWithoutPhotos =>
      'Projektstände, Zeitpunkte und Notizen – kompakt ohne Fotos.';

  @override
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry =>
      'Enthält alle aktuell zugeordneten Fotos dieses Projektstands.';

  @override
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry =>
      'Enthält alle aktuell zugeordneten Fotos jedes Projektstands.';

  @override
  String get noCurrentPhotosAvailable => 'Keine aktuellen Fotos vorhanden.';

  @override
  String get cameraPhoto => 'Kameraaufnahme';

  @override
  String get galleryImport => 'Galerieimport';

  @override
  String get enteredManually => 'Manuell erfasst';

  @override
  String get newProjectSection => 'Neuer Projektabschnitt';

  @override
  String get projectRestarted => 'Projekt neu begonnen';

  @override
  String get correctionOfAnEarlierEntry =>
      'Korrektur eines früheren Projektstands';

  @override
  String get otherReason => 'Anderer Grund';

  @override
  String get knitting => 'Stricken';

  @override
  String get crochet => 'Häkeln';

  @override
  String get rows => 'Reihen';

  @override
  String get rounds => 'Runden';

  @override
  String get round => 'Runde';

  @override
  String get row => 'Reihe';

  @override
  String current(String p0) {
    return 'Aktuelle $p0';
  }

  @override
  String get everyMinuteDev => 'Minütlich (Dev)';

  @override
  String get hourly => 'Stündlich';

  @override
  String get daily => 'Täglich';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get monthly => 'Monatlich';

  @override
  String get yearly => 'Jährlich';

  @override
  String get standardReminder => 'Normale Erinnerung';

  @override
  String get onTimeWithSound => 'Pünktlich mit Ton';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get saturday => 'Samstag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get preparingPhotos => 'Fotos werden vorbereitet …';

  @override
  String preparingPhotosOf(String p0, String p1) {
    return 'Fotos werden vorbereitet: $p0 von $p1';
  }

  @override
  String get removingPhoto => 'Foto wird entfernt …';

  @override
  String get thePhotoOrderMustIncludeAllCurrentPhotos =>
      'Die Fotoreihenfolge muss alle aktuellen Fotos enthalten.';

  @override
  String get savingPhotoOrder => 'Fotoreihenfolge wird gesichert …';

  @override
  String get removingUnsavedPhotos => 'Ungespeicherte Fotos werden entfernt …';

  @override
  String get couldNotTurnOffTheReminderPleaseTryAgain =>
      'Die Erinnerung konnte nicht ausgeschaltet werden. Bitte erneut versuchen.';

  @override
  String get aPhotoRequiresACameraOrGallerySource =>
      'Ein Foto benötigt eine Kamera- oder Galeriequelle.';

  @override
  String get doNotSupplyPhotosAndASinglePhotoReplacement =>
      'Fotos und Einzelfoto-Ersatz nicht gleichzeitig übergeben.';

  @override
  String get aChangedPhotoRequiresANewPhotoID =>
      'Ein geändertes Foto benötigt eine neue Foto-ID.';

  @override
  String get photosRequireUniqueIDsFilesAndAPhotoSource =>
      'Fotos benötigen eindeutige IDs, Dateien und eine Fotoquelle.';

  @override
  String get enterAWholeNumberOf0OrMore =>
      'Bitte eine ganze Zahl ab 0 eingeben.';

  @override
  String get couldNotTurnOff => 'Ausschalten fehlgeschlagen';

  @override
  String get openTheReminderAndSaveAgain =>
      'Bitte öffne die Erinnerung und speichere erneut.';

  @override
  String get reminderBlocked => 'Erinnerung blockiert';

  @override
  String get notificationsAreTurnedOff =>
      'Benachrichtigungen sind ausgeschaltet.';

  @override
  String get thisReminderCategoryIsTurnedOff =>
      'Diese Erinnerungsart ist ausgeschaltet.';

  @override
  String get remindersNotSupported => 'Erinnerungen nicht unterstützt';

  @override
  String get thisDeviceCannotShowReminders =>
      'Auf diesem Gerät können keine Erinnerungen angezeigt werden.';

  @override
  String get reminderNotScheduled => 'Erinnerung nicht geplant';

  @override
  String get exactTimingNotAllowed => 'Pünktlichkeit nicht erlaubt';

  @override
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder =>
      'Erlaube „Alarme & Erinnerungen“ in Android. Bis dahin kann die Erinnerung verspätet erscheinen.';

  @override
  String get exactSchedulingPending => 'Pünktliche Planung ausstehend';

  @override
  String get theScheduledTimeIsStillApproximateOpenTheReminder =>
      'Der Termin ist noch ungenau geplant. Öffne die Erinnerung und speichere erneut.';

  @override
  String get lastDeliveryFailed => 'Letzte Zustellung fehlgeschlagen';

  @override
  String get openTheReminderAndChooseTestReminderNow =>
      'Bitte öffne die Erinnerung und nutze „Erinnerung jetzt testen“.';

  @override
  String get schedulingStatusUnknown => 'Planungsstatus unbekannt';

  @override
  String get couldNotConfirmReminderStatusOpenTheReminderTo =>
      'Der Erinnerungsstatus konnte nicht bestätigt werden. Öffne die Erinnerung zum Prüfen.';

  @override
  String get reminderStillPending => 'Erinnerung steht noch aus';

  @override
  String get nextReminder => 'Nächste Erinnerung';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get editReminder => 'Erinnerung bearbeiten';

  @override
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor =>
      'Die Einstellungen konnten nicht geöffnet werden. Suche in den Einstellungen deines Smartphones nach „Alarme & Erinnerungen“ und wähle diese App.';

  @override
  String get couldNotOpenSettingsOpenAppsInYourPhone =>
      'Die Einstellungen konnten nicht geöffnet werden. Öffne in den Einstellungen deines Smartphones „Apps“, wähle diese App und dann „Benachrichtigungen“.';

  @override
  String recordedOn(String p0) {
    return 'Erfasst am $p0 Uhr';
  }

  @override
  String recorded(String p0) {
    return 'Erfasst · $p0 Uhr';
  }

  @override
  String get countingUnitChangedSinceThisEntry =>
      'Einheit seit diesem Projektstand gewechselt';

  @override
  String photosForProgressEntry(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 Fotos zum Projektstand $p1',
      one: 'Ein Foto zum Projektstand $p1',
      zero: '0 Fotos zum Projektstand $p1',
    );
    return '$_temp0';
  }

  @override
  String enteredManually159(String p0) {
    return 'Manuell erfasst: $p0';
  }

  @override
  String photos(String p0) {
    return '$p0 Fotos';
  }

  @override
  String viewPhotoOf(String p0, String p1) {
    return 'Foto $p0 von $p1 ansehen';
  }

  @override
  String photo(String p0) {
    return 'Foto $p0';
  }

  @override
  String editPhoto(String p0) {
    return 'Foto $p0 bearbeiten';
  }

  @override
  String get moveEarlier => 'Nach vorne';

  @override
  String get moveLater => 'Nach hinten';

  @override
  String get replacePhoto => 'Foto ersetzen';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get noCurrentPhotos => 'Keine aktuellen Fotos';

  @override
  String get photoUnavailable => 'Foto nicht verfügbar';

  @override
  String get previousPhoto => 'Vorheriges Foto';

  @override
  String get nextPhoto => 'Nächstes Foto';

  @override
  String currentPhotos(String p0) {
    return 'Aktuelle Fotos ($p0)';
  }

  @override
  String get touchAndHoldAPhotoThenDragItTo =>
      'Zum Sortieren ein Foto länger gedrückt halten und verschieben.';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get takeAnotherPhoto => 'Weiteres Foto aufnehmen';

  @override
  String get addPhotosFromGallery => 'Fotos aus Galerie hinzufügen';

  @override
  String get retakePhoto => 'Neu fotografieren';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get couldNotLoadProgressEntry =>
      'Projektstand konnte nicht geladen werden.';

  @override
  String get progressEntryNotFound => 'Projektstand nicht gefunden.';

  @override
  String get editProgressEntry => 'Projektstand bearbeiten';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get discardChanges183 => 'Änderungen verwerfen?';

  @override
  String get yourChangesToThisProgressEntryHaveNotBeen =>
      'Deine Änderungen an diesem Projektstand wurden noch nicht gespeichert.';

  @override
  String couldNotDiscardChanges(String p0) {
    return 'Änderungen konnten nicht verworfen werden: $p0';
  }

  @override
  String photosAddedNotProcessed(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 Fotos hinzugefügt.',
      one: 'Ein Foto hinzugefügt.',
      zero: 'Kein Foto hinzugefügt.',
    );
    return '$_temp0 Nicht verarbeitet: $p1';
  }

  @override
  String couldNotAddPhotos(String p0) {
    return 'Fotos konnten nicht hinzugefügt werden: $p0';
  }

  @override
  String couldNotRemovePhoto(String p0) {
    return 'Foto konnte nicht entfernt werden: $p0';
  }

  @override
  String couldNotSavePhotoOrder(String p0) {
    return 'Fotoreihenfolge konnte nicht gespeichert werden: $p0';
  }

  @override
  String couldNotRestorePhotoDraft(String p0) {
    return 'Foto-Zwischenstand konnte nicht wiederhergestellt werden: $p0';
  }

  @override
  String get changesSaved => 'Änderungen gespeichert.';

  @override
  String get noChangesToSave => 'Keine Änderungen vorhanden.';

  @override
  String couldNotSaveChanges(String p0) {
    return 'Änderungen konnten nicht gespeichert werden: $p0';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get createProject => 'Projekt anlegen';

  @override
  String get lastEdited => 'Zuletzt bearbeitet';

  @override
  String get nameAZ => 'Name A–Z';

  @override
  String get yourProjects => 'Deine Projekte';

  @override
  String get yourProjectsYourPaceRememberWhereToPickUp =>
      'Deine Projekte, dein Tempo. Merke dir, wo du weitermachst.';

  @override
  String get searchProjects => 'Projekte suchen';

  @override
  String get nameTechniqueYarnOrNeedleSize =>
      'Name, Technik, Garn oder Nadelstärke';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get text1Project => '1 Projekt';

  @override
  String projects(String p0) {
    return '$p0 Projekte';
  }

  @override
  String get noProgressEntriesYet => 'Noch kein Projektstand';

  @override
  String lastEdited206(String p0) {
    return 'Zuletzt bearbeitet: $p0';
  }

  @override
  String reminder(String p0) {
    return 'Erinnern: $p0';
  }

  @override
  String get lastReminderNoneYet => 'Letzte Erinnerung: noch keine';

  @override
  String lastReminder(String p0) {
    return 'Letzte Erinnerung: $p0 Uhr';
  }

  @override
  String get everyMinuteDev210 => 'minütlich (Dev)';

  @override
  String hourlyFrom(String p0) {
    return 'stündlich ab $p0 Uhr';
  }

  @override
  String dailyAt(String p0) {
    return 'täglich um $p0';
  }

  @override
  String weeklyOnAt(String p0, String p1) {
    return 'wöchentlich am $p0 um $p1';
  }

  @override
  String monthlyOnDayAt(String p0, String p1) {
    return 'monatlich am $p0. um $p1';
  }

  @override
  String yearlyOnAt(String p0, String p1, String p2) {
    return 'jährlich am $p0.$p1. um $p2';
  }

  @override
  String onTimeWithSound216(String p0) {
    return '$p0 · pünktlich mit Ton';
  }

  @override
  String get noMatchingProjectsFound => 'Keine passenden Projekte gefunden.';

  @override
  String get createYourFirstProject => 'Erstes Projekt anlegen';

  @override
  String get fromTheFirstStitchToTheLastRememberWhich =>
      'Vom ersten Anschlag bis zur letzten Masche: Halte fest, bei welcher Reihe oder Runde du weitermachst – mit Fotos und Notizen, ganz für dich.';

  @override
  String get reload => 'Erneut laden';

  @override
  String get couldNotLoadProject => 'Projekt konnte nicht geladen werden.';

  @override
  String get projectNotFound => 'Projekt nicht gefunden.';

  @override
  String get editProject => 'Projekt bearbeiten';

  @override
  String get projectName224 => 'Projektname *';

  @override
  String get enterAProjectName => 'Bitte einen Projektnamen eingeben.';

  @override
  String get yarnOptional => 'Garn (optional)';

  @override
  String get needleOrHookSizeOptional => 'Nadelstärke (optional)';

  @override
  String get countingUnit228 => 'Zählweise *';

  @override
  String get projectReminder => 'Projekterinnerung';

  @override
  String get optionalAndOnlyOnThisDevice =>
      'Optional und nur lokal auf diesem Gerät';

  @override
  String get interval => 'Intervall';

  @override
  String get month => 'Monat';

  @override
  String get dayOfWeek => 'Wochentag';

  @override
  String get day => 'Tag';

  @override
  String get devModeTheNextReminderIsScheduledForThe =>
      'Dev-Modus: Die nächste Erinnerung wird zum Beginn der nächsten Minute geplant. Normale Erinnerungen können leicht verzögert erscheinen.';

  @override
  String get startDate => 'Startdatum';

  @override
  String get changeDate => 'Datum ändern';

  @override
  String get startTime => 'Startzeit';

  @override
  String get changeTime => 'Uhrzeit ändern';

  @override
  String every60MinutesFromTheSelectedStartNextReminder(String p0) {
    return 'Ab dem gewählten Start alle 60 Minuten. Nächste Erinnerung: $p0 Uhr.';
  }

  @override
  String get time => 'Uhrzeit';

  @override
  String get reminderType => 'Art der Erinnerung';

  @override
  String get mayArriveSlightlyLateRespectsTheSystemDoNot =>
      'Kann leicht verzögert erscheinen. Die Systemeinstellung „Nicht stören“ wird berücksichtigt.';

  @override
  String get triggersAsCloseAsPossibleToTheSelectedTime =>
      'Wird möglichst genau zur gewählten Uhrzeit wie ein Alarm ausgelöst.';

  @override
  String get openAlarmsReminders => '„Alarme & Erinnerungen“ öffnen';

  @override
  String get testReminderNow => 'Erinnerung jetzt testen';

  @override
  String get checkTheNotificationShadeDuringTheTestTheTest =>
      'Prüfe beim Test die Benachrichtigungsleiste. Die Test-Erinnerung wird nach einer Minute automatisch entfernt.';

  @override
  String get theReminderIsNotConfirmedSavingWillSetIt =>
      'Die Erinnerung ist nicht bestätigt. Mit Speichern wird sie erneut eingerichtet.';

  @override
  String get saving => 'Wird gespeichert …';

  @override
  String get everythingSaved => 'Alles gespeichert';

  @override
  String get saveReminderAgain => 'Erinnerung erneut speichern';

  @override
  String get saveProject => 'Projekt speichern';

  @override
  String get discardInput => 'Eingaben verwerfen?';

  @override
  String get yourChangesToThisProjectHaveNotBeenSaved =>
      'Deine Änderungen an diesem Projekt wurden noch nicht gespeichert.';

  @override
  String get yourNewProjectDetailsHaveNotBeenSaved =>
      'Deine Eingaben für das neue Projekt wurden noch nicht gespeichert.';

  @override
  String get discardInput256 => 'Eingaben verwerfen';

  @override
  String get androidPermissionForOnTimeWithSoundIsMissing =>
      'Für „Pünktlich mit Ton“ fehlt die Android-Berechtigung. Bitte den Modus erneut auswählen und erlauben.';

  @override
  String get projectSavedRemindersAreBlockedInAndroid =>
      'Projekt gespeichert. Erinnerungen sind in Android blockiert.';

  @override
  String get projectSavedYouCanNowAddYourFirstProgress =>
      'Projekt gespeichert. Als Nächstes kannst du den ersten Projektstand erfassen.';

  @override
  String get projectChangesSaved => 'Änderungen am Projekt gespeichert.';

  @override
  String couldNotSave(String p0) {
    return 'Speichern fehlgeschlagen: $p0';
  }

  @override
  String get thisTimeIsUnavailableDueToTheDaylightSaving =>
      'Diese Uhrzeit ist wegen der Zeitumstellung nicht verfügbar. Bitte wähle eine andere Uhrzeit.';

  @override
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime =>
      'Die Android-Einstellung „Alarme & Erinnerungen“ konnte nicht geöffnet werden. „Pünktlich mit Ton“ bleibt ausgewählt.';

  @override
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice =>
      'Die Android-Einstellung „Alarme & Erinnerungen“ ist auf diesem Gerät nicht verfügbar.';

  @override
  String get afterSavingUse => 'Nach dem Speichern kannst du unter ';

  @override
  String get toAddAndRecordYourFirstProgressEntry =>
      ' deinen ersten Projektstand erfassen und protokollieren.';

  @override
  String get androidMustAllowAlarmsRemindersForOnTimeReminders =>
      'Für pünktliche Erinnerungen muss Android „Alarme & Erinnerungen“ erlauben. Aktiviere die Freigabe, damit die Erinnerung zuverlässig zur gewählten Zeit mit Ton erscheint.';

  @override
  String get allowAlarmsReminders => 'Alarme & Erinnerungen erlauben';

  @override
  String get notificationsAreTurnedOff269 =>
      'Benachrichtigungen sind ausgeschaltet';

  @override
  String get thisReminderCategoryIsTurnedOff270 =>
      'Diese Erinnerungsart ist ausgeschaltet';

  @override
  String get doNotDisturbIsOn => '„Nicht stören“ ist aktiv';

  @override
  String get androidIsBlockingNotificationsForStrickHKelbuchYou =>
      'Android blockiert Benachrichtigungen für Strick & Häkelbuch. Du kannst sie in den Android-Einstellungen erlauben.';

  @override
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0) {
    return 'Android blockiert „$p0“. Du kannst diese Kategorie in den Android-Einstellungen einschalten.';
  }

  @override
  String get projectReminders => 'Projekterinnerungen';

  @override
  String get onTimeProjectReminders => 'Pünktliche Projekterinnerungen';

  @override
  String get standardRemindersMayAppearWithoutSoundOrABanner =>
      'Normale Erinnerungen können ohne Ton oder eingeblendetes Banner erscheinen. Prüfe auch die Benachrichtigungsleiste.';

  @override
  String get alarmSoundAndBannersDependOnYourDoNot =>
      'Ob ein Alarmton oder Banner erscheint, hängt von deinen „Nicht stören“-Einstellungen und der Alarmlautstärke ab.';

  @override
  String get openAndroidSettings => 'Android-Einstellungen öffnen';

  @override
  String get openDoNotDisturb => '„Nicht stören“ öffnen';

  @override
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings =>
      'Die Systemeinstellungen konnten nicht geöffnet werden. Suche in den Einstellungen deines Smartphones nach „Nicht stören“.';

  @override
  String get couldNotOpenSystemSettingsInYourPhoneSettings =>
      'Die Systemeinstellungen konnten nicht geöffnet werden. Öffne in den Einstellungen deines Smartphones „Apps“, dann „Strick & Häkelbuch“ und „Benachrichtigungen“.';

  @override
  String get sortPhotos => 'Fotos sortieren';

  @override
  String get projectReportSingleEntry =>
      'Projektprotokoll · Einzelner Projektstand';

  @override
  String get preparingTheProgressEntryAndNotesForTheCompact =>
      'Projektstand und Notizen werden für die kompakte PDF zusammengestellt.';

  @override
  String get preparingCurrentPhotosProgressAndNotesForThePDF =>
      'Die aktuellen Fotos, der Projektstand und die Notizen werden für die PDF zusammengestellt.';

  @override
  String couldNotCreatePDF(String p0) {
    return 'PDF konnte nicht erstellt werden: $p0';
  }

  @override
  String get theSavedPDFFileIsMissing => 'Die gespeicherte PDF-Datei fehlt.';

  @override
  String get deleteProjectReport288 => 'Projektprotokoll löschen?';

  @override
  String get thePDFWillBePermanentlyDeletedFromStrickH =>
      'Die PDF wird dauerhaft aus Strick & Häkelbuch gelöscht. Bereits geteilte oder außerhalb der App gespeicherte Kopien bleiben erhalten.';

  @override
  String get projectReportDeleted => 'Projektprotokoll gelöscht.';

  @override
  String get couldNotDeleteProjectReportPleaseTryAgain =>
      'Projektprotokoll konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get deleteProgressEntry => 'Projektstand löschen?';

  @override
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill =>
      'Projektstand, alle zugehörigen Anhänge und Einzel-PDFs dieses Projektstands werden dauerhaft gelöscht. Gespeicherte Verlaufs-PDFs bleiben erhalten. Bereits außerhalb der App gespeicherte Kopien bleiben bestehen.';

  @override
  String get progressEntryDeleted => 'Projektstand gelöscht.';

  @override
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry =>
      'Projektstand konnte nicht vollständig gelöscht werden. Bitte versuche es erneut.';

  @override
  String get reportForThisProgressEntry =>
      'Projektprotokoll dieses Projektstands';

  @override
  String get createProjectReportAsPDF => 'Projektprotokoll als PDF erstellen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get deleteProgressEntry299 => 'Projektstand löschen';

  @override
  String get source => 'Quelle';

  @override
  String get lowerCount301 => 'Niedrigerer Stand';

  @override
  String get project => 'Projekt';

  @override
  String get couldNotLoadProgressEntries =>
      'Projektstände konnten nicht geladen werden.';

  @override
  String get recordProgress => 'Projektstand erfassen';

  @override
  String ofProgressEntries(String p0, String p1) {
    return '$p0 von $p1 Projektständen';
  }

  @override
  String get showAllProgressEntries => 'Alle Projektstände anzeigen';

  @override
  String get preparingProgressEntriesAndNotesForTheCompactPDF =>
      'Projektstände und Notizen werden für die kompakte PDF zusammengestellt.';

  @override
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe =>
      'Projektstände, aktuelle Fotos und Notizen werden für die PDF zusammengestellt.';

  @override
  String get deleteProject => 'Projekt löschen?';

  @override
  String get allProgressEntriesProgressPhotosAndLocallySavedReports =>
      'Alle Projektstände, Projektstandfotos und lokal gespeicherten Projektprotokolle dieses Projekts werden dauerhaft entfernt. Bereits extern geteilte Dateien bleiben bestehen.';

  @override
  String get projectDeleted => 'Projekt gelöscht.';

  @override
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain =>
      'Projekt konnte nicht vollständig gelöscht werden. Bitte versuche es erneut.';

  @override
  String get editProjectReminder => 'Projekt & Erinnerung bearbeiten';

  @override
  String get deleteProject314 => 'Projekt löschen';

  @override
  String get createReportForProjectHistory =>
      'Projektprotokoll für den Projektverlauf erstellen';

  @override
  String lastRecordedOn(String p0) {
    return 'Zuletzt am $p0';
  }

  @override
  String yarn317(String p0) {
    return 'Garn: $p0';
  }

  @override
  String needleOrHookSize318(String p0) {
    return 'Nadelstärke: $p0';
  }

  @override
  String reminder319(String p0) {
    return 'Erinnerung: $p0';
  }

  @override
  String get noProgressEntryYetEnterYourCurrentRowOr =>
      'Noch kein Projektstand. Trage deine aktuelle Reihe oder Runde ein – mit oder ohne Projektfoto.';

  @override
  String get recordFirstProgressEntry => 'Ersten Projektstand erfassen';

  @override
  String get changeDateTime => 'Datum & Uhrzeit ändern';

  @override
  String get enterProgress => 'Stand eintragen';

  @override
  String get photographProject => 'Projekt fotografieren';

  @override
  String get photosFromGallery => 'Fotos aus Galerie';

  @override
  String get preparingPhoto => 'Foto wird vorbereitet …';

  @override
  String get enterWhereYouLeftOff => 'Trage ein, wo du gerade aufgehört hast.';

  @override
  String get optionalEGStartedTheSleeve =>
      'Optional, z. B. mit dem Ärmel begonnen';

  @override
  String get saveProgressEntry => 'Projektstand speichern';

  @override
  String get confirmAndSaveProgress => 'Projektstand bestätigen und speichern';

  @override
  String get discardProgressEntry => 'Projektstand verwerfen?';

  @override
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen =>
      'Dein Projektstand und die ausgewählten Fotos wurden noch nicht gespeichert.';

  @override
  String get discardProgressEntry333 => 'Projektstand verwerfen';

  @override
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain =>
      'Die ungespeicherten Fotos konnten nicht entfernt werden. Bitte versuche es erneut.';

  @override
  String get progressEntrySaved => 'Projektstand gespeichert.';

  @override
  String get pickUpFromHere => 'Hier machst du weiter';

  @override
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow =>
      'Merke dir deine aktuelle Reihe oder Runde. Fotos halten fest, wie dein Projekt gerade aussieht.';

  @override
  String get youEnterYourProgressYourselfPhotosAndNotesStay =>
      'Deinen Stand trägst du selbst ein. Fotos und Notizen bleiben auf deinem Gerät.';

  @override
  String get knittingScarf => 'Stricken · Schal';

  @override
  String get layYourProjectFlatSoItsShapeAndPattern =>
      'Lege dein Projekt flach hin, damit Form und Muster gut sichtbar sind.';

  @override
  String get knittingHatInTheRound => 'Stricken · Mütze in Runden';

  @override
  String get includeTheWorkingNeedleAndTheMarkedStartOf =>
      'Zeige auch die aktive Nadel und den markierten Rundenanfang.';

  @override
  String get crochetGrannySquare => 'Häkeln · Granny Square';

  @override
  String get photographTheWholeMotifIncludingWhereYouWillContinue =>
      'Fotografiere das ganze Motiv mit der Stelle, an der du weiterhäkelst.';

  @override
  String get crochetBasketInTheRound => 'Häkeln · Körbchen in Runden';

  @override
  String get aSlightlyAngledViewShowsTheBaseHeightAnd =>
      'Ein leicht schräger Blick zeigt den Boden, die Höhe und den Arbeitsrand.';

  @override
  String get viewExamples => 'Beispiele ansehen';

  @override
  String get examplePhotos => 'Beispielfotos';

  @override
  String get close => 'Schließen';

  @override
  String get photographYourProjectInGoodLightEnterTheCurrent =>
      'Halte dein Projekt bei gutem Licht fest. Deine aktuelle Reihe oder Runde trägst du selbst ein.';

  @override
  String examplePhoto(String p0) {
    return 'Beispielfoto: $p0';
  }

  @override
  String get couldNotLoadExample => 'Beispiel konnte nicht geladen werden.';

  @override
  String get previousExample => 'Vorheriges Beispiel';

  @override
  String get nextExample => 'Nächstes Beispiel';

  @override
  String get noProgressEntriesYet356 => 'Noch keine Projektstände vorhanden.';

  @override
  String get matches => 'Treffern';

  @override
  String get progressEntries => 'Projektständen';

  @override
  String of359(String p0, String p1, String p2, String p3) {
    return '$p0–$p1 von $p2 $p3';
  }

  @override
  String get searchProgressEntries => 'Projektstände suchen';

  @override
  String get dateRowRoundOrNote => 'Datum, Reihe/Runde oder Notiz';

  @override
  String get noMatchingProgressEntryFound =>
      'Kein passender Projektstand gefunden.';

  @override
  String get searchByDateCurrentRowOrRoundOrA =>
      'Suche nach Datum, aktueller Reihe oder Runde oder einem Wort aus der Notiz.';

  @override
  String get choosingASaveLocationIsNotYetAvailableOn =>
      'Die direkte Speicherortwahl ist auf dieser Plattform noch nicht verfügbar.';

  @override
  String get strickHKelbuchBackup => 'Strick & Häkelbuch Backup';

  @override
  String get projects366 => 'Projekte';

  @override
  String get progressEntries367 => 'Projektstände';

  @override
  String get backup => 'Datensicherung';

  @override
  String get createEncryptedBackup => 'Verschlüsseltes Backup erstellen';

  @override
  String get projectsPhotosAndProjectReports =>
      'Projekte, Fotos und Projektprotokolle';

  @override
  String get restoreBackup => 'Backup wiederherstellen';

  @override
  String get newerExistingEntriesArePreserved =>
      'Vorhandene neuere Einträge bleiben erhalten';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn =>
      'Fotos, Projektstände und PDFs werden lokal auf deinem Gerät verarbeitet. Die App überträgt deine Projektdaten nicht an einen Server.';

  @override
  String get yourDataStaysOnYourDeviceUntilYouDelete =>
      'Deine Daten bleiben lokal auf deinem Gerät gespeichert, bis du sie in der App löschst oder die App-Daten entfernst.';

  @override
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI =>
      'Entwickler und Datenschutzkontakt\nWasiliy Strecker · AppFabrik AI';

  @override
  String get openPrivacyPolicy => 'Datenschutzerklärung öffnen';

  @override
  String get aboutStrickHKelbuch => 'Über Strick & Häkelbuch';

  @override
  String get sourceCodeOnGitHub => 'Quellcode auf GitHub';

  @override
  String get theSourceCodeCouldNotBeOpened =>
      'Der Quellcode konnte nicht geöffnet werden. Bitte versuche es erneut.';

  @override
  String get openSourceMPL20 => 'Open Source · MPL 2.0';

  @override
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain =>
      'Die Datenschutzerklärung konnte nicht geöffnet werden. Bitte versuche es erneut.';

  @override
  String get preparingFiles => 'Dateien werden vorbereitet …';

  @override
  String couldNotCreateBackup(String p0) {
    return 'Backup konnte nicht erstellt werden: $p0';
  }

  @override
  String get savingBackup => 'Backup wird gespeichert …';

  @override
  String couldNotShareBackup(String p0) {
    return 'Backup konnte nicht geteilt werden: $p0';
  }

  @override
  String get backupSaved => 'Backup gespeichert';

  @override
  String wasSavedToTheSelectedLocation(String p0) {
    return '$p0 wurde im gewählten Speicherort abgelegt.';
  }

  @override
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 · $p1 · $p2\n$p3 MB · Erstellt am $p4 Uhr';
  }

  @override
  String get projectReports => 'Projektprotokolle';

  @override
  String get done => 'Fertig';

  @override
  String get couldNotSaveBackup => 'Backup konnte nicht gespeichert werden';

  @override
  String get backupNotSavedYet => 'Backup noch nicht gespeichert';

  @override
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe =>
      'Die verschlüsselte Datei liegt nur vorübergehend in der App. Wähle einen Speicherort, damit das Backup erhalten bleibt.';

  @override
  String get discardBackup => 'Backup verwerfen';

  @override
  String get chooseSaveLocation => 'Speicherort wählen';

  @override
  String get chooseAStrickHKelbuchBackupFileShbackup =>
      'Bitte wähle eine Strick & Häkelbuch-Backup-Datei (.shbackup).';

  @override
  String get couldNotOpenTheSelectedBackupFile =>
      'Die ausgewählte Backup-Datei konnte nicht geöffnet werden.';

  @override
  String couldNotSelectBackupFile(String p0) {
    return 'Backup-Datei konnte nicht ausgewählt werden: $p0';
  }

  @override
  String get checkingBackup => 'Backup wird geprüft …';

  @override
  String get restoreBackup402 => 'Backup wiederherstellen?';

  @override
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  ) {
    return '$p0, $p1 und $p2 werden importiert. Neuere lokale Einträge werden nicht überschrieben.';
  }

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get restoringBackup => 'Backup wird wiederhergestellt …';

  @override
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  ) {
    return '$p0 und $p1 wiederhergestellt. $p2 unveränderte oder neuere Einträge übersprungen.$p3$p4';
  }

  @override
  String get photo407 => 'Foto';

  @override
  String get photos408 => 'Fotos';

  @override
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0) {
    return ' Bei $p0 Einträgen konnte die Erinnerung nicht bestätigt werden. Bitte prüfe die Erinnerungen in der Übersicht.';
  }

  @override
  String couldNotRestoreBackup(String p0) {
    return 'Backup konnte nicht wiederhergestellt werden: $p0';
  }

  @override
  String get thePasswordMustHaveAtLeast6Characters =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get thePasswordIsIncorrectOrTheBackupHasBeen =>
      'Das Passwort ist falsch oder das Backup wurde verändert.';

  @override
  String aFileToBackUpIsMissing(String p0) {
    return 'Eine zu sichernde Datei fehlt: $p0';
  }

  @override
  String get aFileInTheBackupIsDamagedOrIncomplete =>
      'Eine Datei im Backup ist beschädigt oder unvollständig.';

  @override
  String get thisBackupVersionIsNotSupported =>
      'Diese Backup-Version wird nicht unterstützt.';

  @override
  String get theSelectedFileIsNotAValidStrickH =>
      'Die ausgewählte Datei ist kein gültiges Strick & Häkelbuch-Backup.';

  @override
  String get preparingFiles417 => 'Dateien werden vorbereitet';

  @override
  String get encryptingBackup => 'Backup wird verschlüsselt';

  @override
  String get finishingBackup => 'Backup wird abgeschlossen';

  @override
  String get backupReady => 'Backup ist bereit';

  @override
  String get pleaseWaitAMoment => 'Bitte einen Moment warten.';

  @override
  String get gatheringPhotosAndProjectReports =>
      'Fotos und Projektprotokolle werden zusammengestellt.';

  @override
  String ofFiles(String p0, String p1) {
    return '$p0 von $p1 Dateien';
  }

  @override
  String get setBackupPassword => 'Backup-Passwort festlegen';

  @override
  String get password => 'Passwort';

  @override
  String get atLeast6Characters => 'Mindestens 6 Zeichen';

  @override
  String get repeatPassword => 'Passwort wiederholen';

  @override
  String progressEquation(String p0, String p1) {
    return ' $p0 = $p1 Fortschritt';
  }

  @override
  String get unitChanged => '– (Einheit gewechselt)';

  @override
  String reportCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projektprotokolle',
      one: '$count Projektprotokoll',
    );
    return '$_temp0';
  }

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projektstände',
      one: '$count Projektstand',
    );
    return '$_temp0';
  }

  @override
  String projectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projekte',
      one: '$count Projekt',
    );
    return '$_temp0';
  }

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fotos',
      one: '$count Foto',
    );
    return '$_temp0';
  }

  @override
  String matchCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Treffer',
      one: '$count Treffer',
    );
    return '$_temp0';
  }

  @override
  String includedEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projektstände enthalten',
      one: '$count Projektstand enthalten',
    );
    return '$_temp0';
  }

  @override
  String reminderDeadline(String p0, String p1) {
    return '$p0 Uhr$p1';
  }

  @override
  String get reminderNotProcessed =>
      '. Android hat diesen Termin noch nicht verarbeitet.';

  @override
  String progressChange(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 $p1 → $p2 = $p3 $p4 Fortschritt';
  }

  @override
  String get projectNameExample => 'z. B. Mein Salbei-Pullover';

  @override
  String get yarnExample => 'z. B. Merinowolle, Salbei';

  @override
  String needleSizeExample(String size) {
    return 'z. B. $size mm';
  }

  @override
  String get recordProgressQuoted => '„Projektstand erfassen“';

  @override
  String get examplePhotoDisclaimer =>
      'KI-generierte Beispiele · nur zur Ansicht';

  @override
  String repairedFiles(String p0) {
    return ' $p0 repariert.';
  }

  @override
  String get backupPassword => 'Backup-Passwort';

  @override
  String get language => 'Sprache';

  @override
  String get systemLanguage => 'Systemsprache';

  @override
  String get languageHelp =>
      'Zahlen und Datumsangaben richten sich weiterhin nach deiner Geräteregion.';

  @override
  String get languageSaveFailed =>
      'Die Sprache konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get unexpectedError =>
      'Der Vorgang konnte nicht abgeschlossen werden. Bitte versuche es erneut.';

  @override
  String get passwordMismatch => 'Die Passwörter stimmen nicht überein.';

  @override
  String get currentRow => 'Aktuelle Reihe';

  @override
  String get currentRound => 'Aktuelle Runde';

  @override
  String lastProgress(String value, String unit) {
    return 'Letzter Projektstand: $value $unit';
  }

  @override
  String get reminderBody =>
      'Halte deine aktuelle Reihe oder Runde fest und mache später entspannt weiter.';

  @override
  String testNotificationTitle(String technique, String name) {
    return 'Test: $technique · $name';
  }

  @override
  String get testNotificationApp =>
      'Das ist eine Test-Erinnerung. Tippen öffnet die App.';

  @override
  String get testNotificationProject =>
      'Das ist eine Test-Erinnerung. Tippen öffnet die Projektkarte.';

  @override
  String get normalChannelDescription =>
      'Optionale Erinnerungen für regelmäßige Projektstände.';

  @override
  String get exactChannelDescription =>
      'Pünktliche Projekterinnerungen mit Alarmton.';

  @override
  String get reportFilePrefix => 'projektstand';

  @override
  String get historyFilePrefix => 'projektverlauf';

  @override
  String get compactFilePart => 'kompakt';

  @override
  String get photosFilePart => 'mit_fotos';

  @override
  String annualReminder(String date, String time) {
    return 'jährlich am $date um $time';
  }

  @override
  String positionOfTotal(String p0, String p1) {
    return '$p0 von $p1';
  }

  @override
  String rowQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reihen',
      one: 'Reihe',
    );
    return '$_temp0';
  }

  @override
  String roundQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Runden',
      one: 'Runde',
    );
    return '$_temp0';
  }
}
