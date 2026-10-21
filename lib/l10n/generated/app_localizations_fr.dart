// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get discardChanges => 'Abandonner les modifications';

  @override
  String get continueEditing => 'Continuer la modification';

  @override
  String get creatingProjectReport => 'Création du rapport de projet';

  @override
  String get pleaseWait => 'Veuillez patienter…';

  @override
  String testReminderSentToAndroidOpenTheNotificationShade(String p0) {
    return 'Rappel de test transmis à Android. Ouvrez le volet des notifications. Le rappel disparaîtra après une minute.$p0';
  }

  @override
  String get doNotDisturbIsOnSoundAndBannersMay =>
      ' Le mode Ne pas déranger est activé. Le son et les bannières peuvent être masqués.';

  @override
  String get notificationsAreNotAllowed =>
      'Les notifications ne sont pas autorisées.';

  @override
  String get thisReminderCategoryIsBlockedInAndroid =>
      'Cette catégorie de rappels est bloquée dans Android.';

  @override
  String get couldNotShowTheTestReminder =>
      'Impossible d’afficher le rappel de test.';

  @override
  String get testRemindersAreNotSupportedOnThisDevice =>
      'Les rappels de test ne sont pas pris en charge sur cet appareil.';

  @override
  String get anHourlyReminderRequiresAStartTime =>
      'Un rappel horaire nécessite une heure de début.';

  @override
  String get dataSavedCouldNotTurnOffTheReminderOpen =>
      'Données enregistrées. Impossible de désactiver le rappel. Ouvrez-le et enregistrez à nouveau.';

  @override
  String get dataSavedRemindersAreBlockedInAndroidOpenThe =>
      'Données enregistrées. Les rappels sont bloqués dans Android. Ouvrez le rappel, puis les paramètres Android.';

  @override
  String get dataSavedRemindersAreNotSupportedOnThisDevice =>
      'Données enregistrées. Les rappels ne sont pas pris en charge sur cet appareil.';

  @override
  String get dataSavedTheReminderCouldNotBeConfirmedOpen =>
      'Données enregistrées. Le rappel n’a pas pu être confirmé. Ouvrez-le et enregistrez à nouveau.';

  @override
  String get dataSavedForAnOnTimeReminderOpenAlarms =>
      'Données enregistrées. Pour un rappel ponctuel, ouvrez Alarmes et rappels dans les paramètres Android.';

  @override
  String get dataSavedCouldNotCheckReminderStatusOpenThe =>
      'Données enregistrées. Impossible de vérifier l’état du rappel. Ouvrez-le et enregistrez à nouveau.';

  @override
  String get whatIsTheProjectReportFor => 'À quoi sert le rapport de projet ?';

  @override
  String get beforeCreatingItChooseACompactReportWithoutPhotos =>
      'Avant de le créer, choisissez un rapport compact sans photos ou avec toutes les photos actuelles. Les deux incluent les avancements, les dates et les notes, à enregistrer, imprimer ou partager.';

  @override
  String get itRecordsYourProjectProgressUsingTheInformationYou =>
      'Il documente l’avancement de votre projet à partir des informations que vous avez confirmées.';

  @override
  String get thePDFBringsTogetherAllProgressEntriesAndNotes =>
      'Le PDF regroupe tous les avancements et les notes. Choisissez un rapport compact sans photos ou incluez toutes les photos actuelles de chaque entrée, à enregistrer, imprimer ou partager.';

  @override
  String get personalRecordOfYourProjectProgress =>
      'Documentation personnelle de l’avancement de votre projet.';

  @override
  String get couldNotSaveThePhotoDraft =>
      'Impossible d’enregistrer le brouillon des photos.';

  @override
  String get couldNotRemoveThePhotoDraft =>
      'Impossible de supprimer le brouillon des photos.';

  @override
  String get manualEntryDoesNotAccessPhotos =>
      'La saisie manuelle n’accède pas aux photos.';

  @override
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt =>
      'Impossible d’optimiser la photo de manière sûre. Sélectionnez-la à nouveau.';

  @override
  String get compactWithoutPhotos => 'Compact, sans photos';

  @override
  String get withCurrentPhotos => 'Avec les photos actuelles';

  @override
  String get withAllPhotosOlderVersion =>
      'Avec toutes les photos (ancienne version)';

  @override
  String get thisProjectHasNoProgressEntriesYet =>
      'Ce projet ne comporte pas encore d’entrées d’avancement.';

  @override
  String get theProgressEntriesDoNotBelongToThisProject =>
      'Les entrées d’avancement n’appartiennent pas à ce projet.';

  @override
  String get projectReport => 'Rapport de projet';

  @override
  String get personalRecordOfProjectProgress =>
      'Documentation personnelle d’un avancement de projet';

  @override
  String pageOf(String p0, String p1) {
    return 'Page $p0 sur $p1';
  }

  @override
  String get singleProgressEntry => 'Entrée d’avancement unique';

  @override
  String get projectHistory => 'Historique du projet';

  @override
  String pdfCreatedOn(String p0, String p1) {
    return 'PDF créé le $p0 · $p1';
  }

  @override
  String get currentProjectDetails => 'Informations actuelles du projet';

  @override
  String get projectDetailsWhenRecorded =>
      'Informations du projet lors de la saisie';

  @override
  String get technique => 'Technique';

  @override
  String get projectName => 'Nom du projet';

  @override
  String get yarn => 'Fil';

  @override
  String get needleOrHookSize => 'Taille des aiguilles ou du crochet';

  @override
  String get countingUnit => 'Unité de comptage';

  @override
  String get no => 'N°';

  @override
  String get dateAndTime => 'Date et heure';

  @override
  String get progressEntry => 'Entrée d’avancement';

  @override
  String get progress => 'Progression';

  @override
  String get notSpecified => 'Non renseigné';

  @override
  String progressEntry53(String p0) {
    return 'Entrée d’avancement $p0';
  }

  @override
  String get progressDateAndTime => 'Date et heure de l’avancement';

  @override
  String progressEntry55(String p0, String p1, String p2) {
    return 'Entrée d’avancement $p0 · $p1 · $p2';
  }

  @override
  String lowerCount(String p0) {
    return 'Compteur inférieur : $p0';
  }

  @override
  String get note => 'Note';

  @override
  String earlierPhoto(String p0) {
    return 'Photo antérieure $p0';
  }

  @override
  String photoOf(String p0, String p1) {
    return 'Photo $p0 sur $p1';
  }

  @override
  String get couldNotEmbedTheProgressPhoto =>
      'Impossible d’intégrer la photo d’avancement.';

  @override
  String get noPreparedPhotoFileAvailable =>
      'Aucun fichier photo préparé n’est disponible.';

  @override
  String createdOn(String p0) {
    return 'Créé le $p0';
  }

  @override
  String get savedLocally => 'Enregistré localement';

  @override
  String get fileMissing => 'Fichier manquant';

  @override
  String get deleteProjectReport => 'Supprimer le rapport de projet';

  @override
  String get savedProjectReports => 'Rapports de projet enregistrés';

  @override
  String get couldNotLoadProjectReports => 'Impossible de charger les rapports';

  @override
  String get loadingProjectReports => 'Chargement des rapports de projet…';

  @override
  String get couldNotLoadProjectReports73 =>
      'Impossible de charger les rapports de projet.';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get checkingPDFFile => 'Vérification du fichier PDF…';

  @override
  String couldNotCheckFileStatusNProjectReportFrom(String p0) {
    return 'Impossible de vérifier l’état du fichier.\nRapport de projet du $p0';
  }

  @override
  String get projectReportHistory => 'Rapport de projet · Historique';

  @override
  String progressEntriesIncluded(String p0) {
    return '$p0 entrées d’avancement incluses';
  }

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get print => 'Imprimer';

  @override
  String get projectReportFromStrickHKelbuch =>
      'Rapport de projet de Strick & Häkelbuch';

  @override
  String get share => 'Partager';

  @override
  String get choosePDFContent => 'Choisir le contenu du PDF';

  @override
  String get chooseWhatToIncludeInYourPDF =>
      'Choisissez le contenu de votre PDF.';

  @override
  String get progressEntriesDatesAndNotesCompactWithoutPhotos =>
      'Entrées d’avancement, dates et notes, en format compact sans photos.';

  @override
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry =>
      'Inclut toutes les photos actuellement associées à cette entrée.';

  @override
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry =>
      'Inclut toutes les photos actuellement associées à chaque entrée.';

  @override
  String get noCurrentPhotosAvailable => 'Aucune photo actuelle disponible.';

  @override
  String get cameraPhoto => 'Photo de l’appareil';

  @override
  String get galleryImport => 'Importation de la galerie';

  @override
  String get enteredManually => 'Saisi manuellement';

  @override
  String get newProjectSection => 'Nouvelle section du projet';

  @override
  String get projectRestarted => 'Projet recommencé';

  @override
  String get correctionOfAnEarlierEntry => 'Correction d’une entrée précédente';

  @override
  String get otherReason => 'Autre raison';

  @override
  String get knitting => 'Tricot';

  @override
  String get crochet => 'Crochet';

  @override
  String get rows => 'Rangs';

  @override
  String get rounds => 'Tours';

  @override
  String get round => 'Tour';

  @override
  String get row => 'Rang';

  @override
  String current(String p0) {
    return '$p0 actuel';
  }

  @override
  String get everyMinuteDev => 'Chaque minute (Dev)';

  @override
  String get hourly => 'Toutes les heures';

  @override
  String get daily => 'Tous les jours';

  @override
  String get weekly => 'Chaque semaine';

  @override
  String get monthly => 'Chaque mois';

  @override
  String get yearly => 'Chaque année';

  @override
  String get standardReminder => 'Rappel normal';

  @override
  String get onTimeWithSound => 'Ponctuel avec son';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get preparingPhotos => 'Préparation des photos…';

  @override
  String preparingPhotosOf(String p0, String p1) {
    return 'Préparation des photos : $p0 sur $p1';
  }

  @override
  String get removingPhoto => 'Suppression de la photo…';

  @override
  String get thePhotoOrderMustIncludeAllCurrentPhotos =>
      'L’ordre doit inclure toutes les photos actuelles.';

  @override
  String get savingPhotoOrder => 'Enregistrement de l’ordre des photos…';

  @override
  String get removingUnsavedPhotos =>
      'Suppression des photos non enregistrées…';

  @override
  String get couldNotTurnOffTheReminderPleaseTryAgain =>
      'Impossible de désactiver le rappel. Veuillez réessayer.';

  @override
  String get aPhotoRequiresACameraOrGallerySource =>
      'Une photo doit provenir de l’appareil photo ou de la galerie.';

  @override
  String get doNotSupplyPhotosAndASinglePhotoReplacement =>
      'Ne fournissez pas de photos et de remplacement individuel simultanément.';

  @override
  String get aChangedPhotoRequiresANewPhotoID =>
      'Une photo modifiée nécessite un nouvel identifiant.';

  @override
  String get photosRequireUniqueIDsFilesAndAPhotoSource =>
      'Les photos nécessitent des identifiants uniques, des fichiers et une source.';

  @override
  String get enterAWholeNumberOf0OrMore =>
      'Saisissez un nombre entier supérieur ou égal à 0.';

  @override
  String get couldNotTurnOff => 'Échec de la désactivation';

  @override
  String get openTheReminderAndSaveAgain =>
      'Ouvrez le rappel et enregistrez à nouveau.';

  @override
  String get reminderBlocked => 'Rappel bloqué';

  @override
  String get notificationsAreTurnedOff => 'Les notifications sont désactivées.';

  @override
  String get thisReminderCategoryIsTurnedOff =>
      'Cette catégorie de rappels est désactivée.';

  @override
  String get remindersNotSupported => 'Rappels non pris en charge';

  @override
  String get thisDeviceCannotShowReminders =>
      'Cet appareil ne peut pas afficher de rappels.';

  @override
  String get reminderNotScheduled => 'Rappel non programmé';

  @override
  String get exactTimingNotAllowed => 'Horaire exact non autorisé';

  @override
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder =>
      'Autorisez Alarmes et rappels dans Android. En attendant, le rappel peut arriver en retard.';

  @override
  String get exactSchedulingPending => 'Programmation exacte en attente';

  @override
  String get theScheduledTimeIsStillApproximateOpenTheReminder =>
      'L’horaire programmé est encore approximatif. Ouvrez le rappel et enregistrez à nouveau.';

  @override
  String get lastDeliveryFailed => 'Dernier envoi échoué';

  @override
  String get openTheReminderAndChooseTestReminderNow =>
      'Ouvrez le rappel et choisissez Tester le rappel maintenant.';

  @override
  String get schedulingStatusUnknown => 'État de programmation inconnu';

  @override
  String get couldNotConfirmReminderStatusOpenTheReminderTo =>
      'Impossible de confirmer l’état du rappel. Ouvrez-le pour vérifier.';

  @override
  String get reminderStillPending => 'Rappel toujours en attente';

  @override
  String get nextReminder => 'Prochain rappel';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get editReminder => 'Modifier le rappel';

  @override
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor =>
      'Impossible d’ouvrir les paramètres. Recherchez Alarmes et rappels dans les paramètres du téléphone et sélectionnez cette application.';

  @override
  String get couldNotOpenSettingsOpenAppsInYourPhone =>
      'Impossible d’ouvrir les paramètres. Ouvrez Applications dans les paramètres du téléphone, sélectionnez cette application, puis Notifications.';

  @override
  String recordedOn(String p0) {
    return 'Saisi le $p0';
  }

  @override
  String recorded(String p0) {
    return 'Saisi · $p0';
  }

  @override
  String get countingUnitChangedSinceThisEntry =>
      'Unité de comptage modifiée depuis cette entrée';

  @override
  String photosForProgressEntry(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 photos pour la progression $p1',
      one: 'Une photo pour la progression $p1',
      zero: '0 photos pour la progression $p1',
    );
    return '$_temp0';
  }

  @override
  String enteredManually159(String p0) {
    return 'Saisi manuellement : $p0';
  }

  @override
  String photos(String p0) {
    return '$p0 photos';
  }

  @override
  String viewPhotoOf(String p0, String p1) {
    return 'Voir la photo $p0 sur $p1';
  }

  @override
  String photo(String p0) {
    return 'Photo $p0';
  }

  @override
  String editPhoto(String p0) {
    return 'Modifier la photo $p0';
  }

  @override
  String get moveEarlier => 'Avancer';

  @override
  String get moveLater => 'Reculer';

  @override
  String get replacePhoto => 'Remplacer la photo';

  @override
  String get removePhoto => 'Retirer la photo';

  @override
  String get noCurrentPhotos => 'Aucune photo actuelle';

  @override
  String get photoUnavailable => 'Photo indisponible';

  @override
  String get previousPhoto => 'Photo précédente';

  @override
  String get nextPhoto => 'Photo suivante';

  @override
  String currentPhotos(String p0) {
    return 'Photos actuelles ($p0)';
  }

  @override
  String get touchAndHoldAPhotoThenDragItTo =>
      'Appuyez longuement sur une photo, puis faites-la glisser pour la déplacer.';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get takeAnotherPhoto => 'Prendre une autre photo';

  @override
  String get addPhotosFromGallery => 'Ajouter des photos de la galerie';

  @override
  String get retakePhoto => 'Reprendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get couldNotLoadProgressEntry =>
      'Impossible de charger l’entrée d’avancement.';

  @override
  String get progressEntryNotFound => 'Entrée d’avancement introuvable.';

  @override
  String get editProgressEntry => 'Modifier l’avancement';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get discardChanges183 => 'Abandonner les modifications ?';

  @override
  String get yourChangesToThisProgressEntryHaveNotBeen =>
      'Vos modifications de cette entrée n’ont pas été enregistrées.';

  @override
  String couldNotDiscardChanges(String p0) {
    return 'Impossible d’abandonner les modifications : $p0';
  }

  @override
  String photosAddedNotProcessed(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 photos ajoutées.',
      one: 'Une photo ajoutée.',
      zero: 'Aucune photo ajoutée.',
    );
    return '$_temp0 Non traitées : $p1';
  }

  @override
  String couldNotAddPhotos(String p0) {
    return 'Impossible d’ajouter les photos : $p0';
  }

  @override
  String couldNotRemovePhoto(String p0) {
    return 'Impossible de retirer la photo : $p0';
  }

  @override
  String couldNotSavePhotoOrder(String p0) {
    return 'Impossible d’enregistrer l’ordre des photos : $p0';
  }

  @override
  String couldNotRestorePhotoDraft(String p0) {
    return 'Impossible de restaurer le brouillon des photos : $p0';
  }

  @override
  String get changesSaved => 'Modifications enregistrées.';

  @override
  String get noChangesToSave => 'Aucune modification à enregistrer.';

  @override
  String couldNotSaveChanges(String p0) {
    return 'Impossible d’enregistrer les modifications : $p0';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get createProject => 'Créer un projet';

  @override
  String get lastEdited => 'Dernière modification';

  @override
  String get nameAZ => 'Nom A–Z';

  @override
  String get yourProjects => 'Vos projets';

  @override
  String get yourProjectsYourPaceRememberWhereToPickUp =>
      'Vos projets, à votre rythme. Retrouvez où reprendre.';

  @override
  String get searchProjects => 'Rechercher des projets';

  @override
  String get nameTechniqueYarnOrNeedleSize =>
      'Nom, technique, fil ou taille d’aiguille';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get text1Project => '1 projet';

  @override
  String projects(String p0) {
    return '$p0 projets';
  }

  @override
  String get noProgressEntriesYet => 'Aucun avancement pour le moment';

  @override
  String lastEdited206(String p0) {
    return 'Dernière modification : $p0';
  }

  @override
  String reminder(String p0) {
    return 'Rappel : $p0';
  }

  @override
  String get lastReminderNoneYet => 'Dernier rappel : aucun pour le moment';

  @override
  String lastReminder(String p0) {
    return 'Dernier rappel : $p0';
  }

  @override
  String get everyMinuteDev210 => 'chaque minute (Dev)';

  @override
  String hourlyFrom(String p0) {
    return 'toutes les heures à partir de $p0';
  }

  @override
  String dailyAt(String p0) {
    return 'tous les jours à $p0';
  }

  @override
  String weeklyOnAt(String p0, String p1) {
    return 'chaque semaine le $p0 à $p1';
  }

  @override
  String monthlyOnDayAt(String p0, String p1) {
    return 'chaque mois le $p0 à $p1';
  }

  @override
  String yearlyOnAt(String p0, String p1, String p2) {
    return 'chaque année le $p0/$p1 à $p2';
  }

  @override
  String onTimeWithSound216(String p0) {
    return '$p0 · ponctuel avec son';
  }

  @override
  String get noMatchingProjectsFound => 'Aucun projet correspondant trouvé.';

  @override
  String get createYourFirstProject => 'Créer votre premier projet';

  @override
  String get fromTheFirstStitchToTheLastRememberWhich =>
      'De la première à la dernière maille : retrouvez le rang ou le tour où reprendre, avec des photos et des notes rien que pour vous.';

  @override
  String get reload => 'Recharger';

  @override
  String get couldNotLoadProject => 'Impossible de charger le projet.';

  @override
  String get projectNotFound => 'Projet introuvable.';

  @override
  String get editProject => 'Modifier le projet';

  @override
  String get projectName224 => 'Nom du projet *';

  @override
  String get enterAProjectName => 'Saisissez un nom de projet.';

  @override
  String get yarnOptional => 'Fil (facultatif)';

  @override
  String get needleOrHookSizeOptional =>
      'Taille des aiguilles ou du crochet (facultatif)';

  @override
  String get countingUnit228 => 'Unité de comptage *';

  @override
  String get projectReminder => 'Rappel du projet';

  @override
  String get optionalAndOnlyOnThisDevice =>
      'Facultatif et uniquement sur cet appareil';

  @override
  String get interval => 'Fréquence';

  @override
  String get month => 'Mois';

  @override
  String get dayOfWeek => 'Jour de la semaine';

  @override
  String get day => 'Jour';

  @override
  String get devModeTheNextReminderIsScheduledForThe =>
      'Mode Dev : le prochain rappel est prévu au début de la minute suivante. Les rappels normaux peuvent arriver avec un léger retard.';

  @override
  String get startDate => 'Date de début';

  @override
  String get changeDate => 'Modifier la date';

  @override
  String get startTime => 'Heure de début';

  @override
  String get changeTime => 'Modifier l’heure';

  @override
  String every60MinutesFromTheSelectedStartNextReminder(String p0) {
    return 'Toutes les 60 minutes à partir du début choisi. Prochain rappel : $p0.';
  }

  @override
  String get time => 'Heure';

  @override
  String get reminderType => 'Type de rappel';

  @override
  String get mayArriveSlightlyLateRespectsTheSystemDoNot =>
      'Peut arriver avec un léger retard. Respecte le mode Ne pas déranger du système.';

  @override
  String get triggersAsCloseAsPossibleToTheSelectedTime =>
      'Se déclenche au plus près de l’heure choisie, comme une alarme.';

  @override
  String get openAlarmsReminders => 'Ouvrir Alarmes et rappels';

  @override
  String get testReminderNow => 'Tester le rappel maintenant';

  @override
  String get checkTheNotificationShadeDuringTheTestTheTest =>
      'Consultez le volet des notifications pendant le test. Le rappel de test est automatiquement supprimé après une minute.';

  @override
  String get theReminderIsNotConfirmedSavingWillSetIt =>
      'Le rappel n’est pas confirmé. L’enregistrement le configurera à nouveau.';

  @override
  String get saving => 'Enregistrement…';

  @override
  String get everythingSaved => 'Tout est enregistré';

  @override
  String get saveReminderAgain => 'Enregistrer à nouveau le rappel';

  @override
  String get saveProject => 'Enregistrer le projet';

  @override
  String get discardInput => 'Abandonner la saisie ?';

  @override
  String get yourChangesToThisProjectHaveNotBeenSaved =>
      'Vos modifications de ce projet n’ont pas été enregistrées.';

  @override
  String get yourNewProjectDetailsHaveNotBeenSaved =>
      'Les informations de votre nouveau projet n’ont pas été enregistrées.';

  @override
  String get discardInput256 => 'Abandonner la saisie';

  @override
  String get androidPermissionForOnTimeWithSoundIsMissing =>
      'L’autorisation Android pour Ponctuel avec son manque. Sélectionnez à nouveau ce mode et accordez l’autorisation.';

  @override
  String get projectSavedRemindersAreBlockedInAndroid =>
      'Projet enregistré. Les rappels sont bloqués dans Android.';

  @override
  String get projectSavedYouCanNowAddYourFirstProgress =>
      'Projet enregistré. Vous pouvez maintenant saisir votre premier avancement.';

  @override
  String get projectChangesSaved => 'Modifications du projet enregistrées.';

  @override
  String couldNotSave(String p0) {
    return 'Impossible d’enregistrer : $p0';
  }

  @override
  String get thisTimeIsUnavailableDueToTheDaylightSaving =>
      'Cette heure n’est pas disponible en raison du changement d’heure. Choisissez une autre heure.';

  @override
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime =>
      'Impossible d’ouvrir les paramètres Android Alarmes et rappels. Ponctuel avec son reste sélectionné.';

  @override
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice =>
      'Les paramètres Android Alarmes et rappels ne sont pas disponibles sur cet appareil.';

  @override
  String get afterSavingUse => 'Après l’enregistrement, utilisez ';

  @override
  String get toAddAndRecordYourFirstProgressEntry =>
      ' pour saisir votre premier avancement.';

  @override
  String get androidMustAllowAlarmsRemindersForOnTimeReminders =>
      'Android doit autoriser Alarmes et rappels pour les rappels ponctuels. Accordez l’accès pour que le rappel puisse sonner à l’heure choisie.';

  @override
  String get allowAlarmsReminders => 'Autoriser Alarmes et rappels';

  @override
  String get notificationsAreTurnedOff269 =>
      'Les notifications sont désactivées';

  @override
  String get thisReminderCategoryIsTurnedOff270 =>
      'Cette catégorie de rappels est désactivée';

  @override
  String get doNotDisturbIsOn => 'Ne pas déranger est activé';

  @override
  String get androidIsBlockingNotificationsForStrickHKelbuchYou =>
      'Android bloque les notifications de Strick & Häkelbuch. Vous pouvez les autoriser dans les paramètres Android.';

  @override
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0) {
    return 'Android bloque « $p0 ». Vous pouvez activer cette catégorie dans les paramètres Android.';
  }

  @override
  String get projectReminders => 'Rappels de projets';

  @override
  String get onTimeProjectReminders => 'Rappels ponctuels de projets';

  @override
  String get standardRemindersMayAppearWithoutSoundOrABanner =>
      'Les rappels normaux peuvent apparaître sans son ni bannière. Consultez aussi le volet des notifications.';

  @override
  String get alarmSoundAndBannersDependOnYourDoNot =>
      'Le son et les bannières dépendent des paramètres Ne pas déranger et du volume des alarmes.';

  @override
  String get openAndroidSettings => 'Ouvrir les paramètres Android';

  @override
  String get openDoNotDisturb => 'Ouvrir Ne pas déranger';

  @override
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings =>
      'Impossible d’ouvrir les paramètres système. Recherchez Ne pas déranger dans les paramètres du téléphone.';

  @override
  String get couldNotOpenSystemSettingsInYourPhoneSettings =>
      'Impossible d’ouvrir les paramètres système. Ouvrez Applications dans les paramètres du téléphone, puis Strick & Häkelbuch et Notifications.';

  @override
  String get sortPhotos => 'Trier les photos';

  @override
  String get projectReportSingleEntry => 'Rapport de projet · Entrée unique';

  @override
  String get preparingTheProgressEntryAndNotesForTheCompact =>
      'Préparation de l’avancement et des notes pour le PDF compact.';

  @override
  String get preparingCurrentPhotosProgressAndNotesForThePDF =>
      'Préparation des photos actuelles, de l’avancement et des notes pour le PDF.';

  @override
  String couldNotCreatePDF(String p0) {
    return 'Impossible de créer le PDF : $p0';
  }

  @override
  String get theSavedPDFFileIsMissing =>
      'Le fichier PDF enregistré est manquant.';

  @override
  String get deleteProjectReport288 => 'Supprimer le rapport de projet ?';

  @override
  String get thePDFWillBePermanentlyDeletedFromStrickH =>
      'Le PDF sera définitivement supprimé de Strick & Häkelbuch. Les copies déjà partagées ou enregistrées hors de l’application seront conservées.';

  @override
  String get projectReportDeleted => 'Rapport de projet supprimé.';

  @override
  String get couldNotDeleteProjectReportPleaseTryAgain =>
      'Impossible de supprimer le rapport de projet. Veuillez réessayer.';

  @override
  String get deleteProgressEntry => 'Supprimer l’entrée d’avancement ?';

  @override
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill =>
      'Cette entrée, ses pièces jointes et ses PDF individuels seront définitivement supprimés. Les PDF d’historique enregistrés et les copies hors de l’application seront conservés.';

  @override
  String get progressEntryDeleted => 'Entrée d’avancement supprimée.';

  @override
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry =>
      'Impossible de supprimer entièrement l’entrée d’avancement. Veuillez réessayer.';

  @override
  String get reportForThisProgressEntry =>
      'Rapport de cette entrée d’avancement';

  @override
  String get createProjectReportAsPDF => 'Créer un rapport de projet en PDF';

  @override
  String get edit => 'Modifier';

  @override
  String get deleteProgressEntry299 => 'Supprimer l’avancement';

  @override
  String get source => 'Source';

  @override
  String get lowerCount301 => 'Compteur inférieur';

  @override
  String get project => 'Projet';

  @override
  String get couldNotLoadProgressEntries =>
      'Impossible de charger les entrées d’avancement.';

  @override
  String get recordProgress => 'Saisir un avancement';

  @override
  String ofProgressEntries(String p0, String p1) {
    return '$p0 entrées d’avancement sur $p1';
  }

  @override
  String get showAllProgressEntries => 'Voir tous les avancements';

  @override
  String get preparingProgressEntriesAndNotesForTheCompactPDF =>
      'Préparation des avancements et des notes pour le PDF compact.';

  @override
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe =>
      'Préparation des avancements, des photos actuelles et des notes pour le PDF.';

  @override
  String get deleteProject => 'Supprimer le projet ?';

  @override
  String get allProgressEntriesProgressPhotosAndLocallySavedReports =>
      'Tous les avancements, photos et rapports enregistrés localement pour ce projet seront définitivement supprimés. Les fichiers déjà partagés hors de l’application seront conservés.';

  @override
  String get projectDeleted => 'Projet supprimé.';

  @override
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain =>
      'Impossible de supprimer entièrement le projet. Veuillez réessayer.';

  @override
  String get editProjectReminder => 'Modifier le projet et le rappel';

  @override
  String get deleteProject314 => 'Supprimer le projet';

  @override
  String get createReportForProjectHistory =>
      'Créer un rapport de l’historique du projet';

  @override
  String lastRecordedOn(String p0) {
    return 'Dernière saisie le $p0';
  }

  @override
  String yarn317(String p0) {
    return 'Fil : $p0';
  }

  @override
  String needleOrHookSize318(String p0) {
    return 'Taille des aiguilles ou du crochet : $p0';
  }

  @override
  String reminder319(String p0) {
    return 'Rappel : $p0';
  }

  @override
  String get noProgressEntryYetEnterYourCurrentRowOr =>
      'Aucun avancement pour le moment. Saisissez votre rang ou tour actuel, avec ou sans photo du projet.';

  @override
  String get recordFirstProgressEntry => 'Saisir le premier avancement';

  @override
  String get changeDateTime => 'Modifier la date et l’heure';

  @override
  String get enterProgress => 'Saisir l’avancement';

  @override
  String get photographProject => 'Photographier le projet';

  @override
  String get photosFromGallery => 'Photos de la galerie';

  @override
  String get preparingPhoto => 'Préparation de la photo…';

  @override
  String get enterWhereYouLeftOff => 'Indiquez où vous vous êtes arrêté.';

  @override
  String get optionalEGStartedTheSleeve =>
      'Facultatif, par exemple : début de la manche';

  @override
  String get saveProgressEntry => 'Enregistrer l’avancement';

  @override
  String get confirmAndSaveProgress => 'Confirmer et enregistrer l’avancement';

  @override
  String get discardProgressEntry => 'Abandonner l’avancement ?';

  @override
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen =>
      'Votre avancement et les photos sélectionnées n’ont pas été enregistrés.';

  @override
  String get discardProgressEntry333 => 'Abandonner l’avancement';

  @override
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain =>
      'Impossible de supprimer les photos non enregistrées. Veuillez réessayer.';

  @override
  String get progressEntrySaved => 'Avancement enregistré.';

  @override
  String get pickUpFromHere => 'Reprenez ici';

  @override
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow =>
      'Retrouvez votre rang ou tour actuel. Les photos montrent l’état de votre projet à cet instant.';

  @override
  String get youEnterYourProgressYourselfPhotosAndNotesStay =>
      'Vous saisissez vous-même votre avancement. Les photos et les notes restent sur votre appareil.';

  @override
  String get knittingScarf => 'Tricot · Écharpe';

  @override
  String get layYourProjectFlatSoItsShapeAndPattern =>
      'Posez votre projet à plat pour bien montrer sa forme et son motif.';

  @override
  String get knittingHatInTheRound => 'Tricot · Bonnet en rond';

  @override
  String get includeTheWorkingNeedleAndTheMarkedStartOf =>
      'Montrez aussi l’aiguille active et le marqueur de début du tour.';

  @override
  String get crochetGrannySquare => 'Crochet · Carré granny';

  @override
  String get photographTheWholeMotifIncludingWhereYouWillContinue =>
      'Photographiez le motif entier, avec l’endroit où vous reprendrez.';

  @override
  String get crochetBasketInTheRound => 'Crochet · Panier en rond';

  @override
  String get aSlightlyAngledViewShowsTheBaseHeightAnd =>
      'Une vue légèrement inclinée montre le fond, la hauteur et le bord en cours.';

  @override
  String get viewExamples => 'Voir les exemples';

  @override
  String get examplePhotos => 'Exemples de photos';

  @override
  String get close => 'Fermer';

  @override
  String get photographYourProjectInGoodLightEnterTheCurrent =>
      'Photographiez votre projet sous un bon éclairage. Saisissez vous-même le rang ou tour actuel.';

  @override
  String examplePhoto(String p0) {
    return 'Exemple de photo : $p0';
  }

  @override
  String get couldNotLoadExample => 'Impossible de charger l’exemple.';

  @override
  String get previousExample => 'Exemple précédent';

  @override
  String get nextExample => 'Exemple suivant';

  @override
  String get noProgressEntriesYet356 =>
      'Aucune entrée d’avancement pour le moment.';

  @override
  String get matches => 'résultats';

  @override
  String get progressEntries => 'entrées d’avancement';

  @override
  String of359(String p0, String p1, String p2, String p3) {
    return '$p0–$p1 sur $p2 $p3';
  }

  @override
  String get searchProgressEntries => 'Rechercher des avancements';

  @override
  String get dateRowRoundOrNote => 'Date, rang/tour ou note';

  @override
  String get noMatchingProgressEntryFound =>
      'Aucune entrée d’avancement correspondante.';

  @override
  String get searchByDateCurrentRowOrRoundOrA =>
      'Recherchez par date, rang ou tour actuel, ou par un mot de la note.';

  @override
  String get choosingASaveLocationIsNotYetAvailableOn =>
      'Le choix de l’emplacement d’enregistrement n’est pas encore disponible sur cette plateforme.';

  @override
  String get strickHKelbuchBackup => 'Sauvegarde Strick & Häkelbuch';

  @override
  String get projects366 => 'Projets';

  @override
  String get progressEntries367 => 'Entrées d’avancement';

  @override
  String get backup => 'Sauvegarde';

  @override
  String get createEncryptedBackup => 'Créer une sauvegarde chiffrée';

  @override
  String get projectsPhotosAndProjectReports => 'Projets, photos et rapports';

  @override
  String get restoreBackup => 'Restaurer une sauvegarde';

  @override
  String get newerExistingEntriesArePreserved =>
      'Les entrées existantes plus récentes sont conservées';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn =>
      'Les photos, les avancements et les PDF sont traités localement sur votre appareil. L’application n’envoie pas les données de vos projets à un serveur.';

  @override
  String get yourDataStaysOnYourDeviceUntilYouDelete =>
      'Vos données restent sur votre appareil jusqu’à leur suppression dans l’application ou à l’effacement des données de l’application.';

  @override
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI =>
      'Développeur et contact pour la confidentialité\nWasiliy Strecker · AppFabrik AI';

  @override
  String get openPrivacyPolicy => 'Ouvrir la politique de confidentialité';

  @override
  String get aboutStrickHKelbuch => 'À propos de Strick & Häkelbuch';

  @override
  String get openSourceMPL20 => 'Code ouvert · MPL 2.0';

  @override
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain =>
      'Impossible d’ouvrir la politique de confidentialité. Veuillez réessayer.';

  @override
  String get preparingFiles => 'Préparation des fichiers…';

  @override
  String couldNotCreateBackup(String p0) {
    return 'Impossible de créer la sauvegarde : $p0';
  }

  @override
  String get savingBackup => 'Enregistrement de la sauvegarde…';

  @override
  String couldNotShareBackup(String p0) {
    return 'Impossible de partager la sauvegarde : $p0';
  }

  @override
  String get backupSaved => 'Sauvegarde enregistrée';

  @override
  String wasSavedToTheSelectedLocation(String p0) {
    return '$p0 a été enregistré à l’emplacement choisi.';
  }

  @override
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 · $p1 · $p2\n$p3 Mo · Créé le $p4';
  }

  @override
  String get projectReports => 'Rapports de projet';

  @override
  String get done => 'Terminé';

  @override
  String get couldNotSaveBackup => 'Impossible d’enregistrer la sauvegarde';

  @override
  String get backupNotSavedYet => 'Sauvegarde pas encore enregistrée';

  @override
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe =>
      'Le fichier chiffré n’est stocké que temporairement dans l’application. Choisissez un emplacement pour conserver la sauvegarde.';

  @override
  String get discardBackup => 'Abandonner la sauvegarde';

  @override
  String get chooseSaveLocation => 'Choisir un emplacement';

  @override
  String get chooseAStrickHKelbuchBackupFileShbackup =>
      'Choisissez un fichier de sauvegarde Strick & Häkelbuch (.shbackup).';

  @override
  String get couldNotOpenTheSelectedBackupFile =>
      'Impossible d’ouvrir le fichier de sauvegarde sélectionné.';

  @override
  String couldNotSelectBackupFile(String p0) {
    return 'Impossible de sélectionner la sauvegarde : $p0';
  }

  @override
  String get checkingBackup => 'Vérification de la sauvegarde…';

  @override
  String get restoreBackup402 => 'Restaurer la sauvegarde ?';

  @override
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  ) {
    return '$p0, $p1 et $p2 seront importés. Les entrées locales plus récentes ne seront pas remplacées.';
  }

  @override
  String get restore => 'Restaurer';

  @override
  String get restoringBackup => 'Restauration de la sauvegarde…';

  @override
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  ) {
    return '$p0 et $p1 restaurés. $p2 entrées inchangées ou plus récentes ignorées.$p3$p4';
  }

  @override
  String get photo407 => 'Photo';

  @override
  String get photos408 => 'Photos';

  @override
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0) {
    return ' Les rappels de $p0 entrées n’ont pas pu être confirmés. Vérifiez-les dans la vue d’ensemble.';
  }

  @override
  String couldNotRestoreBackup(String p0) {
    return 'Impossible de restaurer la sauvegarde : $p0';
  }

  @override
  String get thePasswordMustHaveAtLeast6Characters =>
      'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get thePasswordIsIncorrectOrTheBackupHasBeen =>
      'Le mot de passe est incorrect ou la sauvegarde a été modifiée.';

  @override
  String aFileToBackUpIsMissing(String p0) {
    return 'Un fichier à sauvegarder est manquant : $p0';
  }

  @override
  String get aFileInTheBackupIsDamagedOrIncomplete =>
      'Un fichier de la sauvegarde est endommagé ou incomplet.';

  @override
  String get thisBackupVersionIsNotSupported =>
      'Cette version de sauvegarde n’est pas prise en charge.';

  @override
  String get theSelectedFileIsNotAValidStrickH =>
      'Le fichier sélectionné n’est pas une sauvegarde Strick & Häkelbuch valide.';

  @override
  String get preparingFiles417 => 'Préparation des fichiers';

  @override
  String get encryptingBackup => 'Chiffrement de la sauvegarde';

  @override
  String get finishingBackup => 'Finalisation de la sauvegarde';

  @override
  String get backupReady => 'Sauvegarde prête';

  @override
  String get pleaseWaitAMoment => 'Veuillez patienter un instant.';

  @override
  String get gatheringPhotosAndProjectReports =>
      'Rassemblement des photos et des rapports de projet.';

  @override
  String ofFiles(String p0, String p1) {
    return '$p0 fichiers sur $p1';
  }

  @override
  String get setBackupPassword => 'Définir le mot de passe de sauvegarde';

  @override
  String get password => 'Mot de passe';

  @override
  String get atLeast6Characters => 'Au moins 6 caractères';

  @override
  String get repeatPassword => 'Répéter le mot de passe';

  @override
  String progressEquation(String p0, String p1) {
    return ' $p0 = $p1 de progression';
  }

  @override
  String get unitChanged => '– (unité modifiée)';

  @override
  String reportCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rapports de projet',
      one: '$count rapport de projet',
    );
    return '$_temp0';
  }

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées d’avancement',
      one: '$count entrée d’avancement',
    );
    return '$_temp0';
  }

  @override
  String projectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count projets',
      one: '$count projet',
    );
    return '$_temp0';
  }

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '$count photo',
    );
    return '$_temp0';
  }

  @override
  String matchCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '$count résultat',
    );
    return '$_temp0';
  }

  @override
  String includedEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées d’avancement incluses',
      one: '$count entrée d’avancement incluse',
    );
    return '$_temp0';
  }

  @override
  String reminderDeadline(String p0, String p1) {
    return '$p0$p1';
  }

  @override
  String get reminderNotProcessed =>
      '. Android n’a pas encore traité ce rappel.';

  @override
  String progressChange(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 $p1 → $p2 = $p3 $p4 de progression';
  }

  @override
  String get projectNameExample => 'Par exemple : mon pull sauge';

  @override
  String get yarnExample => 'Par exemple : laine mérinos, sauge';

  @override
  String needleSizeExample(String size) {
    return 'Par exemple : $size mm';
  }

  @override
  String get recordProgressQuoted => '« Saisir un avancement »';

  @override
  String get examplePhotoDisclaimer =>
      'Exemples générés par IA · consultation uniquement';

  @override
  String repairedFiles(String p0) {
    return ' $p0 réparés.';
  }

  @override
  String get backupPassword => 'Mot de passe de sauvegarde';

  @override
  String get language => 'Langue';

  @override
  String get systemLanguage => 'Langue du système';

  @override
  String get languageHelp =>
      'Les nombres et les dates suivent toujours la région de votre appareil.';

  @override
  String get languageSaveFailed =>
      'Impossible d’enregistrer la langue. Veuillez réessayer.';

  @override
  String get unexpectedError =>
      'Impossible de terminer l’opération. Veuillez réessayer.';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get currentRow => 'Rang actuel';

  @override
  String get currentRound => 'Tour actuel';

  @override
  String lastProgress(String value, String unit) {
    return 'Dernier avancement : $value $unit';
  }

  @override
  String get reminderBody =>
      'Notez votre rang ou tour actuel pour reprendre tranquillement plus tard.';

  @override
  String testNotificationTitle(String technique, String name) {
    return 'Test : $technique · $name';
  }

  @override
  String get testNotificationApp =>
      'Ceci est un rappel de test. Touchez pour ouvrir l’application.';

  @override
  String get testNotificationProject =>
      'Ceci est un rappel de test. Touchez pour ouvrir le projet.';

  @override
  String get normalChannelDescription =>
      'Rappels facultatifs pour saisir régulièrement les avancements.';

  @override
  String get exactChannelDescription =>
      'Rappels ponctuels de projets avec son d’alarme.';

  @override
  String get reportFilePrefix => 'avancement';

  @override
  String get historyFilePrefix => 'historique_projet';

  @override
  String get compactFilePart => 'compact';

  @override
  String get photosFilePart => 'avec_photos';

  @override
  String annualReminder(String date, String time) {
    return 'chaque année le $date à $time';
  }

  @override
  String positionOfTotal(String p0, String p1) {
    return '$p0 sur $p1';
  }

  @override
  String rowQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rangs',
      one: 'Rang',
    );
    return '$_temp0';
  }

  @override
  String roundQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tours',
      one: 'Tour',
    );
    return '$_temp0';
  }
}
