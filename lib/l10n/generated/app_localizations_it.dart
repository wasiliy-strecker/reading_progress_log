// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get delete => 'Elimina';

  @override
  String get cancel => 'Annulla';

  @override
  String get discardChanges => 'Scarta modifiche';

  @override
  String get continueEditing => 'Continua a modificare';

  @override
  String get creatingProjectReport => 'Creazione del resoconto del progetto';

  @override
  String get pleaseWait => 'Attendi un momento…';

  @override
  String testReminderSentToAndroidOpenTheNotificationShade(String p0) {
    return 'Promemoria di prova inviato ad Android. Apri il pannello delle notifiche. Scomparirà dopo un minuto.$p0';
  }

  @override
  String get doNotDisturbIsOnSoundAndBannersMay =>
      ' La modalità Non disturbare è attiva. Suoni e banner potrebbero essere bloccati.';

  @override
  String get notificationsAreNotAllowed => 'Le notifiche non sono consentite.';

  @override
  String get thisReminderCategoryIsBlockedInAndroid =>
      'Questa categoria di promemoria è bloccata in Android.';

  @override
  String get couldNotShowTheTestReminder =>
      'Impossibile mostrare il promemoria di prova.';

  @override
  String get testRemindersAreNotSupportedOnThisDevice =>
      'I promemoria di prova non sono supportati su questo dispositivo.';

  @override
  String get anHourlyReminderRequiresAStartTime =>
      'Un promemoria orario richiede un orario di inizio.';

  @override
  String get dataSavedCouldNotTurnOffTheReminderOpen =>
      'Dati salvati. Impossibile disattivare il promemoria. Aprilo e salva di nuovo.';

  @override
  String get dataSavedRemindersAreBlockedInAndroidOpenThe =>
      'Dati salvati. I promemoria sono bloccati in Android. Apri il promemoria, poi le impostazioni Android.';

  @override
  String get dataSavedRemindersAreNotSupportedOnThisDevice =>
      'Dati salvati. I promemoria non sono supportati su questo dispositivo.';

  @override
  String get dataSavedTheReminderCouldNotBeConfirmedOpen =>
      'Dati salvati. Non è stato possibile confermare il promemoria. Aprilo e salva di nuovo.';

  @override
  String get dataSavedForAnOnTimeReminderOpenAlarms =>
      'Dati salvati. Per un promemoria puntuale, apri Sveglie e promemoria nelle impostazioni Android.';

  @override
  String get dataSavedCouldNotCheckReminderStatusOpenThe =>
      'Dati salvati. Impossibile verificare lo stato del promemoria. Aprilo e salva di nuovo.';

  @override
  String get whatIsTheProjectReportFor =>
      'A cosa serve il resoconto del progetto?';

  @override
  String get beforeCreatingItChooseACompactReportWithoutPhotos =>
      'Prima di crearlo, scegli un resoconto compatto senza foto o con tutte le foto attuali. Entrambi includono avanzamenti, date e note, da salvare, stampare o condividere.';

  @override
  String get itRecordsYourProjectProgressUsingTheInformationYou =>
      'Documenta i progressi del progetto in base ai dati che hai confermato.';

  @override
  String get thePDFBringsTogetherAllProgressEntriesAndNotes =>
      'Il PDF raccoglie tutti gli avanzamenti e le note. Scegli un resoconto compatto senza foto o includi tutte le foto attuali di ogni voce, da salvare, stampare o condividere.';

  @override
  String get personalRecordOfYourProjectProgress =>
      'Documentazione personale dei progressi del tuo progetto.';

  @override
  String get couldNotSaveThePhotoDraft =>
      'Impossibile salvare la bozza delle foto.';

  @override
  String get couldNotRemoveThePhotoDraft =>
      'Impossibile eliminare la bozza delle foto.';

  @override
  String get manualEntryDoesNotAccessPhotos =>
      'L’inserimento manuale non accede alle foto.';

  @override
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt =>
      'Impossibile ottimizzare la foto in modo sicuro. Selezionala di nuovo.';

  @override
  String get compactWithoutPhotos => 'Compatto, senza foto';

  @override
  String get withCurrentPhotos => 'Con le foto attuali';

  @override
  String get withAllPhotosOlderVersion =>
      'Con tutte le foto (versione precedente)';

  @override
  String get thisProjectHasNoProgressEntriesYet =>
      'Questo progetto non ha ancora voci di avanzamento.';

  @override
  String get theProgressEntriesDoNotBelongToThisProject =>
      'Le voci di avanzamento non appartengono a questo progetto.';

  @override
  String get projectReport => 'Resoconto del progetto';

  @override
  String get personalRecordOfProjectProgress =>
      'Documentazione personale di un avanzamento del progetto';

  @override
  String pageOf(String p0, String p1) {
    return 'Pagina $p0 di $p1';
  }

  @override
  String get singleProgressEntry => 'Singola voce di avanzamento';

  @override
  String get projectHistory => 'Cronologia del progetto';

  @override
  String pdfCreatedOn(String p0, String p1) {
    return 'PDF creato il $p0 · $p1';
  }

  @override
  String get currentProjectDetails => 'Dati attuali del progetto';

  @override
  String get projectDetailsWhenRecorded =>
      'Dati del progetto al momento della registrazione';

  @override
  String get technique => 'Tecnica';

  @override
  String get projectName => 'Nome del progetto';

  @override
  String get yarn => 'Filato';

  @override
  String get needleOrHookSize => 'Misura dei ferri o dell’uncinetto';

  @override
  String get countingUnit => 'Unità di conteggio';

  @override
  String get no => 'N.';

  @override
  String get dateAndTime => 'Data e ora';

  @override
  String get progressEntry => 'Voce di avanzamento';

  @override
  String get progress => 'Progresso';

  @override
  String get notSpecified => 'Non specificato';

  @override
  String progressEntry53(String p0) {
    return 'Voce di avanzamento $p0';
  }

  @override
  String get progressDateAndTime => 'Data e ora dell’avanzamento';

  @override
  String progressEntry55(String p0, String p1, String p2) {
    return 'Voce di avanzamento $p0 · $p1 · $p2';
  }

  @override
  String lowerCount(String p0) {
    return 'Conteggio inferiore: $p0';
  }

  @override
  String get note => 'Nota';

  @override
  String earlierPhoto(String p0) {
    return 'Foto precedente $p0';
  }

  @override
  String photoOf(String p0, String p1) {
    return 'Foto $p0 di $p1';
  }

  @override
  String get couldNotEmbedTheProgressPhoto =>
      'Impossibile incorporare la foto dell’avanzamento.';

  @override
  String get noPreparedPhotoFileAvailable =>
      'Nessun file fotografico preparato disponibile.';

  @override
  String createdOn(String p0) {
    return 'Creato il $p0';
  }

  @override
  String get savedLocally => 'Salvato sul dispositivo';

  @override
  String get fileMissing => 'File mancante';

  @override
  String get deleteProjectReport => 'Elimina resoconto del progetto';

  @override
  String get savedProjectReports => 'Resoconti del progetto salvati';

  @override
  String get couldNotLoadProjectReports => 'Impossibile caricare i resoconti';

  @override
  String get loadingProjectReports => 'Caricamento dei resoconti del progetto…';

  @override
  String get couldNotLoadProjectReports73 =>
      'Impossibile caricare i resoconti del progetto.';

  @override
  String get back => 'Indietro';

  @override
  String get next => 'Avanti';

  @override
  String get checkingPDFFile => 'Verifica del file PDF…';

  @override
  String couldNotCheckFileStatusNProjectReportFrom(String p0) {
    return 'Impossibile verificare lo stato del file.\nResoconto del progetto del $p0';
  }

  @override
  String get projectReportHistory => 'Resoconto del progetto · Cronologia';

  @override
  String progressEntriesIncluded(String p0) {
    return '$p0 voci di avanzamento incluse';
  }

  @override
  String get tryAgain => 'Riprova';

  @override
  String get print => 'Stampa';

  @override
  String get projectReportFromStrickHKelbuch =>
      'Resoconto del progetto da Strick & Häkelbuch';

  @override
  String get share => 'Condividi';

  @override
  String get choosePDFContent => 'Scegli il contenuto del PDF';

  @override
  String get chooseWhatToIncludeInYourPDF => 'Scegli cosa includere nel PDF.';

  @override
  String get progressEntriesDatesAndNotesCompactWithoutPhotos =>
      'Voci di avanzamento, date e note, in formato compatto senza foto.';

  @override
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry =>
      'Include tutte le foto attualmente associate a questa voce.';

  @override
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry =>
      'Include tutte le foto attualmente associate a ogni voce.';

  @override
  String get noCurrentPhotosAvailable => 'Nessuna foto attuale disponibile.';

  @override
  String get cameraPhoto => 'Foto dalla fotocamera';

  @override
  String get galleryImport => 'Importazione dalla galleria';

  @override
  String get enteredManually => 'Inserito manualmente';

  @override
  String get newProjectSection => 'Nuova sezione del progetto';

  @override
  String get projectRestarted => 'Progetto ricominciato';

  @override
  String get correctionOfAnEarlierEntry => 'Correzione di una voce precedente';

  @override
  String get otherReason => 'Altro motivo';

  @override
  String get knitting => 'Maglia';

  @override
  String get crochet => 'Uncinetto';

  @override
  String get rows => 'Righe';

  @override
  String get rounds => 'Giri';

  @override
  String get round => 'Giro';

  @override
  String get row => 'Riga';

  @override
  String current(String p0) {
    return '$p0 attuale';
  }

  @override
  String get everyMinuteDev => 'Ogni minuto (Dev)';

  @override
  String get hourly => 'Ogni ora';

  @override
  String get daily => 'Ogni giorno';

  @override
  String get weekly => 'Ogni settimana';

  @override
  String get monthly => 'Ogni mese';

  @override
  String get yearly => 'Ogni anno';

  @override
  String get standardReminder => 'Promemoria normale';

  @override
  String get onTimeWithSound => 'Puntuale con suono';

  @override
  String get monday => 'Lunedì';

  @override
  String get tuesday => 'Martedì';

  @override
  String get wednesday => 'Mercoledì';

  @override
  String get thursday => 'Giovedì';

  @override
  String get friday => 'Venerdì';

  @override
  String get saturday => 'Sabato';

  @override
  String get sunday => 'Domenica';

  @override
  String get preparingPhotos => 'Preparazione delle foto…';

  @override
  String preparingPhotosOf(String p0, String p1) {
    return 'Preparazione delle foto: $p0 di $p1';
  }

  @override
  String get removingPhoto => 'Rimozione della foto…';

  @override
  String get thePhotoOrderMustIncludeAllCurrentPhotos =>
      'L’ordine deve includere tutte le foto attuali.';

  @override
  String get savingPhotoOrder => 'Salvataggio dell’ordine delle foto…';

  @override
  String get removingUnsavedPhotos => 'Rimozione delle foto non salvate…';

  @override
  String get couldNotTurnOffTheReminderPleaseTryAgain =>
      'Impossibile disattivare il promemoria. Riprova.';

  @override
  String get aPhotoRequiresACameraOrGallerySource =>
      'Una foto deve provenire dalla fotocamera o dalla galleria.';

  @override
  String get doNotSupplyPhotosAndASinglePhotoReplacement =>
      'Non fornire foto e una sostituzione singola contemporaneamente.';

  @override
  String get aChangedPhotoRequiresANewPhotoID =>
      'Una foto modificata richiede un nuovo ID.';

  @override
  String get photosRequireUniqueIDsFilesAndAPhotoSource =>
      'Le foto richiedono ID univoci, file e una fonte.';

  @override
  String get enterAWholeNumberOf0OrMore =>
      'Inserisci un numero intero maggiore o uguale a 0.';

  @override
  String get couldNotTurnOff => 'Disattivazione non riuscita';

  @override
  String get openTheReminderAndSaveAgain =>
      'Apri il promemoria e salva di nuovo.';

  @override
  String get reminderBlocked => 'Promemoria bloccato';

  @override
  String get notificationsAreTurnedOff => 'Le notifiche sono disattivate.';

  @override
  String get thisReminderCategoryIsTurnedOff =>
      'Questa categoria di promemoria è disattivata.';

  @override
  String get remindersNotSupported => 'Promemoria non supportati';

  @override
  String get thisDeviceCannotShowReminders =>
      'Questo dispositivo non può mostrare promemoria.';

  @override
  String get reminderNotScheduled => 'Promemoria non programmato';

  @override
  String get exactTimingNotAllowed => 'Orario esatto non consentito';

  @override
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder =>
      'Consenti Sveglie e promemoria in Android. Fino ad allora, il promemoria potrebbe arrivare in ritardo.';

  @override
  String get exactSchedulingPending => 'Programmazione esatta in sospeso';

  @override
  String get theScheduledTimeIsStillApproximateOpenTheReminder =>
      'L’orario programmato è ancora approssimativo. Apri il promemoria e salva di nuovo.';

  @override
  String get lastDeliveryFailed => 'Ultimo invio non riuscito';

  @override
  String get openTheReminderAndChooseTestReminderNow =>
      'Apri il promemoria e scegli Prova il promemoria ora.';

  @override
  String get schedulingStatusUnknown => 'Stato di programmazione sconosciuto';

  @override
  String get couldNotConfirmReminderStatusOpenTheReminderTo =>
      'Impossibile confermare lo stato del promemoria. Aprilo per verificare.';

  @override
  String get reminderStillPending => 'Promemoria ancora in sospeso';

  @override
  String get nextReminder => 'Prossimo promemoria';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get editReminder => 'Modifica promemoria';

  @override
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor =>
      'Impossibile aprire le impostazioni. Cerca Sveglie e promemoria nelle impostazioni del telefono e seleziona questa app.';

  @override
  String get couldNotOpenSettingsOpenAppsInYourPhone =>
      'Impossibile aprire le impostazioni. Apri App nelle impostazioni del telefono, seleziona questa app e poi Notifiche.';

  @override
  String recordedOn(String p0) {
    return 'Registrato il $p0';
  }

  @override
  String recorded(String p0) {
    return 'Registrato · $p0';
  }

  @override
  String get countingUnitChangedSinceThisEntry =>
      'Unità di conteggio cambiata dopo questa voce';

  @override
  String photosForProgressEntry(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 foto per il progresso $p1',
      one: 'Una foto per il progresso $p1',
      zero: '0 foto per il progresso $p1',
    );
    return '$_temp0';
  }

  @override
  String enteredManually159(String p0) {
    return 'Inserito manualmente: $p0';
  }

  @override
  String photos(String p0) {
    return '$p0 foto';
  }

  @override
  String viewPhotoOf(String p0, String p1) {
    return 'Visualizza foto $p0 di $p1';
  }

  @override
  String photo(String p0) {
    return 'Foto $p0';
  }

  @override
  String editPhoto(String p0) {
    return 'Modifica foto $p0';
  }

  @override
  String get moveEarlier => 'Sposta prima';

  @override
  String get moveLater => 'Sposta dopo';

  @override
  String get replacePhoto => 'Sostituisci foto';

  @override
  String get removePhoto => 'Rimuovi foto';

  @override
  String get noCurrentPhotos => 'Nessuna foto attuale';

  @override
  String get photoUnavailable => 'Foto non disponibile';

  @override
  String get previousPhoto => 'Foto precedente';

  @override
  String get nextPhoto => 'Foto successiva';

  @override
  String currentPhotos(String p0) {
    return 'Foto attuali ($p0)';
  }

  @override
  String get touchAndHoldAPhotoThenDragItTo =>
      'Tieni premuta una foto e trascinala per cambiare l’ordine.';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get takeAnotherPhoto => 'Scatta un’altra foto';

  @override
  String get addPhotosFromGallery => 'Aggiungi foto dalla galleria';

  @override
  String get retakePhoto => 'Scatta di nuovo';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get couldNotLoadProgressEntry =>
      'Impossibile caricare la voce di avanzamento.';

  @override
  String get progressEntryNotFound => 'Voce di avanzamento non trovata.';

  @override
  String get editProgressEntry => 'Modifica avanzamento';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get discardChanges183 => 'Scartare le modifiche?';

  @override
  String get yourChangesToThisProgressEntryHaveNotBeen =>
      'Le modifiche a questa voce non sono state salvate.';

  @override
  String couldNotDiscardChanges(String p0) {
    return 'Impossibile scartare le modifiche: $p0';
  }

  @override
  String photosAddedNotProcessed(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 foto aggiunte.',
      one: 'Una foto aggiunta.',
      zero: 'Nessuna foto aggiunta.',
    );
    return '$_temp0 Non elaborate: $p1';
  }

  @override
  String couldNotAddPhotos(String p0) {
    return 'Impossibile aggiungere le foto: $p0';
  }

  @override
  String couldNotRemovePhoto(String p0) {
    return 'Impossibile rimuovere la foto: $p0';
  }

  @override
  String couldNotSavePhotoOrder(String p0) {
    return 'Impossibile salvare l’ordine delle foto: $p0';
  }

  @override
  String couldNotRestorePhotoDraft(String p0) {
    return 'Impossibile ripristinare la bozza delle foto: $p0';
  }

  @override
  String get changesSaved => 'Modifiche salvate.';

  @override
  String get noChangesToSave => 'Nessuna modifica da salvare.';

  @override
  String couldNotSaveChanges(String p0) {
    return 'Impossibile salvare le modifiche: $p0';
  }

  @override
  String get settings => 'Impostazioni';

  @override
  String get createProject => 'Crea progetto';

  @override
  String get lastEdited => 'Ultima modifica';

  @override
  String get nameAZ => 'Nome A–Z';

  @override
  String get yourProjects => 'I tuoi progetti';

  @override
  String get yourProjectsYourPaceRememberWhereToPickUp =>
      'I tuoi progetti, al tuo ritmo. Ricorda da dove riprendere.';

  @override
  String get searchProjects => 'Cerca progetti';

  @override
  String get nameTechniqueYarnOrNeedleSize =>
      'Nome, tecnica, filato o misura dei ferri';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get text1Project => '1 progetto';

  @override
  String projects(String p0) {
    return '$p0 progetti';
  }

  @override
  String get noProgressEntriesYet => 'Ancora nessuna voce di avanzamento';

  @override
  String lastEdited206(String p0) {
    return 'Ultima modifica: $p0';
  }

  @override
  String reminder(String p0) {
    return 'Promemoria: $p0';
  }

  @override
  String get lastReminderNoneYet => 'Ultimo promemoria: ancora nessuno';

  @override
  String lastReminder(String p0) {
    return 'Ultimo promemoria: $p0';
  }

  @override
  String get everyMinuteDev210 => 'ogni minuto (Dev)';

  @override
  String hourlyFrom(String p0) {
    return 'ogni ora da $p0';
  }

  @override
  String dailyAt(String p0) {
    return 'ogni giorno alle $p0';
  }

  @override
  String weeklyOnAt(String p0, String p1) {
    return 'ogni settimana il $p0 alle $p1';
  }

  @override
  String monthlyOnDayAt(String p0, String p1) {
    return 'ogni mese il giorno $p0 alle $p1';
  }

  @override
  String yearlyOnAt(String p0, String p1, String p2) {
    return 'ogni anno il $p0/$p1 alle $p2';
  }

  @override
  String onTimeWithSound216(String p0) {
    return '$p0 · puntuale con suono';
  }

  @override
  String get noMatchingProjectsFound =>
      'Nessun progetto corrispondente trovato.';

  @override
  String get createYourFirstProject => 'Crea il tuo primo progetto';

  @override
  String get fromTheFirstStitchToTheLastRememberWhich =>
      'Dal primo all’ultimo punto: ricorda da quale riga o giro riprendere, con foto e note solo per te.';

  @override
  String get reload => 'Ricarica';

  @override
  String get couldNotLoadProject => 'Impossibile caricare il progetto.';

  @override
  String get projectNotFound => 'Progetto non trovato.';

  @override
  String get editProject => 'Modifica progetto';

  @override
  String get projectName224 => 'Nome del progetto *';

  @override
  String get enterAProjectName => 'Inserisci un nome per il progetto.';

  @override
  String get yarnOptional => 'Filato (facoltativo)';

  @override
  String get needleOrHookSizeOptional =>
      'Misura dei ferri o dell’uncinetto (facoltativa)';

  @override
  String get countingUnit228 => 'Unità di conteggio *';

  @override
  String get projectReminder => 'Promemoria del progetto';

  @override
  String get optionalAndOnlyOnThisDevice =>
      'Facoltativo e solo su questo dispositivo';

  @override
  String get interval => 'Intervallo';

  @override
  String get month => 'Mese';

  @override
  String get dayOfWeek => 'Giorno della settimana';

  @override
  String get day => 'Giorno';

  @override
  String get devModeTheNextReminderIsScheduledForThe =>
      'Modalità Dev: il prossimo promemoria è previsto all’inizio del minuto successivo. I promemoria normali possono arrivare con un leggero ritardo.';

  @override
  String get startDate => 'Data di inizio';

  @override
  String get changeDate => 'Cambia data';

  @override
  String get startTime => 'Ora di inizio';

  @override
  String get changeTime => 'Cambia ora';

  @override
  String every60MinutesFromTheSelectedStartNextReminder(String p0) {
    return 'Ogni 60 minuti dall’inizio scelto. Prossimo promemoria: $p0.';
  }

  @override
  String get time => 'Ora';

  @override
  String get reminderType => 'Tipo di promemoria';

  @override
  String get mayArriveSlightlyLateRespectsTheSystemDoNot =>
      'Può arrivare con un leggero ritardo. Rispetta la modalità Non disturbare del sistema.';

  @override
  String get triggersAsCloseAsPossibleToTheSelectedTime =>
      'Si attiva il più vicino possibile all’orario scelto, come una sveglia.';

  @override
  String get openAlarmsReminders => 'Apri Sveglie e promemoria';

  @override
  String get testReminderNow => 'Prova il promemoria ora';

  @override
  String get checkTheNotificationShadeDuringTheTestTheTest =>
      'Controlla il pannello delle notifiche durante la prova. Il promemoria viene rimosso automaticamente dopo un minuto.';

  @override
  String get theReminderIsNotConfirmedSavingWillSetIt =>
      'Il promemoria non è confermato. Salvando verrà configurato di nuovo.';

  @override
  String get saving => 'Salvataggio…';

  @override
  String get everythingSaved => 'Tutto salvato';

  @override
  String get saveReminderAgain => 'Salva di nuovo il promemoria';

  @override
  String get saveProject => 'Salva progetto';

  @override
  String get discardInput => 'Scartare i dati inseriti?';

  @override
  String get yourChangesToThisProjectHaveNotBeenSaved =>
      'Le modifiche a questo progetto non sono state salvate.';

  @override
  String get yourNewProjectDetailsHaveNotBeenSaved =>
      'I dati del nuovo progetto non sono stati salvati.';

  @override
  String get discardInput256 => 'Scarta dati inseriti';

  @override
  String get androidPermissionForOnTimeWithSoundIsMissing =>
      'Manca l’autorizzazione Android per Puntuale con suono. Seleziona di nuovo la modalità e concedi l’autorizzazione.';

  @override
  String get projectSavedRemindersAreBlockedInAndroid =>
      'Progetto salvato. I promemoria sono bloccati in Android.';

  @override
  String get projectSavedYouCanNowAddYourFirstProgress =>
      'Progetto salvato. Ora puoi aggiungere la prima voce di avanzamento.';

  @override
  String get projectChangesSaved => 'Modifiche al progetto salvate.';

  @override
  String couldNotSave(String p0) {
    return 'Impossibile salvare: $p0';
  }

  @override
  String get thisTimeIsUnavailableDueToTheDaylightSaving =>
      'Questo orario non è disponibile a causa del cambio dell’ora. Scegli un altro orario.';

  @override
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime =>
      'Impossibile aprire le impostazioni Android Sveglie e promemoria. Puntuale con suono resta selezionato.';

  @override
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice =>
      'Le impostazioni Android Sveglie e promemoria non sono disponibili su questo dispositivo.';

  @override
  String get afterSavingUse => 'Dopo il salvataggio, usa ';

  @override
  String get toAddAndRecordYourFirstProgressEntry =>
      ' per aggiungere la prima voce di avanzamento.';

  @override
  String get androidMustAllowAlarmsRemindersForOnTimeReminders =>
      'Android deve consentire Sveglie e promemoria per gli avvisi puntuali. Concedi l’accesso perché il promemoria possa suonare all’orario scelto.';

  @override
  String get allowAlarmsReminders => 'Consenti Sveglie e promemoria';

  @override
  String get notificationsAreTurnedOff269 => 'Le notifiche sono disattivate';

  @override
  String get thisReminderCategoryIsTurnedOff270 =>
      'Questa categoria di promemoria è disattivata';

  @override
  String get doNotDisturbIsOn => 'Non disturbare è attivo';

  @override
  String get androidIsBlockingNotificationsForStrickHKelbuchYou =>
      'Android blocca le notifiche di Strick & Häkelbuch. Puoi consentirle nelle impostazioni Android.';

  @override
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0) {
    return 'Android blocca “$p0”. Puoi attivare questa categoria nelle impostazioni Android.';
  }

  @override
  String get projectReminders => 'Promemoria dei progetti';

  @override
  String get onTimeProjectReminders => 'Promemoria puntuali dei progetti';

  @override
  String get standardRemindersMayAppearWithoutSoundOrABanner =>
      'I promemoria normali possono apparire senza suono o banner. Controlla anche il pannello delle notifiche.';

  @override
  String get alarmSoundAndBannersDependOnYourDoNot =>
      'Suoni e banner dipendono dalle impostazioni Non disturbare e dal volume delle sveglie.';

  @override
  String get openAndroidSettings => 'Apri impostazioni Android';

  @override
  String get openDoNotDisturb => 'Apri Non disturbare';

  @override
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings =>
      'Impossibile aprire le impostazioni di sistema. Cerca Non disturbare nelle impostazioni del telefono.';

  @override
  String get couldNotOpenSystemSettingsInYourPhoneSettings =>
      'Impossibile aprire le impostazioni di sistema. Apri App nelle impostazioni del telefono, poi Strick & Häkelbuch e Notifiche.';

  @override
  String get sortPhotos => 'Ordina foto';

  @override
  String get projectReportSingleEntry =>
      'Resoconto del progetto · Singola voce';

  @override
  String get preparingTheProgressEntryAndNotesForTheCompact =>
      'Preparazione dell’avanzamento e delle note per il PDF compatto.';

  @override
  String get preparingCurrentPhotosProgressAndNotesForThePDF =>
      'Preparazione delle foto attuali, dell’avanzamento e delle note per il PDF.';

  @override
  String couldNotCreatePDF(String p0) {
    return 'Impossibile creare il PDF: $p0';
  }

  @override
  String get theSavedPDFFileIsMissing => 'Il file PDF salvato è mancante.';

  @override
  String get deleteProjectReport288 => 'Eliminare il resoconto del progetto?';

  @override
  String get thePDFWillBePermanentlyDeletedFromStrickH =>
      'Il PDF verrà eliminato definitivamente da Strick & Häkelbuch. Le copie già condivise o salvate fuori dall’app resteranno disponibili.';

  @override
  String get projectReportDeleted => 'Resoconto del progetto eliminato.';

  @override
  String get couldNotDeleteProjectReportPleaseTryAgain =>
      'Impossibile eliminare il resoconto del progetto. Riprova.';

  @override
  String get deleteProgressEntry => 'Eliminare la voce di avanzamento?';

  @override
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill =>
      'Questa voce, i suoi allegati e i relativi PDF singoli verranno eliminati definitivamente. I PDF della cronologia e le copie fuori dall’app saranno conservati.';

  @override
  String get progressEntryDeleted => 'Voce di avanzamento eliminata.';

  @override
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry =>
      'Impossibile eliminare completamente la voce di avanzamento. Riprova.';

  @override
  String get reportForThisProgressEntry =>
      'Resoconto di questa voce di avanzamento';

  @override
  String get createProjectReportAsPDF => 'Crea resoconto del progetto in PDF';

  @override
  String get edit => 'Modifica';

  @override
  String get deleteProgressEntry299 => 'Elimina avanzamento';

  @override
  String get source => 'Origine';

  @override
  String get lowerCount301 => 'Conteggio inferiore';

  @override
  String get project => 'Progetto';

  @override
  String get couldNotLoadProgressEntries =>
      'Impossibile caricare le voci di avanzamento.';

  @override
  String get recordProgress => 'Registra avanzamento';

  @override
  String ofProgressEntries(String p0, String p1) {
    return '$p0 di $p1 voci di avanzamento';
  }

  @override
  String get showAllProgressEntries => 'Mostra tutti gli avanzamenti';

  @override
  String get preparingProgressEntriesAndNotesForTheCompactPDF =>
      'Preparazione degli avanzamenti e delle note per il PDF compatto.';

  @override
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe =>
      'Preparazione degli avanzamenti, delle foto attuali e delle note per il PDF.';

  @override
  String get deleteProject => 'Eliminare il progetto?';

  @override
  String get allProgressEntriesProgressPhotosAndLocallySavedReports =>
      'Tutti gli avanzamenti, le foto e i resoconti salvati sul dispositivo per questo progetto verranno eliminati definitivamente. I file già condivisi fuori dall’app saranno conservati.';

  @override
  String get projectDeleted => 'Progetto eliminato.';

  @override
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain =>
      'Impossibile eliminare completamente il progetto. Riprova.';

  @override
  String get editProjectReminder => 'Modifica progetto e promemoria';

  @override
  String get deleteProject314 => 'Elimina progetto';

  @override
  String get createReportForProjectHistory =>
      'Crea resoconto della cronologia del progetto';

  @override
  String lastRecordedOn(String p0) {
    return 'Ultima registrazione il $p0';
  }

  @override
  String yarn317(String p0) {
    return 'Filato: $p0';
  }

  @override
  String needleOrHookSize318(String p0) {
    return 'Misura dei ferri o dell’uncinetto: $p0';
  }

  @override
  String reminder319(String p0) {
    return 'Promemoria: $p0';
  }

  @override
  String get noProgressEntryYetEnterYourCurrentRowOr =>
      'Ancora nessun avanzamento. Inserisci la riga o il giro attuale, con o senza una foto del progetto.';

  @override
  String get recordFirstProgressEntry => 'Registra il primo avanzamento';

  @override
  String get changeDateTime => 'Cambia data e ora';

  @override
  String get enterProgress => 'Inserisci avanzamento';

  @override
  String get photographProject => 'Fotografa progetto';

  @override
  String get photosFromGallery => 'Foto dalla galleria';

  @override
  String get preparingPhoto => 'Preparazione della foto…';

  @override
  String get enterWhereYouLeftOff => 'Indica dove ti sei fermato.';

  @override
  String get optionalEGStartedTheSleeve =>
      'Facoltativo, ad es. iniziata la manica';

  @override
  String get saveProgressEntry => 'Salva avanzamento';

  @override
  String get confirmAndSaveProgress => 'Conferma e salva avanzamento';

  @override
  String get discardProgressEntry => 'Scartare l’avanzamento?';

  @override
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen =>
      'L’avanzamento e le foto selezionate non sono stati salvati.';

  @override
  String get discardProgressEntry333 => 'Scarta avanzamento';

  @override
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain =>
      'Impossibile rimuovere le foto non salvate. Riprova.';

  @override
  String get progressEntrySaved => 'Avanzamento salvato.';

  @override
  String get pickUpFromHere => 'Riprendi da qui';

  @override
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow =>
      'Ricorda la riga o il giro attuale. Le foto mostrano com’è il progetto in questo momento.';

  @override
  String get youEnterYourProgressYourselfPhotosAndNotesStay =>
      'Inserisci tu l’avanzamento. Foto e note restano sul tuo dispositivo.';

  @override
  String get knittingScarf => 'Maglia · Sciarpa';

  @override
  String get layYourProjectFlatSoItsShapeAndPattern =>
      'Stendi il progetto in piano per mostrare bene forma e motivo.';

  @override
  String get knittingHatInTheRound => 'Maglia · Cappello in tondo';

  @override
  String get includeTheWorkingNeedleAndTheMarkedStartOf =>
      'Mostra anche il ferro in uso e il segnapunti di inizio giro.';

  @override
  String get crochetGrannySquare => 'Uncinetto · Mattonella granny';

  @override
  String get photographTheWholeMotifIncludingWhereYouWillContinue =>
      'Fotografa l’intero motivo, incluso il punto da cui riprenderai.';

  @override
  String get crochetBasketInTheRound => 'Uncinetto · Cestino in tondo';

  @override
  String get aSlightlyAngledViewShowsTheBaseHeightAnd =>
      'Una vista leggermente inclinata mostra il fondo, l’altezza e il bordo di lavoro.';

  @override
  String get viewExamples => 'Vedi esempi';

  @override
  String get examplePhotos => 'Foto di esempio';

  @override
  String get close => 'Chiudi';

  @override
  String get photographYourProjectInGoodLightEnterTheCurrent =>
      'Fotografa il progetto con una buona luce. Inserisci tu la riga o il giro attuale.';

  @override
  String examplePhoto(String p0) {
    return 'Foto di esempio: $p0';
  }

  @override
  String get couldNotLoadExample => 'Impossibile caricare l’esempio.';

  @override
  String get previousExample => 'Esempio precedente';

  @override
  String get nextExample => 'Esempio successivo';

  @override
  String get noProgressEntriesYet356 => 'Ancora nessuna voce di avanzamento.';

  @override
  String get matches => 'risultati';

  @override
  String get progressEntries => 'voci di avanzamento';

  @override
  String of359(String p0, String p1, String p2, String p3) {
    return '$p0–$p1 di $p2 $p3';
  }

  @override
  String get searchProgressEntries => 'Cerca avanzamenti';

  @override
  String get dateRowRoundOrNote => 'Data, riga/giro o nota';

  @override
  String get noMatchingProgressEntryFound =>
      'Nessuna voce di avanzamento corrispondente.';

  @override
  String get searchByDateCurrentRowOrRoundOrA =>
      'Cerca per data, riga o giro attuale, o una parola della nota.';

  @override
  String get choosingASaveLocationIsNotYetAvailableOn =>
      'La scelta della posizione di salvataggio non è ancora disponibile su questa piattaforma.';

  @override
  String get strickHKelbuchBackup => 'Backup di Strick & Häkelbuch';

  @override
  String get projects366 => 'Progetti';

  @override
  String get progressEntries367 => 'Voci di avanzamento';

  @override
  String get backup => 'Backup';

  @override
  String get createEncryptedBackup => 'Crea backup crittografato';

  @override
  String get projectsPhotosAndProjectReports => 'Progetti, foto e resoconti';

  @override
  String get restoreBackup => 'Ripristina backup';

  @override
  String get newerExistingEntriesArePreserved =>
      'Le voci esistenti più recenti vengono conservate';

  @override
  String get privacy => 'Privacy';

  @override
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn =>
      'Foto, avanzamenti e PDF vengono elaborati sul tuo dispositivo. L’app non invia i dati dei progetti a un server.';

  @override
  String get yourDataStaysOnYourDeviceUntilYouDelete =>
      'I tuoi dati restano sul dispositivo finché non li elimini nell’app o cancelli i dati dell’app.';

  @override
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI =>
      'Sviluppatore e contatto per la privacy\nWasiliy Strecker · AppFabrik AI';

  @override
  String get openPrivacyPolicy => 'Apri informativa sulla privacy';

  @override
  String get aboutStrickHKelbuch => 'Informazioni su Strick & Häkelbuch';

  @override
  String get sourceCodeOnGitHub => 'Codice sorgente su GitHub';

  @override
  String get theSourceCodeCouldNotBeOpened =>
      'Impossibile aprire il codice sorgente. Riprova.';

  @override
  String get openSourceMPL20 => 'Codice aperto · MPL 2.0';

  @override
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain =>
      'Impossibile aprire l’informativa sulla privacy. Riprova.';

  @override
  String get preparingFiles => 'Preparazione dei file…';

  @override
  String couldNotCreateBackup(String p0) {
    return 'Impossibile creare il backup: $p0';
  }

  @override
  String get savingBackup => 'Salvataggio del backup…';

  @override
  String couldNotShareBackup(String p0) {
    return 'Impossibile condividere il backup: $p0';
  }

  @override
  String get backupSaved => 'Backup salvato';

  @override
  String wasSavedToTheSelectedLocation(String p0) {
    return '$p0 è stato salvato nella posizione scelta.';
  }

  @override
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 · $p1 · $p2\n$p3 MB · Creato il $p4';
  }

  @override
  String get projectReports => 'Resoconti dei progetti';

  @override
  String get done => 'Fatto';

  @override
  String get couldNotSaveBackup => 'Impossibile salvare il backup';

  @override
  String get backupNotSavedYet => 'Backup non ancora salvato';

  @override
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe =>
      'Il file crittografato è conservato solo temporaneamente nell’app. Scegli una posizione per mantenere il backup.';

  @override
  String get discardBackup => 'Scarta backup';

  @override
  String get chooseSaveLocation => 'Scegli posizione';

  @override
  String get chooseAStrickHKelbuchBackupFileShbackup =>
      'Scegli un file di backup di Strick & Häkelbuch (.shbackup).';

  @override
  String get couldNotOpenTheSelectedBackupFile =>
      'Impossibile aprire il file di backup selezionato.';

  @override
  String couldNotSelectBackupFile(String p0) {
    return 'Impossibile selezionare il file di backup: $p0';
  }

  @override
  String get checkingBackup => 'Verifica del backup…';

  @override
  String get restoreBackup402 => 'Ripristinare il backup?';

  @override
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  ) {
    return 'Verranno importati $p0, $p1 e $p2. Le voci locali più recenti non verranno sovrascritte.';
  }

  @override
  String get restore => 'Ripristina';

  @override
  String get restoringBackup => 'Ripristino del backup…';

  @override
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  ) {
    return 'Ripristinati $p0 e $p1. Ignorate $p2 voci invariate o più recenti.$p3$p4';
  }

  @override
  String get photo407 => 'Foto';

  @override
  String get photos408 => 'Foto';

  @override
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0) {
    return ' Non è stato possibile confermare i promemoria per $p0 voci. Controllali nella panoramica.';
  }

  @override
  String couldNotRestoreBackup(String p0) {
    return 'Impossibile ripristinare il backup: $p0';
  }

  @override
  String get thePasswordMustHaveAtLeast6Characters =>
      'La password deve contenere almeno 6 caratteri.';

  @override
  String get thePasswordIsIncorrectOrTheBackupHasBeen =>
      'La password è errata oppure il backup è stato modificato.';

  @override
  String aFileToBackUpIsMissing(String p0) {
    return 'Manca un file da includere nel backup: $p0';
  }

  @override
  String get aFileInTheBackupIsDamagedOrIncomplete =>
      'Un file nel backup è danneggiato o incompleto.';

  @override
  String get thisBackupVersionIsNotSupported =>
      'Questa versione del backup non è supportata.';

  @override
  String get theSelectedFileIsNotAValidStrickH =>
      'Il file selezionato non è un backup valido di Strick & Häkelbuch.';

  @override
  String get preparingFiles417 => 'Preparazione dei file';

  @override
  String get encryptingBackup => 'Crittografia del backup';

  @override
  String get finishingBackup => 'Completamento del backup';

  @override
  String get backupReady => 'Backup pronto';

  @override
  String get pleaseWaitAMoment => 'Attendi un momento.';

  @override
  String get gatheringPhotosAndProjectReports =>
      'Raccolta delle foto e dei resoconti dei progetti.';

  @override
  String ofFiles(String p0, String p1) {
    return '$p0 di $p1 file';
  }

  @override
  String get setBackupPassword => 'Imposta password del backup';

  @override
  String get password => 'Password';

  @override
  String get atLeast6Characters => 'Almeno 6 caratteri';

  @override
  String get repeatPassword => 'Ripeti password';

  @override
  String progressEquation(String p0, String p1) {
    return ' $p0 = $p1 di progresso';
  }

  @override
  String get unitChanged => '– (unità cambiata)';

  @override
  String reportCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resoconti del progetto',
      one: '$count resoconto del progetto',
    );
    return '$_temp0';
  }

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voci di avanzamento',
      one: '$count voce di avanzamento',
    );
    return '$_temp0';
  }

  @override
  String projectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count progetti',
      one: '$count progetto',
    );
    return '$_temp0';
  }

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foto',
      one: '$count foto',
    );
    return '$_temp0';
  }

  @override
  String matchCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count risultati',
      one: '$count risultato',
    );
    return '$_temp0';
  }

  @override
  String includedEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voci di avanzamento incluse',
      one: '$count voce di avanzamento inclusa',
    );
    return '$_temp0';
  }

  @override
  String reminderDeadline(String p0, String p1) {
    return '$p0$p1';
  }

  @override
  String get reminderNotProcessed =>
      '. Android non ha ancora elaborato questo promemoria.';

  @override
  String progressChange(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 $p1 → $p2 = $p3 $p4 di progresso';
  }

  @override
  String get projectNameExample => 'ad es. Il mio maglione salvia';

  @override
  String get yarnExample => 'ad es. Lana merino, salvia';

  @override
  String needleSizeExample(String size) {
    return 'ad es. $size mm';
  }

  @override
  String get recordProgressQuoted => '“Registra avanzamento”';

  @override
  String get examplePhotoDisclaimer =>
      'Esempi generati con IA · solo da visualizzare';

  @override
  String repairedFiles(String p0) {
    return ' Riparati $p0.';
  }

  @override
  String get backupPassword => 'Password del backup';

  @override
  String get language => 'Lingua';

  @override
  String get systemLanguage => 'Lingua di sistema';

  @override
  String get languageHelp =>
      'Numeri e date continuano a seguire la regione del dispositivo.';

  @override
  String get languageSaveFailed => 'Impossibile salvare la lingua. Riprova.';

  @override
  String get unexpectedError => 'Impossibile completare l’operazione. Riprova.';

  @override
  String get passwordMismatch => 'Le password non corrispondono.';

  @override
  String get currentRow => 'Riga attuale';

  @override
  String get currentRound => 'Giro attuale';

  @override
  String lastProgress(String value, String unit) {
    return 'Ultimo avanzamento: $value $unit';
  }

  @override
  String get reminderBody =>
      'Annota la riga o il giro attuale e riprendi con calma più tardi.';

  @override
  String testNotificationTitle(String technique, String name) {
    return 'Prova: $technique · $name';
  }

  @override
  String get testNotificationApp =>
      'Questo è un promemoria di prova. Tocca per aprire l’app.';

  @override
  String get testNotificationProject =>
      'Questo è un promemoria di prova. Tocca per aprire il progetto.';

  @override
  String get normalChannelDescription =>
      'Promemoria facoltativi per registrare regolarmente i progressi.';

  @override
  String get exactChannelDescription =>
      'Promemoria puntuali dei progetti con suono di sveglia.';

  @override
  String get reportFilePrefix => 'avanzamento';

  @override
  String get historyFilePrefix => 'cronologia_progetto';

  @override
  String get compactFilePart => 'compatto';

  @override
  String get photosFilePart => 'con_foto';

  @override
  String annualReminder(String date, String time) {
    return 'ogni anno il $date alle $time';
  }

  @override
  String positionOfTotal(String p0, String p1) {
    return '$p0 di $p1';
  }

  @override
  String rowQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Righe',
      one: 'Riga',
    );
    return '$_temp0';
  }

  @override
  String roundQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Giri',
      one: 'Giro',
    );
    return '$_temp0';
  }
}
