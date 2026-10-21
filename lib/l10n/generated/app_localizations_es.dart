// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get discardChanges => 'Descartar cambios';

  @override
  String get continueEditing => 'Seguir editando';

  @override
  String get creatingProjectReport => 'Creando informe del proyecto';

  @override
  String get pleaseWait => 'Espera un momento…';

  @override
  String testReminderSentToAndroidOpenTheNotificationShade(String p0) {
    return 'Recordatorio de prueba enviado a Android. Abre el panel de notificaciones. Desaparecerá al cabo de un minuto.$p0';
  }

  @override
  String get doNotDisturbIsOnSoundAndBannersMay =>
      ' El modo No molestar está activado. Puede impedir el sonido y los avisos emergentes.';

  @override
  String get notificationsAreNotAllowed =>
      'Las notificaciones no están permitidas.';

  @override
  String get thisReminderCategoryIsBlockedInAndroid =>
      'Esta categoría de recordatorios está bloqueada en Android.';

  @override
  String get couldNotShowTheTestReminder =>
      'No se pudo mostrar el recordatorio de prueba.';

  @override
  String get testRemindersAreNotSupportedOnThisDevice =>
      'Este dispositivo no admite recordatorios de prueba.';

  @override
  String get anHourlyReminderRequiresAStartTime =>
      'Un recordatorio cada hora necesita una hora de inicio.';

  @override
  String get dataSavedCouldNotTurnOffTheReminderOpen =>
      'Datos guardados. No se pudo desactivar el recordatorio. Ábrelo y vuelve a guardar.';

  @override
  String get dataSavedRemindersAreBlockedInAndroidOpenThe =>
      'Datos guardados. Los recordatorios están bloqueados en Android. Abre el recordatorio y después los ajustes de Android.';

  @override
  String get dataSavedRemindersAreNotSupportedOnThisDevice =>
      'Datos guardados. Este dispositivo no admite recordatorios.';

  @override
  String get dataSavedTheReminderCouldNotBeConfirmedOpen =>
      'Datos guardados. No se pudo confirmar el recordatorio. Ábrelo y vuelve a guardar.';

  @override
  String get dataSavedForAnOnTimeReminderOpenAlarms =>
      'Datos guardados. Para recibir un recordatorio puntual, abre Alarmas y recordatorios en los ajustes de Android.';

  @override
  String get dataSavedCouldNotCheckReminderStatusOpenThe =>
      'Datos guardados. No se pudo comprobar el estado del recordatorio. Ábrelo y vuelve a guardar.';

  @override
  String get whatIsTheProjectReportFor =>
      '¿Para qué sirve el informe del proyecto?';

  @override
  String get beforeCreatingItChooseACompactReportWithoutPhotos =>
      'Antes de crearlo, elige un informe compacto sin fotos o con todas las fotos actuales. Ambas opciones incluyen avances, fechas y notas para guardar, imprimir o compartir.';

  @override
  String get itRecordsYourProjectProgressUsingTheInformationYou =>
      'Documenta el avance del proyecto a partir de los datos que has confirmado.';

  @override
  String get thePDFBringsTogetherAllProgressEntriesAndNotes =>
      'El PDF reúne todos los avances y notas. Elige un informe compacto sin fotos o incluye todas las fotos actuales de cada registro para guardar, imprimir o compartir.';

  @override
  String get personalRecordOfYourProjectProgress =>
      'Registro personal del avance de tu proyecto.';

  @override
  String get couldNotSaveThePhotoDraft =>
      'No se pudo guardar el borrador de fotos.';

  @override
  String get couldNotRemoveThePhotoDraft =>
      'No se pudo eliminar el borrador de fotos.';

  @override
  String get manualEntryDoesNotAccessPhotos =>
      'El registro manual no accede a las fotos.';

  @override
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt =>
      'No se pudo optimizar la foto de forma segura. Selecciónala de nuevo.';

  @override
  String get compactWithoutPhotos => 'Compacto, sin fotos';

  @override
  String get withCurrentPhotos => 'Con fotos actuales';

  @override
  String get withAllPhotosOlderVersion =>
      'Con todas las fotos (versión anterior)';

  @override
  String get thisProjectHasNoProgressEntriesYet =>
      'Este proyecto aún no tiene registros de avance.';

  @override
  String get theProgressEntriesDoNotBelongToThisProject =>
      'Los registros de avance no pertenecen a este proyecto.';

  @override
  String get projectReport => 'Informe del proyecto';

  @override
  String get personalRecordOfProjectProgress =>
      'Registro personal del avance de un proyecto';

  @override
  String pageOf(String p0, String p1) {
    return 'Página $p0 de $p1';
  }

  @override
  String get singleProgressEntry => 'Registro individual de avance';

  @override
  String get projectHistory => 'Historial del proyecto';

  @override
  String pdfCreatedOn(String p0, String p1) {
    return 'PDF creado el $p0 · $p1';
  }

  @override
  String get currentProjectDetails => 'Datos actuales del proyecto';

  @override
  String get projectDetailsWhenRecorded => 'Datos del proyecto al registrar';

  @override
  String get technique => 'Técnica';

  @override
  String get projectName => 'Nombre del proyecto';

  @override
  String get yarn => 'Hilo';

  @override
  String get needleOrHookSize => 'Grosor de aguja o ganchillo';

  @override
  String get countingUnit => 'Unidad de recuento';

  @override
  String get no => 'N.º';

  @override
  String get dateAndTime => 'Fecha y hora';

  @override
  String get progressEntry => 'Registro de avance';

  @override
  String get progress => 'Avance';

  @override
  String get notSpecified => 'Sin especificar';

  @override
  String progressEntry53(String p0) {
    return 'Registro de avance $p0';
  }

  @override
  String get progressDateAndTime => 'Fecha y hora del avance';

  @override
  String progressEntry55(String p0, String p1, String p2) {
    return 'Registro de avance $p0 · $p1 · $p2';
  }

  @override
  String lowerCount(String p0) {
    return 'Recuento inferior: $p0';
  }

  @override
  String get note => 'Nota';

  @override
  String earlierPhoto(String p0) {
    return 'Foto anterior $p0';
  }

  @override
  String photoOf(String p0, String p1) {
    return 'Foto $p0 de $p1';
  }

  @override
  String get couldNotEmbedTheProgressPhoto =>
      'No se pudo incluir la foto del avance.';

  @override
  String get noPreparedPhotoFileAvailable =>
      'No hay ninguna foto preparada disponible.';

  @override
  String createdOn(String p0) {
    return 'Creado el $p0';
  }

  @override
  String get savedLocally => 'Guardado localmente';

  @override
  String get fileMissing => 'Falta el archivo';

  @override
  String get deleteProjectReport => 'Eliminar informe del proyecto';

  @override
  String get savedProjectReports => 'Informes del proyecto guardados';

  @override
  String get couldNotLoadProjectReports => 'No se pudieron cargar los informes';

  @override
  String get loadingProjectReports => 'Cargando informes del proyecto…';

  @override
  String get couldNotLoadProjectReports73 =>
      'No se pudieron cargar los informes del proyecto.';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get checkingPDFFile => 'Comprobando archivo PDF…';

  @override
  String couldNotCheckFileStatusNProjectReportFrom(String p0) {
    return 'No se pudo comprobar el estado del archivo.\nInforme del proyecto del $p0';
  }

  @override
  String get projectReportHistory => 'Informe del proyecto · Historial';

  @override
  String progressEntriesIncluded(String p0) {
    return '$p0 registros de avance incluidos';
  }

  @override
  String get tryAgain => 'Volver a intentar';

  @override
  String get print => 'Imprimir';

  @override
  String get projectReportFromStrickHKelbuch =>
      'Informe del proyecto de Strick & Häkelbuch';

  @override
  String get share => 'Compartir';

  @override
  String get choosePDFContent => 'Elegir contenido del PDF';

  @override
  String get chooseWhatToIncludeInYourPDF => 'Elige qué incluir en el PDF.';

  @override
  String get progressEntriesDatesAndNotesCompactWithoutPhotos =>
      'Registros de avance, fechas y notas, en formato compacto sin fotos.';

  @override
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry =>
      'Incluye todas las fotos actuales de este registro de avance.';

  @override
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry =>
      'Incluye todas las fotos actuales de cada registro de avance.';

  @override
  String get noCurrentPhotosAvailable => 'No hay fotos actuales.';

  @override
  String get cameraPhoto => 'Foto de la cámara';

  @override
  String get galleryImport => 'Importación de la galería';

  @override
  String get enteredManually => 'Introducido manualmente';

  @override
  String get newProjectSection => 'Nueva sección del proyecto';

  @override
  String get projectRestarted => 'Proyecto reiniciado';

  @override
  String get correctionOfAnEarlierEntry => 'Corrección de un registro anterior';

  @override
  String get otherReason => 'Otro motivo';

  @override
  String get knitting => 'Punto';

  @override
  String get crochet => 'Ganchillo';

  @override
  String get rows => 'Filas';

  @override
  String get rounds => 'Vueltas';

  @override
  String get round => 'Vuelta';

  @override
  String get row => 'Fila';

  @override
  String current(String p0) {
    return '$p0 actual';
  }

  @override
  String get everyMinuteDev => 'Cada minuto (Dev)';

  @override
  String get hourly => 'Cada hora';

  @override
  String get daily => 'Diario';

  @override
  String get weekly => 'Semanal';

  @override
  String get monthly => 'Mensual';

  @override
  String get yearly => 'Anual';

  @override
  String get standardReminder => 'Recordatorio normal';

  @override
  String get onTimeWithSound => 'Puntual con sonido';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get preparingPhotos => 'Preparando fotos…';

  @override
  String preparingPhotosOf(String p0, String p1) {
    return 'Preparando fotos: $p0 de $p1';
  }

  @override
  String get removingPhoto => 'Eliminando foto…';

  @override
  String get thePhotoOrderMustIncludeAllCurrentPhotos =>
      'El orden debe incluir todas las fotos actuales.';

  @override
  String get savingPhotoOrder => 'Guardando orden de fotos…';

  @override
  String get removingUnsavedPhotos => 'Eliminando fotos sin guardar…';

  @override
  String get couldNotTurnOffTheReminderPleaseTryAgain =>
      'No se pudo desactivar el recordatorio. Inténtalo de nuevo.';

  @override
  String get aPhotoRequiresACameraOrGallerySource =>
      'Una foto necesita un origen de cámara o galería.';

  @override
  String get doNotSupplyPhotosAndASinglePhotoReplacement =>
      'No proporciones fotos y una sustitución individual a la vez.';

  @override
  String get aChangedPhotoRequiresANewPhotoID =>
      'Una foto modificada necesita un identificador nuevo.';

  @override
  String get photosRequireUniqueIDsFilesAndAPhotoSource =>
      'Las fotos necesitan identificadores únicos, archivos y un origen.';

  @override
  String get enterAWholeNumberOf0OrMore =>
      'Introduce un número entero igual o mayor que 0.';

  @override
  String get couldNotTurnOff => 'No se pudo desactivar';

  @override
  String get openTheReminderAndSaveAgain =>
      'Abre el recordatorio y vuelve a guardar.';

  @override
  String get reminderBlocked => 'Recordatorio bloqueado';

  @override
  String get notificationsAreTurnedOff =>
      'Las notificaciones están desactivadas.';

  @override
  String get thisReminderCategoryIsTurnedOff =>
      'Esta categoría de recordatorios está desactivada.';

  @override
  String get remindersNotSupported => 'Recordatorios no compatibles';

  @override
  String get thisDeviceCannotShowReminders =>
      'Este dispositivo no puede mostrar recordatorios.';

  @override
  String get reminderNotScheduled => 'Recordatorio no programado';

  @override
  String get exactTimingNotAllowed => 'Horario exacto no permitido';

  @override
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder =>
      'Permite Alarmas y recordatorios en Android. Hasta entonces, el recordatorio podría llegar tarde.';

  @override
  String get exactSchedulingPending => 'Programación exacta pendiente';

  @override
  String get theScheduledTimeIsStillApproximateOpenTheReminder =>
      'La hora programada sigue siendo aproximada. Abre el recordatorio y vuelve a guardar.';

  @override
  String get lastDeliveryFailed => 'Falló el último envío';

  @override
  String get openTheReminderAndChooseTestReminderNow =>
      'Abre el recordatorio y elige Probar recordatorio ahora.';

  @override
  String get schedulingStatusUnknown => 'Estado de programación desconocido';

  @override
  String get couldNotConfirmReminderStatusOpenTheReminderTo =>
      'No se pudo confirmar el estado del recordatorio. Ábrelo para comprobarlo.';

  @override
  String get reminderStillPending => 'Recordatorio aún pendiente';

  @override
  String get nextReminder => 'Próximo recordatorio';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get editReminder => 'Editar recordatorio';

  @override
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor =>
      'No se pudieron abrir los ajustes. Busca Alarmas y recordatorios en los ajustes del teléfono y selecciona esta app.';

  @override
  String get couldNotOpenSettingsOpenAppsInYourPhone =>
      'No se pudieron abrir los ajustes. Abre Aplicaciones en los ajustes del teléfono, selecciona esta app y después Notificaciones.';

  @override
  String recordedOn(String p0) {
    return 'Registrado el $p0';
  }

  @override
  String recorded(String p0) {
    return 'Registrado · $p0';
  }

  @override
  String get countingUnitChangedSinceThisEntry =>
      'La unidad cambió desde este registro';

  @override
  String photosForProgressEntry(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 fotos del avance $p1',
      one: 'Una foto del avance $p1',
      zero: '0 fotos del avance $p1',
    );
    return '$_temp0';
  }

  @override
  String enteredManually159(String p0) {
    return 'Introducido manualmente: $p0';
  }

  @override
  String photos(String p0) {
    return '$p0 fotos';
  }

  @override
  String viewPhotoOf(String p0, String p1) {
    return 'Ver foto $p0 de $p1';
  }

  @override
  String photo(String p0) {
    return 'Foto $p0';
  }

  @override
  String editPhoto(String p0) {
    return 'Editar foto $p0';
  }

  @override
  String get moveEarlier => 'Mover antes';

  @override
  String get moveLater => 'Mover después';

  @override
  String get replacePhoto => 'Sustituir foto';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get noCurrentPhotos => 'Sin fotos actuales';

  @override
  String get photoUnavailable => 'Foto no disponible';

  @override
  String get previousPhoto => 'Foto anterior';

  @override
  String get nextPhoto => 'Foto siguiente';

  @override
  String currentPhotos(String p0) {
    return 'Fotos actuales ($p0)';
  }

  @override
  String get touchAndHoldAPhotoThenDragItTo =>
      'Mantén pulsada una foto y arrástrala para cambiar el orden.';

  @override
  String get takePhoto => 'Hacer foto';

  @override
  String get takeAnotherPhoto => 'Hacer otra foto';

  @override
  String get addPhotosFromGallery => 'Añadir fotos de la galería';

  @override
  String get retakePhoto => 'Volver a fotografiar';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get couldNotLoadProgressEntry =>
      'No se pudo cargar el registro de avance.';

  @override
  String get progressEntryNotFound => 'No se encontró el registro de avance.';

  @override
  String get editProgressEntry => 'Editar registro de avance';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get discardChanges183 => '¿Descartar cambios?';

  @override
  String get yourChangesToThisProgressEntryHaveNotBeen =>
      'Los cambios de este registro de avance no se han guardado.';

  @override
  String couldNotDiscardChanges(String p0) {
    return 'No se pudieron descartar los cambios: $p0';
  }

  @override
  String photosAddedNotProcessed(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 fotos añadidas.',
      one: 'Una foto añadida.',
      zero: 'No se ha añadido ninguna foto.',
    );
    return '$_temp0 Sin procesar: $p1';
  }

  @override
  String couldNotAddPhotos(String p0) {
    return 'No se pudieron añadir las fotos: $p0';
  }

  @override
  String couldNotRemovePhoto(String p0) {
    return 'No se pudo quitar la foto: $p0';
  }

  @override
  String couldNotSavePhotoOrder(String p0) {
    return 'No se pudo guardar el orden de las fotos: $p0';
  }

  @override
  String couldNotRestorePhotoDraft(String p0) {
    return 'No se pudo restaurar el borrador de fotos: $p0';
  }

  @override
  String get changesSaved => 'Cambios guardados.';

  @override
  String get noChangesToSave => 'No hay cambios que guardar.';

  @override
  String couldNotSaveChanges(String p0) {
    return 'No se pudieron guardar los cambios: $p0';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get createProject => 'Crear proyecto';

  @override
  String get lastEdited => 'Última modificación';

  @override
  String get nameAZ => 'Nombre A–Z';

  @override
  String get yourProjects => 'Tus proyectos';

  @override
  String get yourProjectsYourPaceRememberWhereToPickUp =>
      'Tus proyectos, a tu ritmo. Recuerda dónde continuar.';

  @override
  String get searchProjects => 'Buscar proyectos';

  @override
  String get nameTechniqueYarnOrNeedleSize =>
      'Nombre, técnica, hilo o grosor de aguja';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get text1Project => '1 proyecto';

  @override
  String projects(String p0) {
    return '$p0 proyectos';
  }

  @override
  String get noProgressEntriesYet => 'Aún no hay registros de avance';

  @override
  String lastEdited206(String p0) {
    return 'Última modificación: $p0';
  }

  @override
  String reminder(String p0) {
    return 'Recordatorio: $p0';
  }

  @override
  String get lastReminderNoneYet => 'Último recordatorio: ninguno todavía';

  @override
  String lastReminder(String p0) {
    return 'Último recordatorio: $p0';
  }

  @override
  String get everyMinuteDev210 => 'cada minuto (Dev)';

  @override
  String hourlyFrom(String p0) {
    return 'cada hora desde $p0';
  }

  @override
  String dailyAt(String p0) {
    return 'a diario a las $p0';
  }

  @override
  String weeklyOnAt(String p0, String p1) {
    return 'cada semana el $p0 a las $p1';
  }

  @override
  String monthlyOnDayAt(String p0, String p1) {
    return 'cada mes el día $p0 a las $p1';
  }

  @override
  String yearlyOnAt(String p0, String p1, String p2) {
    return 'cada año el $p0/$p1 a las $p2';
  }

  @override
  String onTimeWithSound216(String p0) {
    return '$p0 · puntual con sonido';
  }

  @override
  String get noMatchingProjectsFound =>
      'No se encontraron proyectos coincidentes.';

  @override
  String get createYourFirstProject => 'Crear tu primer proyecto';

  @override
  String get fromTheFirstStitchToTheLastRememberWhich =>
      'Del primer punto al último: recuerda en qué fila o vuelta continuar, con fotos y notas solo para ti.';

  @override
  String get reload => 'Volver a cargar';

  @override
  String get couldNotLoadProject => 'No se pudo cargar el proyecto.';

  @override
  String get projectNotFound => 'Proyecto no encontrado.';

  @override
  String get editProject => 'Editar proyecto';

  @override
  String get projectName224 => 'Nombre del proyecto *';

  @override
  String get enterAProjectName => 'Introduce un nombre para el proyecto.';

  @override
  String get yarnOptional => 'Hilo (opcional)';

  @override
  String get needleOrHookSizeOptional =>
      'Grosor de aguja o ganchillo (opcional)';

  @override
  String get countingUnit228 => 'Unidad de recuento *';

  @override
  String get projectReminder => 'Recordatorio del proyecto';

  @override
  String get optionalAndOnlyOnThisDevice =>
      'Opcional y solo en este dispositivo';

  @override
  String get interval => 'Intervalo';

  @override
  String get month => 'Mes';

  @override
  String get dayOfWeek => 'Día de la semana';

  @override
  String get day => 'Día';

  @override
  String get devModeTheNextReminderIsScheduledForThe =>
      'Modo Dev: el próximo recordatorio se programa al inicio del siguiente minuto. Los recordatorios normales pueden llegar con un pequeño retraso.';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get changeDate => 'Cambiar fecha';

  @override
  String get startTime => 'Hora de inicio';

  @override
  String get changeTime => 'Cambiar hora';

  @override
  String every60MinutesFromTheSelectedStartNextReminder(String p0) {
    return 'Cada 60 minutos desde el inicio elegido. Próximo recordatorio: $p0.';
  }

  @override
  String get time => 'Hora';

  @override
  String get reminderType => 'Tipo de recordatorio';

  @override
  String get mayArriveSlightlyLateRespectsTheSystemDoNot =>
      'Puede llegar con un pequeño retraso. Respeta el modo No molestar del sistema.';

  @override
  String get triggersAsCloseAsPossibleToTheSelectedTime =>
      'Se activa lo más cerca posible de la hora elegida, como una alarma.';

  @override
  String get openAlarmsReminders => 'Abrir Alarmas y recordatorios';

  @override
  String get testReminderNow => 'Probar recordatorio ahora';

  @override
  String get checkTheNotificationShadeDuringTheTestTheTest =>
      'Comprueba el panel de notificaciones durante la prueba. El recordatorio se elimina automáticamente al cabo de un minuto.';

  @override
  String get theReminderIsNotConfirmedSavingWillSetIt =>
      'El recordatorio no está confirmado. Al guardar se configurará de nuevo.';

  @override
  String get saving => 'Guardando…';

  @override
  String get everythingSaved => 'Todo guardado';

  @override
  String get saveReminderAgain => 'Volver a guardar recordatorio';

  @override
  String get saveProject => 'Guardar proyecto';

  @override
  String get discardInput => '¿Descartar lo introducido?';

  @override
  String get yourChangesToThisProjectHaveNotBeenSaved =>
      'Los cambios de este proyecto no se han guardado.';

  @override
  String get yourNewProjectDetailsHaveNotBeenSaved =>
      'Los datos del nuevo proyecto no se han guardado.';

  @override
  String get discardInput256 => 'Descartar lo introducido';

  @override
  String get androidPermissionForOnTimeWithSoundIsMissing =>
      'Falta el permiso de Android para Puntual con sonido. Selecciona el modo de nuevo y concede el permiso.';

  @override
  String get projectSavedRemindersAreBlockedInAndroid =>
      'Proyecto guardado. Los recordatorios están bloqueados en Android.';

  @override
  String get projectSavedYouCanNowAddYourFirstProgress =>
      'Proyecto guardado. Ya puedes añadir tu primer registro de avance.';

  @override
  String get projectChangesSaved => 'Cambios del proyecto guardados.';

  @override
  String couldNotSave(String p0) {
    return 'No se pudo guardar: $p0';
  }

  @override
  String get thisTimeIsUnavailableDueToTheDaylightSaving =>
      'Esta hora no está disponible por el cambio de horario. Elige otra hora.';

  @override
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime =>
      'No se pudieron abrir los ajustes de Alarmas y recordatorios de Android. Puntual con sonido sigue seleccionado.';

  @override
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice =>
      'Los ajustes de Alarmas y recordatorios de Android no están disponibles en este dispositivo.';

  @override
  String get afterSavingUse => 'Después de guardar, usa ';

  @override
  String get toAddAndRecordYourFirstProgressEntry =>
      ' para añadir tu primer registro de avance.';

  @override
  String get androidMustAllowAlarmsRemindersForOnTimeReminders =>
      'Android debe permitir Alarmas y recordatorios para los avisos puntuales. Concede el acceso para que el recordatorio pueda sonar a la hora elegida.';

  @override
  String get allowAlarmsReminders => 'Permitir Alarmas y recordatorios';

  @override
  String get notificationsAreTurnedOff269 =>
      'Las notificaciones están desactivadas';

  @override
  String get thisReminderCategoryIsTurnedOff270 =>
      'Esta categoría de recordatorios está desactivada';

  @override
  String get doNotDisturbIsOn => 'No molestar está activado';

  @override
  String get androidIsBlockingNotificationsForStrickHKelbuchYou =>
      'Android está bloqueando las notificaciones de Strick & Häkelbuch. Puedes permitirlas en los ajustes de Android.';

  @override
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0) {
    return 'Android está bloqueando «$p0». Puedes activar esta categoría en los ajustes de Android.';
  }

  @override
  String get projectReminders => 'Recordatorios de proyectos';

  @override
  String get onTimeProjectReminders => 'Recordatorios puntuales de proyectos';

  @override
  String get standardRemindersMayAppearWithoutSoundOrABanner =>
      'Los recordatorios normales pueden aparecer sin sonido ni aviso emergente. Comprueba también el panel de notificaciones.';

  @override
  String get alarmSoundAndBannersDependOnYourDoNot =>
      'El sonido y los avisos emergentes dependen de los ajustes de No molestar y del volumen de las alarmas.';

  @override
  String get openAndroidSettings => 'Abrir ajustes de Android';

  @override
  String get openDoNotDisturb => 'Abrir No molestar';

  @override
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings =>
      'No se pudieron abrir los ajustes del sistema. Busca No molestar en los ajustes del teléfono.';

  @override
  String get couldNotOpenSystemSettingsInYourPhoneSettings =>
      'No se pudieron abrir los ajustes del sistema. Abre Aplicaciones en los ajustes del teléfono, después Strick & Häkelbuch y Notificaciones.';

  @override
  String get sortPhotos => 'Ordenar fotos';

  @override
  String get projectReportSingleEntry =>
      'Informe del proyecto · Registro individual';

  @override
  String get preparingTheProgressEntryAndNotesForTheCompact =>
      'Preparando el registro de avance y las notas para el PDF compacto.';

  @override
  String get preparingCurrentPhotosProgressAndNotesForThePDF =>
      'Preparando fotos actuales, avance y notas para el PDF.';

  @override
  String couldNotCreatePDF(String p0) {
    return 'No se pudo crear el PDF: $p0';
  }

  @override
  String get theSavedPDFFileIsMissing => 'Falta el archivo PDF guardado.';

  @override
  String get deleteProjectReport288 => '¿Eliminar informe del proyecto?';

  @override
  String get thePDFWillBePermanentlyDeletedFromStrickH =>
      'El PDF se eliminará permanentemente de Strick & Häkelbuch. Las copias compartidas o guardadas fuera de la app se conservarán.';

  @override
  String get projectReportDeleted => 'Informe del proyecto eliminado.';

  @override
  String get couldNotDeleteProjectReportPleaseTryAgain =>
      'No se pudo eliminar el informe del proyecto. Inténtalo de nuevo.';

  @override
  String get deleteProgressEntry => '¿Eliminar registro de avance?';

  @override
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill =>
      'Este registro, sus archivos adjuntos y sus PDF individuales se eliminarán permanentemente. Los PDF de historial guardados y las copias fuera de la app se conservarán.';

  @override
  String get progressEntryDeleted => 'Registro de avance eliminado.';

  @override
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry =>
      'No se pudo eliminar por completo el registro de avance. Inténtalo de nuevo.';

  @override
  String get reportForThisProgressEntry => 'Informe de este registro de avance';

  @override
  String get createProjectReportAsPDF => 'Crear informe del proyecto en PDF';

  @override
  String get edit => 'Editar';

  @override
  String get deleteProgressEntry299 => 'Eliminar registro de avance';

  @override
  String get source => 'Origen';

  @override
  String get lowerCount301 => 'Recuento inferior';

  @override
  String get project => 'Proyecto';

  @override
  String get couldNotLoadProgressEntries =>
      'No se pudieron cargar los registros de avance.';

  @override
  String get recordProgress => 'Registrar avance';

  @override
  String ofProgressEntries(String p0, String p1) {
    return '$p0 de $p1 registros de avance';
  }

  @override
  String get showAllProgressEntries => 'Ver todos los registros de avance';

  @override
  String get preparingProgressEntriesAndNotesForTheCompactPDF =>
      'Preparando registros de avance y notas para el PDF compacto.';

  @override
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe =>
      'Preparando registros de avance, fotos actuales y notas para el PDF.';

  @override
  String get deleteProject => '¿Eliminar proyecto?';

  @override
  String get allProgressEntriesProgressPhotosAndLocallySavedReports =>
      'Se eliminarán permanentemente todos los registros de avance, fotos e informes guardados localmente de este proyecto. Los archivos compartidos fuera de la app se conservarán.';

  @override
  String get projectDeleted => 'Proyecto eliminado.';

  @override
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain =>
      'No se pudo eliminar el proyecto por completo. Inténtalo de nuevo.';

  @override
  String get editProjectReminder => 'Editar proyecto y recordatorio';

  @override
  String get deleteProject314 => 'Eliminar proyecto';

  @override
  String get createReportForProjectHistory =>
      'Crear informe del historial del proyecto';

  @override
  String lastRecordedOn(String p0) {
    return 'Último registro el $p0';
  }

  @override
  String yarn317(String p0) {
    return 'Hilo: $p0';
  }

  @override
  String needleOrHookSize318(String p0) {
    return 'Grosor de aguja o ganchillo: $p0';
  }

  @override
  String reminder319(String p0) {
    return 'Recordatorio: $p0';
  }

  @override
  String get noProgressEntryYetEnterYourCurrentRowOr =>
      'Aún no hay registros de avance. Introduce tu fila o vuelta actual, con o sin foto del proyecto.';

  @override
  String get recordFirstProgressEntry => 'Registrar primer avance';

  @override
  String get changeDateTime => 'Cambiar fecha y hora';

  @override
  String get enterProgress => 'Introducir avance';

  @override
  String get photographProject => 'Fotografiar proyecto';

  @override
  String get photosFromGallery => 'Fotos de la galería';

  @override
  String get preparingPhoto => 'Preparando foto…';

  @override
  String get enterWhereYouLeftOff => 'Anota dónde te has quedado.';

  @override
  String get optionalEGStartedTheSleeve => 'Opcional, p. ej., empecé la manga';

  @override
  String get saveProgressEntry => 'Guardar registro de avance';

  @override
  String get confirmAndSaveProgress => 'Confirmar y guardar avance';

  @override
  String get discardProgressEntry => '¿Descartar registro de avance?';

  @override
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen =>
      'El registro de avance y las fotos seleccionadas no se han guardado.';

  @override
  String get discardProgressEntry333 => 'Descartar registro de avance';

  @override
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain =>
      'No se pudieron eliminar las fotos sin guardar. Inténtalo de nuevo.';

  @override
  String get progressEntrySaved => 'Registro de avance guardado.';

  @override
  String get pickUpFromHere => 'Continúa desde aquí';

  @override
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow =>
      'Recuerda tu fila o vuelta actual. Las fotos muestran cómo está tu proyecto ahora.';

  @override
  String get youEnterYourProgressYourselfPhotosAndNotesStay =>
      'Introduces el avance tú mismo. Las fotos y notas permanecen en tu dispositivo.';

  @override
  String get knittingScarf => 'Punto · Bufanda';

  @override
  String get layYourProjectFlatSoItsShapeAndPattern =>
      'Coloca el proyecto plano para que se vean bien la forma y el motivo.';

  @override
  String get knittingHatInTheRound => 'Punto · Gorro en circular';

  @override
  String get includeTheWorkingNeedleAndTheMarkedStartOf =>
      'Muestra también la aguja de trabajo y el marcador de inicio de vuelta.';

  @override
  String get crochetGrannySquare => 'Ganchillo · Granny square';

  @override
  String get photographTheWholeMotifIncludingWhereYouWillContinue =>
      'Fotografía el motivo completo, incluido el punto donde continuarás.';

  @override
  String get crochetBasketInTheRound => 'Ganchillo · Cesta en circular';

  @override
  String get aSlightlyAngledViewShowsTheBaseHeightAnd =>
      'Una vista ligeramente inclinada muestra la base, la altura y el borde de trabajo.';

  @override
  String get viewExamples => 'Ver ejemplos';

  @override
  String get examplePhotos => 'Fotos de ejemplo';

  @override
  String get close => 'Cerrar';

  @override
  String get photographYourProjectInGoodLightEnterTheCurrent =>
      'Fotografía el proyecto con buena luz. Introduce tú mismo la fila o vuelta actual.';

  @override
  String examplePhoto(String p0) {
    return 'Foto de ejemplo: $p0';
  }

  @override
  String get couldNotLoadExample => 'No se pudo cargar el ejemplo.';

  @override
  String get previousExample => 'Ejemplo anterior';

  @override
  String get nextExample => 'Ejemplo siguiente';

  @override
  String get noProgressEntriesYet356 => 'Aún no hay registros de avance.';

  @override
  String get matches => 'resultados';

  @override
  String get progressEntries => 'registros de avance';

  @override
  String of359(String p0, String p1, String p2, String p3) {
    return '$p0–$p1 de $p2 $p3';
  }

  @override
  String get searchProgressEntries => 'Buscar registros de avance';

  @override
  String get dateRowRoundOrNote => 'Fecha, fila/vuelta o nota';

  @override
  String get noMatchingProgressEntryFound =>
      'No se encontró ningún registro de avance coincidente.';

  @override
  String get searchByDateCurrentRowOrRoundOrA =>
      'Busca por fecha, fila o vuelta actual, o una palabra de la nota.';

  @override
  String get choosingASaveLocationIsNotYetAvailableOn =>
      'La selección de la ubicación de guardado aún no está disponible en esta plataforma.';

  @override
  String get strickHKelbuchBackup => 'Copia de seguridad de Strick & Häkelbuch';

  @override
  String get projects366 => 'Proyectos';

  @override
  String get progressEntries367 => 'Registros de avance';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get createEncryptedBackup => 'Crear copia cifrada';

  @override
  String get projectsPhotosAndProjectReports => 'Proyectos, fotos e informes';

  @override
  String get restoreBackup => 'Restaurar copia de seguridad';

  @override
  String get newerExistingEntriesArePreserved =>
      'Se conservan los registros más recientes';

  @override
  String get privacy => 'Privacidad';

  @override
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn =>
      'Las fotos, los registros de avance y los PDF se procesan localmente en tu dispositivo. La app no envía los datos de tus proyectos a ningún servidor.';

  @override
  String get yourDataStaysOnYourDeviceUntilYouDelete =>
      'Tus datos permanecen en el dispositivo hasta que los elimines en la app o borres los datos de la aplicación.';

  @override
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI =>
      'Desarrollador y contacto de privacidad\nWasiliy Strecker · AppFabrik AI';

  @override
  String get openPrivacyPolicy => 'Abrir política de privacidad';

  @override
  String get aboutStrickHKelbuch => 'Acerca de Strick & Häkelbuch';

  @override
  String get openSourceMPL20 => 'Código abierto · MPL 2.0';

  @override
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain =>
      'No se pudo abrir la política de privacidad. Inténtalo de nuevo.';

  @override
  String get preparingFiles => 'Preparando archivos…';

  @override
  String couldNotCreateBackup(String p0) {
    return 'No se pudo crear la copia de seguridad: $p0';
  }

  @override
  String get savingBackup => 'Guardando copia de seguridad…';

  @override
  String couldNotShareBackup(String p0) {
    return 'No se pudo compartir la copia de seguridad: $p0';
  }

  @override
  String get backupSaved => 'Copia de seguridad guardada';

  @override
  String wasSavedToTheSelectedLocation(String p0) {
    return '$p0 se ha guardado en la ubicación elegida.';
  }

  @override
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 · $p1 · $p2\n$p3 MB · Creado el $p4';
  }

  @override
  String get projectReports => 'Informes de proyectos';

  @override
  String get done => 'Listo';

  @override
  String get couldNotSaveBackup => 'No se pudo guardar la copia de seguridad';

  @override
  String get backupNotSavedYet => 'Copia de seguridad aún sin guardar';

  @override
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe =>
      'El archivo cifrado solo está almacenado temporalmente en la app. Elige una ubicación para conservar la copia de seguridad.';

  @override
  String get discardBackup => 'Descartar copia de seguridad';

  @override
  String get chooseSaveLocation => 'Elegir ubicación';

  @override
  String get chooseAStrickHKelbuchBackupFileShbackup =>
      'Elige una copia de seguridad de Strick & Häkelbuch (.shbackup).';

  @override
  String get couldNotOpenTheSelectedBackupFile =>
      'No se pudo abrir la copia de seguridad seleccionada.';

  @override
  String couldNotSelectBackupFile(String p0) {
    return 'No se pudo seleccionar la copia de seguridad: $p0';
  }

  @override
  String get checkingBackup => 'Comprobando copia de seguridad…';

  @override
  String get restoreBackup402 => '¿Restaurar copia de seguridad?';

  @override
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  ) {
    return 'Se importarán $p0, $p1 y $p2. Los registros locales más recientes no se sobrescribirán.';
  }

  @override
  String get restore => 'Restaurar';

  @override
  String get restoringBackup => 'Restaurando copia de seguridad…';

  @override
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  ) {
    return 'Se han restaurado $p0 y $p1. Se han omitido $p2 registros sin cambios o más recientes.$p3$p4';
  }

  @override
  String get photo407 => 'Foto';

  @override
  String get photos408 => 'Fotos';

  @override
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0) {
    return ' No se pudieron confirmar los recordatorios de $p0 registros. Compruébalos en la vista general.';
  }

  @override
  String couldNotRestoreBackup(String p0) {
    return 'No se pudo restaurar la copia de seguridad: $p0';
  }

  @override
  String get thePasswordMustHaveAtLeast6Characters =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get thePasswordIsIncorrectOrTheBackupHasBeen =>
      'La contraseña es incorrecta o la copia de seguridad ha sido modificada.';

  @override
  String aFileToBackUpIsMissing(String p0) {
    return 'Falta un archivo para la copia de seguridad: $p0';
  }

  @override
  String get aFileInTheBackupIsDamagedOrIncomplete =>
      'Un archivo de la copia de seguridad está dañado o incompleto.';

  @override
  String get thisBackupVersionIsNotSupported =>
      'Esta versión de copia de seguridad no es compatible.';

  @override
  String get theSelectedFileIsNotAValidStrickH =>
      'El archivo seleccionado no es una copia de seguridad válida de Strick & Häkelbuch.';

  @override
  String get preparingFiles417 => 'Preparando archivos';

  @override
  String get encryptingBackup => 'Cifrando copia de seguridad';

  @override
  String get finishingBackup => 'Finalizando copia de seguridad';

  @override
  String get backupReady => 'Copia de seguridad lista';

  @override
  String get pleaseWaitAMoment => 'Espera un momento.';

  @override
  String get gatheringPhotosAndProjectReports =>
      'Reuniendo fotos e informes de proyectos.';

  @override
  String ofFiles(String p0, String p1) {
    return '$p0 de $p1 archivos';
  }

  @override
  String get setBackupPassword => 'Establecer contraseña de la copia';

  @override
  String get password => 'Contraseña';

  @override
  String get atLeast6Characters => 'Al menos 6 caracteres';

  @override
  String get repeatPassword => 'Repetir contraseña';

  @override
  String progressEquation(String p0, String p1) {
    return ' $p0 = $p1 de avance';
  }

  @override
  String get unitChanged => '– (unidad cambiada)';

  @override
  String reportCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count informes del proyecto',
      one: '$count informe del proyecto',
    );
    return '$_temp0';
  }

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros de avance',
      one: '$count registro de avance',
    );
    return '$_temp0';
  }

  @override
  String projectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proyectos',
      one: '$count proyecto',
    );
    return '$_temp0';
  }

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos',
      one: '$count foto',
    );
    return '$_temp0';
  }

  @override
  String matchCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados',
      one: '$count resultado',
    );
    return '$_temp0';
  }

  @override
  String includedEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros de avance incluidos',
      one: '$count registro de avance incluido',
    );
    return '$_temp0';
  }

  @override
  String reminderDeadline(String p0, String p1) {
    return '$p0$p1';
  }

  @override
  String get reminderNotProcessed =>
      '. Android aún no ha procesado este recordatorio.';

  @override
  String progressChange(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 $p1 → $p2 = $p3 $p4 de avance';
  }

  @override
  String get projectNameExample => 'p. ej., Mi jersey verde salvia';

  @override
  String get yarnExample => 'p. ej., Lana merina, salvia';

  @override
  String needleSizeExample(String size) {
    return 'p. ej., $size mm';
  }

  @override
  String get recordProgressQuoted => '«Registrar avance»';

  @override
  String get examplePhotoDisclaimer =>
      'Ejemplos generados con IA · solo para ver';

  @override
  String repairedFiles(String p0) {
    return ' Se han reparado $p0.';
  }

  @override
  String get backupPassword => 'Contraseña de la copia';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get languageHelp =>
      'Los números y las fechas siguen la región de tu dispositivo.';

  @override
  String get languageSaveFailed =>
      'No se pudo guardar el idioma. Inténtalo de nuevo.';

  @override
  String get unexpectedError =>
      'No se pudo completar la operación. Inténtalo de nuevo.';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get currentRow => 'Fila actual';

  @override
  String get currentRound => 'Vuelta actual';

  @override
  String lastProgress(String value, String unit) {
    return 'Último avance: $value $unit';
  }

  @override
  String get reminderBody =>
      'Registra tu fila o vuelta actual y continúa tranquilamente después.';

  @override
  String testNotificationTitle(String technique, String name) {
    return 'Prueba: $technique · $name';
  }

  @override
  String get testNotificationApp =>
      'Este es un recordatorio de prueba. Toca para abrir la app.';

  @override
  String get testNotificationProject =>
      'Este es un recordatorio de prueba. Toca para abrir el proyecto.';

  @override
  String get normalChannelDescription =>
      'Recordatorios opcionales para registrar avances periódicamente.';

  @override
  String get exactChannelDescription =>
      'Recordatorios puntuales de proyectos con sonido de alarma.';

  @override
  String get reportFilePrefix => 'avance';

  @override
  String get historyFilePrefix => 'historial_proyecto';

  @override
  String get compactFilePart => 'compacto';

  @override
  String get photosFilePart => 'con_fotos';

  @override
  String annualReminder(String date, String time) {
    return 'cada año el $date a las $time';
  }

  @override
  String positionOfTotal(String p0, String p1) {
    return '$p0 de $p1';
  }

  @override
  String rowQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Filas',
      one: 'Fila',
    );
    return '$_temp0';
  }

  @override
  String roundQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vueltas',
      one: 'Vuelta',
    );
    return '$_temp0';
  }
}
