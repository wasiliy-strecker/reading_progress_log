// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get delete => 'Excluir';

  @override
  String get cancel => 'Cancelar';

  @override
  String get discardChanges => 'Descartar alterações';

  @override
  String get continueEditing => 'Continuar editando';

  @override
  String get creatingProjectReport => 'Criando relatório do projeto';

  @override
  String get pleaseWait => 'Aguarde um momento…';

  @override
  String testReminderSentToAndroidOpenTheNotificationShade(String p0) {
    return 'Lembrete de teste enviado ao Android. Abra o painel de notificações. Ele desaparecerá após um minuto.$p0';
  }

  @override
  String get doNotDisturbIsOnSoundAndBannersMay =>
      ' O modo Não perturbe está ativado. Sons e banners podem ser bloqueados.';

  @override
  String get notificationsAreNotAllowed =>
      'As notificações não estão permitidas.';

  @override
  String get thisReminderCategoryIsBlockedInAndroid =>
      'Esta categoria de lembretes está bloqueada no Android.';

  @override
  String get couldNotShowTheTestReminder =>
      'Não foi possível mostrar o lembrete de teste.';

  @override
  String get testRemindersAreNotSupportedOnThisDevice =>
      'Este dispositivo não oferece suporte a lembretes de teste.';

  @override
  String get anHourlyReminderRequiresAStartTime =>
      'Um lembrete a cada hora precisa de um horário de início.';

  @override
  String get dataSavedCouldNotTurnOffTheReminderOpen =>
      'Dados salvos. Não foi possível desativar o lembrete. Abra-o e salve novamente.';

  @override
  String get dataSavedRemindersAreBlockedInAndroidOpenThe =>
      'Dados salvos. Os lembretes estão bloqueados no Android. Abra o lembrete e depois as configurações do Android.';

  @override
  String get dataSavedRemindersAreNotSupportedOnThisDevice =>
      'Dados salvos. Este dispositivo não oferece suporte a lembretes.';

  @override
  String get dataSavedTheReminderCouldNotBeConfirmedOpen =>
      'Dados salvos. Não foi possível confirmar o lembrete. Abra-o e salve novamente.';

  @override
  String get dataSavedForAnOnTimeReminderOpenAlarms =>
      'Dados salvos. Para um lembrete pontual, abra Alarmes e lembretes nas configurações do Android.';

  @override
  String get dataSavedCouldNotCheckReminderStatusOpenThe =>
      'Dados salvos. Não foi possível verificar o estado do lembrete. Abra-o e salve novamente.';

  @override
  String get whatIsTheProjectReportFor =>
      'Para que serve o relatório do projeto?';

  @override
  String get beforeCreatingItChooseACompactReportWithoutPhotos =>
      'Antes de criar, escolha um relatório compacto sem fotos ou com todas as fotos atuais. Ambos incluem avanços, datas e notas para salvar, imprimir ou compartilhar.';

  @override
  String get itRecordsYourProjectProgressUsingTheInformationYou =>
      'Ele documenta o progresso do projeto com base nas informações que você confirmou.';

  @override
  String get thePDFBringsTogetherAllProgressEntriesAndNotes =>
      'O PDF reúne todos os avanços e notas. Escolha um relatório compacto sem fotos ou inclua todas as fotos atuais de cada registro para salvar, imprimir ou compartilhar.';

  @override
  String get personalRecordOfYourProjectProgress =>
      'Registro pessoal do progresso do seu projeto.';

  @override
  String get couldNotSaveThePhotoDraft =>
      'Não foi possível salvar o rascunho das fotos.';

  @override
  String get couldNotRemoveThePhotoDraft =>
      'Não foi possível remover o rascunho das fotos.';

  @override
  String get manualEntryDoesNotAccessPhotos =>
      'O registro manual não acessa fotos.';

  @override
  String get couldNotSafelyOptimizeThePhotoPleaseSelectIt =>
      'Não foi possível otimizar a foto com segurança. Selecione-a novamente.';

  @override
  String get compactWithoutPhotos => 'Compacto, sem fotos';

  @override
  String get withCurrentPhotos => 'Com as fotos atuais';

  @override
  String get withAllPhotosOlderVersion =>
      'Com todas as fotos (versão anterior)';

  @override
  String get thisProjectHasNoProgressEntriesYet =>
      'Este projeto ainda não tem registros de progresso.';

  @override
  String get theProgressEntriesDoNotBelongToThisProject =>
      'Os registros de progresso não pertencem a este projeto.';

  @override
  String get projectReport => 'Relatório do projeto';

  @override
  String get personalRecordOfProjectProgress =>
      'Registro pessoal do progresso de um projeto';

  @override
  String pageOf(String p0, String p1) {
    return 'Página $p0 de $p1';
  }

  @override
  String get singleProgressEntry => 'Registro individual de progresso';

  @override
  String get projectHistory => 'Histórico do projeto';

  @override
  String pdfCreatedOn(String p0, String p1) {
    return 'PDF criado em $p0 · $p1';
  }

  @override
  String get currentProjectDetails => 'Dados atuais do projeto';

  @override
  String get projectDetailsWhenRecorded =>
      'Dados do projeto no momento do registro';

  @override
  String get technique => 'Técnica';

  @override
  String get projectName => 'Nome do projeto';

  @override
  String get yarn => 'Fio';

  @override
  String get needleOrHookSize => 'Tamanho da agulha';

  @override
  String get countingUnit => 'Unidade de contagem';

  @override
  String get no => 'N.º';

  @override
  String get dateAndTime => 'Data e hora';

  @override
  String get progressEntry => 'Registro de progresso';

  @override
  String get progress => 'Progresso';

  @override
  String get notSpecified => 'Não informado';

  @override
  String progressEntry53(String p0) {
    return 'Registro de progresso $p0';
  }

  @override
  String get progressDateAndTime => 'Data e hora do progresso';

  @override
  String progressEntry55(String p0, String p1, String p2) {
    return 'Registro de progresso $p0 · $p1 · $p2';
  }

  @override
  String lowerCount(String p0) {
    return 'Contagem menor: $p0';
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
      'Não foi possível incluir a foto do progresso.';

  @override
  String get noPreparedPhotoFileAvailable =>
      'Nenhum arquivo de foto preparado disponível.';

  @override
  String createdOn(String p0) {
    return 'Criado em $p0';
  }

  @override
  String get savedLocally => 'Salvo no dispositivo';

  @override
  String get fileMissing => 'Arquivo ausente';

  @override
  String get deleteProjectReport => 'Excluir relatório do projeto';

  @override
  String get savedProjectReports => 'Relatórios do projeto salvos';

  @override
  String get couldNotLoadProjectReports =>
      'Não foi possível carregar os relatórios';

  @override
  String get loadingProjectReports => 'Carregando relatórios do projeto…';

  @override
  String get couldNotLoadProjectReports73 =>
      'Não foi possível carregar os relatórios do projeto.';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Avançar';

  @override
  String get checkingPDFFile => 'Verificando arquivo PDF…';

  @override
  String couldNotCheckFileStatusNProjectReportFrom(String p0) {
    return 'Não foi possível verificar o estado do arquivo.\nRelatório do projeto de $p0';
  }

  @override
  String get projectReportHistory => 'Relatório do projeto · Histórico';

  @override
  String progressEntriesIncluded(String p0) {
    return '$p0 registros de progresso incluídos';
  }

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get print => 'Imprimir';

  @override
  String get projectReportFromStrickHKelbuch =>
      'Relatório do projeto do Strick & Häkelbuch';

  @override
  String get share => 'Compartilhar';

  @override
  String get choosePDFContent => 'Escolher conteúdo do PDF';

  @override
  String get chooseWhatToIncludeInYourPDF => 'Escolha o que incluir no PDF.';

  @override
  String get progressEntriesDatesAndNotesCompactWithoutPhotos =>
      'Registros de progresso, datas e notas, em formato compacto sem fotos.';

  @override
  String get includesAllPhotosCurrentlyAttachedToThisProgressEntry =>
      'Inclui todas as fotos atualmente anexadas a este registro.';

  @override
  String get includesAllPhotosCurrentlyAttachedToEachProgressEntry =>
      'Inclui todas as fotos atualmente anexadas a cada registro.';

  @override
  String get noCurrentPhotosAvailable => 'Nenhuma foto atual disponível.';

  @override
  String get cameraPhoto => 'Foto da câmera';

  @override
  String get galleryImport => 'Importação da galeria';

  @override
  String get enteredManually => 'Inserido manualmente';

  @override
  String get newProjectSection => 'Nova seção do projeto';

  @override
  String get projectRestarted => 'Projeto reiniciado';

  @override
  String get correctionOfAnEarlierEntry => 'Correção de um registro anterior';

  @override
  String get otherReason => 'Outro motivo';

  @override
  String get knitting => 'Tricô';

  @override
  String get crochet => 'Crochê';

  @override
  String get rows => 'Carreiras';

  @override
  String get rounds => 'Voltas';

  @override
  String get round => 'Volta';

  @override
  String get row => 'Carreira';

  @override
  String current(String p0) {
    return '$p0 atual';
  }

  @override
  String get everyMinuteDev => 'A cada minuto (Dev)';

  @override
  String get hourly => 'A cada hora';

  @override
  String get daily => 'Diário';

  @override
  String get weekly => 'Semanal';

  @override
  String get monthly => 'Mensal';

  @override
  String get yearly => 'Anual';

  @override
  String get standardReminder => 'Lembrete normal';

  @override
  String get onTimeWithSound => 'Pontual com som';

  @override
  String get monday => 'Segunda-feira';

  @override
  String get tuesday => 'Terça-feira';

  @override
  String get wednesday => 'Quarta-feira';

  @override
  String get thursday => 'Quinta-feira';

  @override
  String get friday => 'Sexta-feira';

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
  String get removingPhoto => 'Removendo foto…';

  @override
  String get thePhotoOrderMustIncludeAllCurrentPhotos =>
      'A ordem deve incluir todas as fotos atuais.';

  @override
  String get savingPhotoOrder => 'Salvando ordem das fotos…';

  @override
  String get removingUnsavedPhotos => 'Removendo fotos não salvas…';

  @override
  String get couldNotTurnOffTheReminderPleaseTryAgain =>
      'Não foi possível desativar o lembrete. Tente novamente.';

  @override
  String get aPhotoRequiresACameraOrGallerySource =>
      'Uma foto precisa ter origem na câmera ou na galeria.';

  @override
  String get doNotSupplyPhotosAndASinglePhotoReplacement =>
      'Não forneça fotos e uma substituição individual ao mesmo tempo.';

  @override
  String get aChangedPhotoRequiresANewPhotoID =>
      'Uma foto alterada precisa de um novo ID.';

  @override
  String get photosRequireUniqueIDsFilesAndAPhotoSource =>
      'As fotos precisam de IDs únicos, arquivos e uma origem.';

  @override
  String get enterAWholeNumberOf0OrMore =>
      'Insira um número inteiro igual ou maior que 0.';

  @override
  String get couldNotTurnOff => 'Falha ao desativar';

  @override
  String get openTheReminderAndSaveAgain =>
      'Abra o lembrete e salve novamente.';

  @override
  String get reminderBlocked => 'Lembrete bloqueado';

  @override
  String get notificationsAreTurnedOff => 'As notificações estão desativadas.';

  @override
  String get thisReminderCategoryIsTurnedOff =>
      'Esta categoria de lembretes está desativada.';

  @override
  String get remindersNotSupported => 'Lembretes não suportados';

  @override
  String get thisDeviceCannotShowReminders =>
      'Este dispositivo não pode mostrar lembretes.';

  @override
  String get reminderNotScheduled => 'Lembrete não agendado';

  @override
  String get exactTimingNotAllowed => 'Horário exato não permitido';

  @override
  String get allowAlarmsRemindersInAndroidUntilThenTheReminder =>
      'Permita Alarmes e lembretes no Android. Até lá, o lembrete pode chegar atrasado.';

  @override
  String get exactSchedulingPending => 'Agendamento exato pendente';

  @override
  String get theScheduledTimeIsStillApproximateOpenTheReminder =>
      'O horário agendado ainda é aproximado. Abra o lembrete e salve novamente.';

  @override
  String get lastDeliveryFailed => 'Falha no último envio';

  @override
  String get openTheReminderAndChooseTestReminderNow =>
      'Abra o lembrete e escolha Testar lembrete agora.';

  @override
  String get schedulingStatusUnknown => 'Estado do agendamento desconhecido';

  @override
  String get couldNotConfirmReminderStatusOpenTheReminderTo =>
      'Não foi possível confirmar o estado do lembrete. Abra-o para verificar.';

  @override
  String get reminderStillPending => 'Lembrete ainda pendente';

  @override
  String get nextReminder => 'Próximo lembrete';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get editReminder => 'Editar lembrete';

  @override
  String get couldNotOpenSettingsSearchYourPhoneSettingsFor =>
      'Não foi possível abrir as configurações. Procure Alarmes e lembretes nas configurações do celular e selecione este app.';

  @override
  String get couldNotOpenSettingsOpenAppsInYourPhone =>
      'Não foi possível abrir as configurações. Abra Apps nas configurações do celular, selecione este app e depois Notificações.';

  @override
  String recordedOn(String p0) {
    return 'Registrado em $p0';
  }

  @override
  String recorded(String p0) {
    return 'Registrado · $p0';
  }

  @override
  String get countingUnitChangedSinceThisEntry =>
      'Unidade de contagem alterada desde este registro';

  @override
  String photosForProgressEntry(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 fotos do progresso $p1',
      one: 'Uma foto do progresso $p1',
      zero: '0 fotos do progresso $p1',
    );
    return '$_temp0';
  }

  @override
  String enteredManually159(String p0) {
    return 'Inserido manualmente: $p0';
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
  String get moveEarlier => 'Mover para antes';

  @override
  String get moveLater => 'Mover para depois';

  @override
  String get replacePhoto => 'Substituir foto';

  @override
  String get removePhoto => 'Remover foto';

  @override
  String get noCurrentPhotos => 'Nenhuma foto atual';

  @override
  String get photoUnavailable => 'Foto indisponível';

  @override
  String get previousPhoto => 'Foto anterior';

  @override
  String get nextPhoto => 'Próxima foto';

  @override
  String currentPhotos(String p0) {
    return 'Fotos atuais ($p0)';
  }

  @override
  String get touchAndHoldAPhotoThenDragItTo =>
      'Toque e segure uma foto, depois arraste para reordenar.';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get takeAnotherPhoto => 'Tirar outra foto';

  @override
  String get addPhotosFromGallery => 'Adicionar fotos da galeria';

  @override
  String get retakePhoto => 'Tirar nova foto';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get couldNotLoadProgressEntry =>
      'Não foi possível carregar o registro de progresso.';

  @override
  String get progressEntryNotFound => 'Registro de progresso não encontrado.';

  @override
  String get editProgressEntry => 'Editar registro de progresso';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get discardChanges183 => 'Descartar alterações?';

  @override
  String get yourChangesToThisProgressEntryHaveNotBeen =>
      'Suas alterações neste registro não foram salvas.';

  @override
  String couldNotDiscardChanges(String p0) {
    return 'Não foi possível descartar as alterações: $p0';
  }

  @override
  String photosAddedNotProcessed(int p0, String p1) {
    String _temp0 = intl.Intl.pluralLogic(
      p0,
      locale: localeName,
      other: '$p0 fotos adicionadas.',
      one: 'Uma foto adicionada.',
      zero: 'Nenhuma foto adicionada.',
    );
    return '$_temp0 Não processadas: $p1';
  }

  @override
  String couldNotAddPhotos(String p0) {
    return 'Não foi possível adicionar as fotos: $p0';
  }

  @override
  String couldNotRemovePhoto(String p0) {
    return 'Não foi possível remover a foto: $p0';
  }

  @override
  String couldNotSavePhotoOrder(String p0) {
    return 'Não foi possível salvar a ordem das fotos: $p0';
  }

  @override
  String couldNotRestorePhotoDraft(String p0) {
    return 'Não foi possível restaurar o rascunho das fotos: $p0';
  }

  @override
  String get changesSaved => 'Alterações salvas.';

  @override
  String get noChangesToSave => 'Nenhuma alteração para salvar.';

  @override
  String couldNotSaveChanges(String p0) {
    return 'Não foi possível salvar as alterações: $p0';
  }

  @override
  String get settings => 'Configurações';

  @override
  String get createProject => 'Criar projeto';

  @override
  String get lastEdited => 'Última alteração';

  @override
  String get nameAZ => 'Nome A–Z';

  @override
  String get yourProjects => 'Seus projetos';

  @override
  String get yourProjectsYourPaceRememberWhereToPickUp =>
      'Seus projetos, no seu ritmo. Lembre onde continuar.';

  @override
  String get searchProjects => 'Buscar projetos';

  @override
  String get nameTechniqueYarnOrNeedleSize =>
      'Nome, técnica, fio ou tamanho da agulha';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get text1Project => '1 projeto';

  @override
  String projects(String p0) {
    return '$p0 projetos';
  }

  @override
  String get noProgressEntriesYet => 'Ainda não há registros de progresso';

  @override
  String lastEdited206(String p0) {
    return 'Última alteração: $p0';
  }

  @override
  String reminder(String p0) {
    return 'Lembrete: $p0';
  }

  @override
  String get lastReminderNoneYet => 'Último lembrete: ainda nenhum';

  @override
  String lastReminder(String p0) {
    return 'Último lembrete: $p0';
  }

  @override
  String get everyMinuteDev210 => 'a cada minuto (Dev)';

  @override
  String hourlyFrom(String p0) {
    return 'a cada hora a partir de $p0';
  }

  @override
  String dailyAt(String p0) {
    return 'diariamente às $p0';
  }

  @override
  String weeklyOnAt(String p0, String p1) {
    return 'semanalmente: $p0 às $p1';
  }

  @override
  String monthlyOnDayAt(String p0, String p1) {
    return 'mensalmente no dia $p0 às $p1';
  }

  @override
  String yearlyOnAt(String p0, String p1, String p2) {
    return 'anualmente em $p0/$p1 às $p2';
  }

  @override
  String onTimeWithSound216(String p0) {
    return '$p0 · pontual com som';
  }

  @override
  String get noMatchingProjectsFound =>
      'Nenhum projeto correspondente encontrado.';

  @override
  String get createYourFirstProject => 'Criar seu primeiro projeto';

  @override
  String get fromTheFirstStitchToTheLastRememberWhich =>
      'Do primeiro ao último ponto: lembre em qual carreira ou volta continuar, com fotos e notas só para você.';

  @override
  String get reload => 'Recarregar';

  @override
  String get couldNotLoadProject => 'Não foi possível carregar o projeto.';

  @override
  String get projectNotFound => 'Projeto não encontrado.';

  @override
  String get editProject => 'Editar projeto';

  @override
  String get projectName224 => 'Nome do projeto *';

  @override
  String get enterAProjectName => 'Insira um nome para o projeto.';

  @override
  String get yarnOptional => 'Fio (opcional)';

  @override
  String get needleOrHookSizeOptional => 'Tamanho da agulha (opcional)';

  @override
  String get countingUnit228 => 'Unidade de contagem *';

  @override
  String get projectReminder => 'Lembrete do projeto';

  @override
  String get optionalAndOnlyOnThisDevice =>
      'Opcional e apenas neste dispositivo';

  @override
  String get interval => 'Intervalo';

  @override
  String get month => 'Mês';

  @override
  String get dayOfWeek => 'Dia da semana';

  @override
  String get day => 'Dia';

  @override
  String get devModeTheNextReminderIsScheduledForThe =>
      'Modo Dev: o próximo lembrete será agendado para o início do próximo minuto. Lembretes normais podem chegar com um pequeno atraso.';

  @override
  String get startDate => 'Data de início';

  @override
  String get changeDate => 'Alterar data';

  @override
  String get startTime => 'Horário de início';

  @override
  String get changeTime => 'Alterar horário';

  @override
  String every60MinutesFromTheSelectedStartNextReminder(String p0) {
    return 'A cada 60 minutos a partir do início escolhido. Próximo lembrete: $p0.';
  }

  @override
  String get time => 'Horário';

  @override
  String get reminderType => 'Tipo de lembrete';

  @override
  String get mayArriveSlightlyLateRespectsTheSystemDoNot =>
      'Pode chegar com um pequeno atraso. Respeita o modo Não perturbe do sistema.';

  @override
  String get triggersAsCloseAsPossibleToTheSelectedTime =>
      'Dispara o mais próximo possível do horário escolhido, como um alarme.';

  @override
  String get openAlarmsReminders => 'Abrir Alarmes e lembretes';

  @override
  String get testReminderNow => 'Testar lembrete agora';

  @override
  String get checkTheNotificationShadeDuringTheTestTheTest =>
      'Confira o painel de notificações durante o teste. O lembrete de teste é removido automaticamente após um minuto.';

  @override
  String get theReminderIsNotConfirmedSavingWillSetIt =>
      'O lembrete não está confirmado. Salvar irá configurá-lo novamente.';

  @override
  String get saving => 'Salvando…';

  @override
  String get everythingSaved => 'Tudo salvo';

  @override
  String get saveReminderAgain => 'Salvar lembrete novamente';

  @override
  String get saveProject => 'Salvar projeto';

  @override
  String get discardInput => 'Descartar dados inseridos?';

  @override
  String get yourChangesToThisProjectHaveNotBeenSaved =>
      'Suas alterações neste projeto não foram salvas.';

  @override
  String get yourNewProjectDetailsHaveNotBeenSaved =>
      'Os dados do novo projeto não foram salvos.';

  @override
  String get discardInput256 => 'Descartar dados inseridos';

  @override
  String get androidPermissionForOnTimeWithSoundIsMissing =>
      'Falta a permissão do Android para Pontual com som. Selecione o modo novamente e conceda a permissão.';

  @override
  String get projectSavedRemindersAreBlockedInAndroid =>
      'Projeto salvo. Os lembretes estão bloqueados no Android.';

  @override
  String get projectSavedYouCanNowAddYourFirstProgress =>
      'Projeto salvo. Agora você pode adicionar o primeiro registro de progresso.';

  @override
  String get projectChangesSaved => 'Alterações do projeto salvas.';

  @override
  String couldNotSave(String p0) {
    return 'Não foi possível salvar: $p0';
  }

  @override
  String get thisTimeIsUnavailableDueToTheDaylightSaving =>
      'Este horário não está disponível devido à mudança de horário. Escolha outro horário.';

  @override
  String get couldNotOpenAndroidAlarmsRemindersSettingsOnTime =>
      'Não foi possível abrir Alarmes e lembretes nas configurações do Android. Pontual com som continua selecionado.';

  @override
  String get androidAlarmsRemindersSettingsAreUnavailableOnThisDevice =>
      'As configurações de Alarmes e lembretes do Android não estão disponíveis neste dispositivo.';

  @override
  String get afterSavingUse => 'Depois de salvar, use ';

  @override
  String get toAddAndRecordYourFirstProgressEntry =>
      ' para adicionar o primeiro registro de progresso.';

  @override
  String get androidMustAllowAlarmsRemindersForOnTimeReminders =>
      'O Android precisa permitir Alarmes e lembretes para os avisos pontuais. Conceda o acesso para que o lembrete possa tocar no horário escolhido.';

  @override
  String get allowAlarmsReminders => 'Permitir Alarmes e lembretes';

  @override
  String get notificationsAreTurnedOff269 =>
      'As notificações estão desativadas';

  @override
  String get thisReminderCategoryIsTurnedOff270 =>
      'Esta categoria de lembretes está desativada';

  @override
  String get doNotDisturbIsOn => 'Não perturbe está ativado';

  @override
  String get androidIsBlockingNotificationsForStrickHKelbuchYou =>
      'O Android está bloqueando as notificações do Strick & Häkelbuch. Você pode permiti-las nas configurações do Android.';

  @override
  String androidIsBlockingYouCanEnableThisCategoryIn(String p0) {
    return 'O Android está bloqueando “$p0”. Você pode ativar esta categoria nas configurações do Android.';
  }

  @override
  String get projectReminders => 'Lembretes de projetos';

  @override
  String get onTimeProjectReminders => 'Lembretes pontuais de projetos';

  @override
  String get standardRemindersMayAppearWithoutSoundOrABanner =>
      'Lembretes normais podem aparecer sem som ou banner. Confira também o painel de notificações.';

  @override
  String get alarmSoundAndBannersDependOnYourDoNot =>
      'Sons e banners dependem das configurações de Não perturbe e do volume dos alarmes.';

  @override
  String get openAndroidSettings => 'Abrir configurações do Android';

  @override
  String get openDoNotDisturb => 'Abrir Não perturbe';

  @override
  String get couldNotOpenSystemSettingsSearchYourPhoneSettings =>
      'Não foi possível abrir as configurações do sistema. Procure Não perturbe nas configurações do celular.';

  @override
  String get couldNotOpenSystemSettingsInYourPhoneSettings =>
      'Não foi possível abrir as configurações do sistema. Abra Apps nas configurações do celular, depois Strick & Häkelbuch e Notificações.';

  @override
  String get sortPhotos => 'Ordenar fotos';

  @override
  String get projectReportSingleEntry =>
      'Relatório do projeto · Registro individual';

  @override
  String get preparingTheProgressEntryAndNotesForTheCompact =>
      'Preparando o registro de progresso e as notas para o PDF compacto.';

  @override
  String get preparingCurrentPhotosProgressAndNotesForThePDF =>
      'Preparando fotos atuais, progresso e notas para o PDF.';

  @override
  String couldNotCreatePDF(String p0) {
    return 'Não foi possível criar o PDF: $p0';
  }

  @override
  String get theSavedPDFFileIsMissing => 'O arquivo PDF salvo está ausente.';

  @override
  String get deleteProjectReport288 => 'Excluir relatório do projeto?';

  @override
  String get thePDFWillBePermanentlyDeletedFromStrickH =>
      'O PDF será excluído permanentemente do Strick & Häkelbuch. Cópias já compartilhadas ou salvas fora do app serão mantidas.';

  @override
  String get projectReportDeleted => 'Relatório do projeto excluído.';

  @override
  String get couldNotDeleteProjectReportPleaseTryAgain =>
      'Não foi possível excluir o relatório do projeto. Tente novamente.';

  @override
  String get deleteProgressEntry => 'Excluir registro de progresso?';

  @override
  String get thisEntryItsAttachmentsAndItsIndividualPDFsWill =>
      'Este registro, seus anexos e PDFs individuais serão excluídos permanentemente. Os PDFs de histórico salvos e as cópias fora do app serão mantidos.';

  @override
  String get progressEntryDeleted => 'Registro de progresso excluído.';

  @override
  String get couldNotCompletelyDeleteTheProgressEntryPleaseTry =>
      'Não foi possível excluir completamente o registro de progresso. Tente novamente.';

  @override
  String get reportForThisProgressEntry =>
      'Relatório deste registro de progresso';

  @override
  String get createProjectReportAsPDF => 'Criar relatório do projeto em PDF';

  @override
  String get edit => 'Editar';

  @override
  String get deleteProgressEntry299 => 'Excluir registro de progresso';

  @override
  String get source => 'Origem';

  @override
  String get lowerCount301 => 'Contagem menor';

  @override
  String get project => 'Projeto';

  @override
  String get couldNotLoadProgressEntries =>
      'Não foi possível carregar os registros de progresso.';

  @override
  String get recordProgress => 'Registrar progresso';

  @override
  String ofProgressEntries(String p0, String p1) {
    return '$p0 de $p1 registros de progresso';
  }

  @override
  String get showAllProgressEntries => 'Ver todos os registros de progresso';

  @override
  String get preparingProgressEntriesAndNotesForTheCompactPDF =>
      'Preparando registros de progresso e notas para o PDF compacto.';

  @override
  String get preparingProgressEntriesCurrentPhotosAndNotesForThe =>
      'Preparando registros de progresso, fotos atuais e notas para o PDF.';

  @override
  String get deleteProject => 'Excluir projeto?';

  @override
  String get allProgressEntriesProgressPhotosAndLocallySavedReports =>
      'Todos os registros de progresso, fotos e relatórios salvos no dispositivo deste projeto serão removidos permanentemente. Arquivos já compartilhados fora do app serão mantidos.';

  @override
  String get projectDeleted => 'Projeto excluído.';

  @override
  String get couldNotCompletelyDeleteTheProjectPleaseTryAgain =>
      'Não foi possível excluir completamente o projeto. Tente novamente.';

  @override
  String get editProjectReminder => 'Editar projeto e lembrete';

  @override
  String get deleteProject314 => 'Excluir projeto';

  @override
  String get createReportForProjectHistory =>
      'Criar relatório do histórico do projeto';

  @override
  String lastRecordedOn(String p0) {
    return 'Último registro em $p0';
  }

  @override
  String yarn317(String p0) {
    return 'Fio: $p0';
  }

  @override
  String needleOrHookSize318(String p0) {
    return 'Tamanho da agulha: $p0';
  }

  @override
  String reminder319(String p0) {
    return 'Lembrete: $p0';
  }

  @override
  String get noProgressEntryYetEnterYourCurrentRowOr =>
      'Ainda não há registro de progresso. Insira sua carreira ou volta atual, com ou sem foto do projeto.';

  @override
  String get recordFirstProgressEntry => 'Registrar primeiro progresso';

  @override
  String get changeDateTime => 'Alterar data e hora';

  @override
  String get enterProgress => 'Inserir progresso';

  @override
  String get photographProject => 'Fotografar projeto';

  @override
  String get photosFromGallery => 'Fotos da galeria';

  @override
  String get preparingPhoto => 'Preparando foto…';

  @override
  String get enterWhereYouLeftOff => 'Anote onde você parou.';

  @override
  String get optionalEGStartedTheSleeve =>
      'Opcional, por exemplo: comecei a manga';

  @override
  String get saveProgressEntry => 'Salvar registro de progresso';

  @override
  String get confirmAndSaveProgress => 'Confirmar e salvar progresso';

  @override
  String get discardProgressEntry => 'Descartar registro de progresso?';

  @override
  String get yourProgressEntryAndSelectedPhotosHaveNotBeen =>
      'Seu registro de progresso e as fotos selecionadas não foram salvos.';

  @override
  String get discardProgressEntry333 => 'Descartar registro de progresso';

  @override
  String get couldNotRemoveUnsavedPhotosPleaseTryAgain =>
      'Não foi possível remover as fotos não salvas. Tente novamente.';

  @override
  String get progressEntrySaved => 'Registro de progresso salvo.';

  @override
  String get pickUpFromHere => 'Continue daqui';

  @override
  String get rememberYourCurrentRowOrRoundPhotosCaptureHow =>
      'Lembre sua carreira ou volta atual. As fotos mostram como seu projeto está agora.';

  @override
  String get youEnterYourProgressYourselfPhotosAndNotesStay =>
      'Você mesmo insere o progresso. Fotos e notas ficam no seu dispositivo.';

  @override
  String get knittingScarf => 'Tricô · Cachecol';

  @override
  String get layYourProjectFlatSoItsShapeAndPattern =>
      'Coloque o projeto sobre uma superfície plana para mostrar bem a forma e o padrão.';

  @override
  String get knittingHatInTheRound => 'Tricô · Gorro em circular';

  @override
  String get includeTheWorkingNeedleAndTheMarkedStartOf =>
      'Mostre também a agulha em uso e o marcador de início da volta.';

  @override
  String get crochetGrannySquare => 'Crochê · Quadrado da vovó';

  @override
  String get photographTheWholeMotifIncludingWhereYouWillContinue =>
      'Fotografe o motivo inteiro, incluindo onde você vai continuar.';

  @override
  String get crochetBasketInTheRound => 'Crochê · Cesto em circular';

  @override
  String get aSlightlyAngledViewShowsTheBaseHeightAnd =>
      'Uma vista levemente inclinada mostra a base, a altura e a borda de trabalho.';

  @override
  String get viewExamples => 'Ver exemplos';

  @override
  String get examplePhotos => 'Fotos de exemplo';

  @override
  String get close => 'Fechar';

  @override
  String get photographYourProjectInGoodLightEnterTheCurrent =>
      'Fotografe seu projeto com boa iluminação. Insira você mesmo a carreira ou volta atual.';

  @override
  String examplePhoto(String p0) {
    return 'Foto de exemplo: $p0';
  }

  @override
  String get couldNotLoadExample => 'Não foi possível carregar o exemplo.';

  @override
  String get previousExample => 'Exemplo anterior';

  @override
  String get nextExample => 'Próximo exemplo';

  @override
  String get noProgressEntriesYet356 => 'Ainda não há registros de progresso.';

  @override
  String get matches => 'resultados';

  @override
  String get progressEntries => 'registros de progresso';

  @override
  String of359(String p0, String p1, String p2, String p3) {
    return '$p0–$p1 de $p2 $p3';
  }

  @override
  String get searchProgressEntries => 'Buscar registros de progresso';

  @override
  String get dateRowRoundOrNote => 'Data, carreira/volta ou nota';

  @override
  String get noMatchingProgressEntryFound =>
      'Nenhum registro de progresso correspondente encontrado.';

  @override
  String get searchByDateCurrentRowOrRoundOrA =>
      'Busque por data, carreira ou volta atual, ou uma palavra da nota.';

  @override
  String get choosingASaveLocationIsNotYetAvailableOn =>
      'A escolha do local para salvar ainda não está disponível nesta plataforma.';

  @override
  String get strickHKelbuchBackup => 'Backup do Strick & Häkelbuch';

  @override
  String get projects366 => 'Projetos';

  @override
  String get progressEntries367 => 'Registros de progresso';

  @override
  String get backup => 'Backup';

  @override
  String get createEncryptedBackup => 'Criar backup criptografado';

  @override
  String get projectsPhotosAndProjectReports => 'Projetos, fotos e relatórios';

  @override
  String get restoreBackup => 'Restaurar backup';

  @override
  String get newerExistingEntriesArePreserved =>
      'Registros existentes mais recentes são mantidos';

  @override
  String get privacy => 'Privacidade';

  @override
  String get photosProgressEntriesAndPDFsAreProcessedLocallyOn =>
      'Fotos, registros de progresso e PDFs são processados no seu dispositivo. O app não envia os dados dos seus projetos para um servidor.';

  @override
  String get yourDataStaysOnYourDeviceUntilYouDelete =>
      'Seus dados ficam no dispositivo até você excluí-los no app ou apagar os dados do aplicativo.';

  @override
  String get developerAndPrivacyContactNWasiliyStreckerAppFabrikAI =>
      'Desenvolvedor e contato de privacidade\nWasiliy Strecker · AppFabrik AI';

  @override
  String get openPrivacyPolicy => 'Abrir política de privacidade';

  @override
  String get aboutStrickHKelbuch => 'Sobre o Strick & Häkelbuch';

  @override
  String get sourceCodeOnGitHub => 'Código fonte no GitHub';

  @override
  String get theSourceCodeCouldNotBeOpened =>
      'Não foi possível abrir o código-fonte. Tente novamente.';

  @override
  String get openSourceMPL20 => 'Código aberto · MPL 2.0';

  @override
  String get couldNotOpenThePrivacyPolicyPleaseTryAgain =>
      'Não foi possível abrir a política de privacidade. Tente novamente.';

  @override
  String get preparingFiles => 'Preparando arquivos…';

  @override
  String couldNotCreateBackup(String p0) {
    return 'Não foi possível criar o backup: $p0';
  }

  @override
  String get savingBackup => 'Salvando backup…';

  @override
  String couldNotShareBackup(String p0) {
    return 'Não foi possível compartilhar o backup: $p0';
  }

  @override
  String get backupSaved => 'Backup salvo';

  @override
  String wasSavedToTheSelectedLocation(String p0) {
    return '$p0 foi salvo no local escolhido.';
  }

  @override
  String nMBCreatedOn(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 · $p1 · $p2\n$p3 MB · Criado em $p4';
  }

  @override
  String get projectReports => 'Relatórios de projetos';

  @override
  String get done => 'Concluído';

  @override
  String get couldNotSaveBackup => 'Não foi possível salvar o backup';

  @override
  String get backupNotSavedYet => 'Backup ainda não salvo';

  @override
  String get theEncryptedFileIsOnlyStoredTemporarilyInThe =>
      'O arquivo criptografado fica no app apenas temporariamente. Escolha um local para manter o backup.';

  @override
  String get discardBackup => 'Descartar backup';

  @override
  String get chooseSaveLocation => 'Escolher local para salvar';

  @override
  String get chooseAStrickHKelbuchBackupFileShbackup =>
      'Escolha um arquivo de backup do Strick & Häkelbuch (.shbackup).';

  @override
  String get couldNotOpenTheSelectedBackupFile =>
      'Não foi possível abrir o arquivo de backup selecionado.';

  @override
  String couldNotSelectBackupFile(String p0) {
    return 'Não foi possível selecionar o arquivo de backup: $p0';
  }

  @override
  String get checkingBackup => 'Verificando backup…';

  @override
  String get restoreBackup402 => 'Restaurar backup?';

  @override
  String andWillBeImportedNewerLocalEntriesWillNot(
    String p0,
    String p1,
    String p2,
  ) {
    return 'Serão importados $p0, $p1 e $p2. Registros locais mais recentes não serão substituídos.';
  }

  @override
  String get restore => 'Restaurar';

  @override
  String get restoringBackup => 'Restaurando backup…';

  @override
  String restoredAndSkippedUnchangedOrNewerEntries(
    String p0,
    String p1,
    String p2,
    String p3,
    String p4,
  ) {
    return 'Restaurados $p0 e $p1. Ignorados $p2 registros sem alterações ou mais recentes.$p3$p4';
  }

  @override
  String get photo407 => 'Foto';

  @override
  String get photos408 => 'Fotos';

  @override
  String remindersCouldNotBeConfirmedForEntriesCheckReminders(String p0) {
    return ' Não foi possível confirmar os lembretes de $p0 registros. Verifique-os na visão geral.';
  }

  @override
  String couldNotRestoreBackup(String p0) {
    return 'Não foi possível restaurar o backup: $p0';
  }

  @override
  String get thePasswordMustHaveAtLeast6Characters =>
      'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get thePasswordIsIncorrectOrTheBackupHasBeen =>
      'A senha está incorreta ou o backup foi alterado.';

  @override
  String aFileToBackUpIsMissing(String p0) {
    return 'Um arquivo para o backup está ausente: $p0';
  }

  @override
  String get aFileInTheBackupIsDamagedOrIncomplete =>
      'Um arquivo do backup está danificado ou incompleto.';

  @override
  String get thisBackupVersionIsNotSupported =>
      'Esta versão de backup não é suportada.';

  @override
  String get theSelectedFileIsNotAValidStrickH =>
      'O arquivo selecionado não é um backup válido do Strick & Häkelbuch.';

  @override
  String get preparingFiles417 => 'Preparando arquivos';

  @override
  String get encryptingBackup => 'Criptografando backup';

  @override
  String get finishingBackup => 'Finalizando backup';

  @override
  String get backupReady => 'Backup pronto';

  @override
  String get pleaseWaitAMoment => 'Aguarde um momento.';

  @override
  String get gatheringPhotosAndProjectReports =>
      'Reunindo fotos e relatórios de projetos.';

  @override
  String ofFiles(String p0, String p1) {
    return '$p0 de $p1 arquivos';
  }

  @override
  String get setBackupPassword => 'Definir senha do backup';

  @override
  String get password => 'Senha';

  @override
  String get atLeast6Characters => 'Pelo menos 6 caracteres';

  @override
  String get repeatPassword => 'Repetir senha';

  @override
  String progressEquation(String p0, String p1) {
    return ' $p0 = $p1 de progresso';
  }

  @override
  String get unitChanged => '– (unidade alterada)';

  @override
  String reportCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count relatórios do projeto',
      one: '$count relatório do projeto',
      zero: '0 relatórios do projeto',
    );
    return '$_temp0';
  }

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros de progresso',
      one: '$count registro de progresso',
      zero: '0 registros de progresso',
    );
    return '$_temp0';
  }

  @override
  String projectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count projetos',
      one: '$count projeto',
      zero: '0 projetos',
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
      zero: '0 fotos',
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
      zero: '0 resultados',
    );
    return '$_temp0';
  }

  @override
  String includedEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros de progresso incluídos',
      one: '$count registro de progresso incluído',
      zero: '0 registros de progresso incluídos',
    );
    return '$_temp0';
  }

  @override
  String reminderDeadline(String p0, String p1) {
    return '$p0$p1';
  }

  @override
  String get reminderNotProcessed =>
      '. O Android ainda não processou este lembrete.';

  @override
  String progressChange(String p0, String p1, String p2, String p3, String p4) {
    return '$p0 $p1 → $p2 = $p3 $p4 de progresso';
  }

  @override
  String get projectNameExample => 'por exemplo: Meu suéter verde-sálvia';

  @override
  String get yarnExample => 'por exemplo: Lã merino, verde-sálvia';

  @override
  String needleSizeExample(String size) {
    return 'por exemplo: $size mm';
  }

  @override
  String get recordProgressQuoted => '“Registrar progresso”';

  @override
  String get examplePhotoDisclaimer =>
      'Exemplos gerados por IA · apenas para visualização';

  @override
  String repairedFiles(String p0) {
    return ' Reparados $p0.';
  }

  @override
  String get backupPassword => 'Senha do backup';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma do sistema';

  @override
  String get languageHelp =>
      'Números e datas continuam seguindo a região do dispositivo.';

  @override
  String get languageSaveFailed =>
      'Não foi possível salvar o idioma. Tente novamente.';

  @override
  String get unexpectedError =>
      'Não foi possível concluir a operação. Tente novamente.';

  @override
  String get passwordMismatch => 'As senhas não coincidem.';

  @override
  String get currentRow => 'Carreira atual';

  @override
  String get currentRound => 'Volta atual';

  @override
  String lastProgress(String value, String unit) {
    return 'Último progresso: $value $unit';
  }

  @override
  String get reminderBody =>
      'Registre sua carreira ou volta atual e continue com tranquilidade depois.';

  @override
  String testNotificationTitle(String technique, String name) {
    return 'Teste: $technique · $name';
  }

  @override
  String get testNotificationApp =>
      'Este é um lembrete de teste. Toque para abrir o app.';

  @override
  String get testNotificationProject =>
      'Este é um lembrete de teste. Toque para abrir o projeto.';

  @override
  String get normalChannelDescription =>
      'Lembretes opcionais para registrar o progresso regularmente.';

  @override
  String get exactChannelDescription =>
      'Lembretes pontuais de projetos com som de alarme.';

  @override
  String get reportFilePrefix => 'progresso';

  @override
  String get historyFilePrefix => 'historico_projeto';

  @override
  String get compactFilePart => 'compacto';

  @override
  String get photosFilePart => 'com_fotos';

  @override
  String annualReminder(String date, String time) {
    return 'anualmente em $date às $time';
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
      other: 'Carreiras',
      one: 'Carreira',
      zero: 'Carreiras',
    );
    return '$_temp0';
  }

  @override
  String roundQuantityUnit(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Voltas',
      one: 'Volta',
      zero: 'Voltas',
    );
    return '$_temp0';
  }
}
