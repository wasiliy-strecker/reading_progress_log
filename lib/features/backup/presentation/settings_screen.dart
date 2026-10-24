import '../../../core/localization/locale_settings.dart';
import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../core/utils/formatters.dart';
import '../application/backup_file_exporter.dart';
import '../application/backup_file_picker.dart';
import '../application/encrypted_backup_service.dart';

typedef ExternalUrlLauncher = Future<bool> Function(Uri uri);

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key, this.externalUrlLauncher});

  final ExternalUrlLauncher? externalUrlLauncher;

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _working = false;
  bool _changingLanguage = false;
  String _workingMessage = '';
  BackupProgress? _backupProgress;

  @override
  Widget build(BuildContext context) {
    final appVersion = ref.watch(appVersionProvider);
    final locale = ref.watch(appLocaleProvider);
    final appTitle = appVersion.isEmpty
        ? 'Strick & Häkelbuch'
        : 'Strick & Häkelbuch $appVersion';
    return PopScope(
      canPop: !_working,
      child: Scaffold(
        appBar: AppBar(title: Text(stringsOf(context).settings)),
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: _working,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            stringsOf(context).language,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          DropdownButton<String>(
                            key: const ValueKey('app-language-selector'),
                            value: locale.choice,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                value: 'system',
                                child: Text(stringsOf(context).systemLanguage),
                              ),
                              for (final language in appLanguageNames.entries)
                                DropdownMenuItem(
                                  value: language.key,
                                  child: Text(language.value),
                                ),
                            ],
                            onChanged: _changingLanguage
                                ? null
                                : (value) {
                                    if (value != null) _changeLanguage(value);
                                  },
                          ),
                          Text(stringsOf(context).languageHelp),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    stringsOf(context).backup,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.lock_outline),
                          title: Text(stringsOf(context).createEncryptedBackup),
                          subtitle: Text(
                            stringsOf(context).projectsPhotosAndProjectReports,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          enabled: !_working,
                          onTap: _createBackup,
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.settings_backup_restore_outlined,
                          ),
                          title: Text(stringsOf(context).restoreBackup),
                          subtitle: Text(
                            stringsOf(context).newerExistingEntriesArePreserved,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          enabled: !_working,
                          onTap: _restoreBackup,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    stringsOf(context).privacy,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stringsOf(
                              context,
                            ).photosProgressEntriesAndPDFsAreProcessedLocallyOn,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            stringsOf(
                              context,
                            ).yourDataStaysOnYourDeviceUntilYouDelete,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            stringsOf(
                              context,
                            ).developerAndPrivacyContactNWasiliyStreckerAppFabrikAI,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              key: const ValueKey('open-privacy-policy'),
                              onPressed: _openPrivacyPolicy,
                              icon: const Icon(Icons.description_outlined),
                              label: Text(
                                stringsOf(context).openPrivacyPolicy,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    stringsOf(context).aboutStrickHKelbuch,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            appTitle,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          key: const ValueKey('open-source-code'),
                          leading: const Icon(Icons.code_rounded),
                          title: Text(stringsOf(context).sourceCodeOnGitHub),
                          subtitle: Text(stringsOf(context).openSourceMPL20),
                          trailing: const Icon(Icons.open_in_new_rounded),
                          enabled: !_working,
                          onTap: _openSourceCode,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_working)
              Positioned.fill(
                child: _BackupWorkOverlay(
                  progress: _backupProgress,
                  fallbackMessage: _workingMessage,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeLanguage(String choice) async {
    setState(() => _changingLanguage = true);
    try {
      await ref.read(appLocaleProvider.notifier).choose(choice);
    } on Object {
      if (mounted) _showMessage(stringsOf(context).languageSaveFailed);
    } finally {
      if (mounted) setState(() => _changingLanguage = false);
    }
  }

  Future<void> _openPrivacyPolicy() async {
    await _openExternalUrl(
      Uri.parse(
        'https://github.com/wasiliy-strecker/reading_progress_log/blob/main/PRIVACY.md',
      ),
      stringsOf(context).couldNotOpenThePrivacyPolicyPleaseTryAgain,
    );
  }

  Future<void> _openSourceCode() async {
    await _openExternalUrl(
      Uri.parse('https://github.com/wasiliy-strecker/reading_progress_log'),
      stringsOf(context).theSourceCodeCouldNotBeOpened,
    );
  }

  Future<void> _openExternalUrl(Uri uri, String failureMessage) async {
    final launcher = widget.externalUrlLauncher ?? _launchExternalUrl;
    var opened = false;
    try {
      opened = await launcher(uri);
    } on Object {
      opened = false;
    }
    if (!opened && mounted) {
      _showMessage(failureMessage);
    }
  }

  Future<void> _createBackup() async {
    final password = await _askPassword(confirm: true);
    if (password == null) return;
    setState(() {
      _working = true;
      _workingMessage = stringsOf(context).preparingFiles;
      _backupProgress = const BackupProgress.preparing();
    });
    try {
      final backup = await ref
          .read(encryptedBackupServiceProvider)
          .create(
            password,
            onProgress: (progress) {
              if (mounted) setState(() => _backupProgress = progress);
            },
          );
      if (!mounted) return;
      final exporter = ref.read(backupFileExporterProvider);
      if (exporter.supportsDirectSave) {
        await _saveBackup(backup, exporter);
      } else {
        _clearWorkingState();
        await exporter.share(backup);
      }
    } on BackupException catch (error) {
      _showBackupError(error);
    } catch (error) {
      _showMessage(appStrings.couldNotCreateBackup(userErrorMessage(error)));
    } finally {
      if (mounted) {
        _clearWorkingState();
      }
    }
  }

  Future<void> _saveBackup(
    CreatedBackup backup,
    BackupFileExporter exporter,
  ) async {
    while (mounted) {
      setState(() {
        _working = true;
        _workingMessage = stringsOf(context).savingBackup;
        _backupProgress = null;
      });
      BackupSaveResult? result;
      Object? saveError;
      try {
        result = await exporter.save(backup);
      } catch (error) {
        saveError = error;
      }
      if (!mounted) return;
      _clearWorkingState();

      if (result?.status == BackupSaveStatus.saved) {
        final share = await _showBackupSavedDialog(
          backup,
          result!.fileName ?? _backupFileName(backup.path),
        );
        if (share && mounted) {
          try {
            await exporter.share(backup);
          } catch (error) {
            _showMessage(
              appStrings.couldNotShareBackup(userErrorMessage(error)),
            );
          }
        }
        return;
      }

      final action = await _showBackupNotSavedDialog(
        saveFailed: saveError != null,
      );
      if (!mounted) return;
      if (action == _UnsavedBackupAction.retry) continue;
      try {
        await exporter.discard(backup);
      } catch (_) {
        // The system cache or the next backup will remove a stale temp file.
      }
      return;
    }
  }

  Future<bool> _showBackupSavedDialog(
    CreatedBackup backup,
    String fileName,
  ) async {
    final sizeInMb = backup.sizeBytes / (1024 * 1024);
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            scrollable: true,
            icon: const Icon(Icons.check_circle_rounded),
            title: Text(stringsOf(context).backupSaved),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  stringsOf(
                    context,
                  ).wasSavedToTheSelectedLocation((fileName).toString()),
                ),
                const SizedBox(height: 12),
                Text(
                  stringsOf(context).nMBCreatedOn(
                    (stringsOf(
                      context,
                    ).projectCount(backup.preview.meterCount)).toString(),
                    (stringsOf(
                      context,
                    ).entryCount(backup.preview.readingCount)).toString(),
                    (stringsOf(
                      context,
                    ).reportCount(backup.preview.exportCount)).toString(),
                    (formatDecimal(sizeInMb)).toString(),
                    (formatDateTime(backup.preview.createdAt)).toString(),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context, false),
                  icon: const Icon(Icons.check_rounded),
                  label: Text(
                    stringsOf(context).done,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.ios_share_outlined),
                  label: Text(
                    stringsOf(context).share,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  Future<_UnsavedBackupAction> _showBackupNotSavedDialog({
    required bool saveFailed,
  }) async {
    return await showDialog<_UnsavedBackupAction>(
          context: context,
          barrierDismissible: false,
          builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              scrollable: true,
              icon: Icon(
                saveFailed
                    ? Icons.error_outline_rounded
                    : Icons.info_outline_rounded,
              ),
              title: Text(
                saveFailed
                    ? stringsOf(context).couldNotSaveBackup
                    : stringsOf(context).backupNotSavedYet,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    stringsOf(
                      context,
                    ).theEncryptedFileIsOnlyStoredTemporarilyInThe,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    onPressed: () =>
                        Navigator.pop(context, _UnsavedBackupAction.discard),
                    icon: const Icon(Icons.delete_outline),
                    label: Text(
                      stringsOf(context).discardBackup,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pop(context, _UnsavedBackupAction.retry),
                    icon: const Icon(Icons.folder_open_outlined),
                    label: Text(
                      stringsOf(context).chooseSaveLocation,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) ??
        _UnsavedBackupAction.discard;
  }

  void _clearWorkingState() {
    if (!mounted) return;
    setState(() {
      _working = false;
      _workingMessage = '';
      _backupProgress = null;
    });
  }

  Future<void> _restoreBackup() async {
    String? path;
    try {
      path = await ref.read(backupFilePickerProvider).pick();
    } on BackupFilePickException catch (error) {
      _showMessage(switch (error.failure) {
        BackupFilePickFailure.invalidExtension =>
          appStrings.chooseAStrickHKelbuchBackupFileShbackup,
        BackupFilePickFailure.unreadableFile =>
          appStrings.couldNotOpenTheSelectedBackupFile,
      });
      return;
    } catch (error) {
      _showMessage(
        appStrings.couldNotSelectBackupFile(userErrorMessage(error)),
      );
      return;
    }
    if (path == null || !mounted) return;
    final password = await _askPassword(confirm: false);
    if (password == null) return;
    setState(() {
      _working = true;
      _workingMessage = stringsOf(context).checkingBackup;
      _backupProgress = null;
    });
    try {
      final service = ref.read(encryptedBackupServiceProvider);
      final preview = await service.inspect(path, password);
      if (!mounted) return;
      final confirmed =
          await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(stringsOf(context).restoreBackup402),
              content: Text(
                stringsOf(context).andWillBeImportedNewerLocalEntriesWillNot(
                  (stringsOf(
                    context,
                  ).projectCount(preview.meterCount)).toString(),
                  (stringsOf(
                    context,
                  ).entryCount(preview.readingCount)).toString(),
                  (stringsOf(
                    context,
                  ).reportCount(preview.exportCount)).toString(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(stringsOf(context).cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(stringsOf(context).restore),
                ),
              ],
            ),
          ) ??
          false;
      if (!confirmed) return;
      setState(() => _workingMessage = stringsOf(context).restoringBackup);
      final refresh = ref.read(restoreRevisionProvider.notifier);
      late final BackupImportResult result;
      try {
        result = await service.restore(path, password);
      } finally {
        // A failed import may already have written some records.
        refresh.refresh();
      }
      if (mounted) {
        _showMessage(
          stringsOf(context).restoredAndSkippedUnchangedOrNewerEntries(
            (stringsOf(context).projectCount(result.meters)).toString(),
            (stringsOf(context).entryCount(result.readings)).toString(),
            (result.skipped).toString(),
            (result.repairedPhotos > 0
                    ? stringsOf(context).repairedFiles(
                        (stringsOf(
                          context,
                        ).photoCount(result.repairedPhotos)).toString(),
                      )
                    : '')
                .toString(),
            (result.reminderIssues > 0
                    ? stringsOf(
                        context,
                      ).remindersCouldNotBeConfirmedForEntriesCheckReminders(
                        (result.reminderIssues).toString(),
                      )
                    : '')
                .toString(),
          ),
        );
      }
    } on BackupException catch (error) {
      _showBackupError(error);
    } catch (error) {
      _showMessage(appStrings.couldNotRestoreBackup(userErrorMessage(error)));
    } finally {
      if (mounted) {
        setState(() {
          _working = false;
          _workingMessage = '';
          _backupProgress = null;
        });
      }
    }
  }

  Future<String?> _askPassword({required bool confirm}) {
    return showDialog<String>(
      context: context,
      builder: (_) => _BackupPasswordDialog(confirm: confirm),
    );
  }

  void _showBackupError(BackupException error) {
    final message = switch (error.failure) {
      BackupFailure.passwordTooShort => stringsOf(
        context,
      ).thePasswordMustHaveAtLeast6Characters,
      BackupFailure.invalidPassword => stringsOf(
        context,
      ).thePasswordIsIncorrectOrTheBackupHasBeen,
      BackupFailure.missingFile => stringsOf(
        context,
      ).aFileToBackUpIsMissing((error.detail).toString()),
      BackupFailure.integrityMismatch => stringsOf(
        context,
      ).aFileInTheBackupIsDamagedOrIncomplete,
      BackupFailure.unsupportedVersion => stringsOf(
        context,
      ).thisBackupVersionIsNotSupported,
      BackupFailure.invalidFormat => stringsOf(
        context,
      ).theSelectedFileIsNotAValidStrickH,
    };
    _showMessage(message);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(message: message));
  }
}

enum _UnsavedBackupAction { retry, discard }

String _backupFileName(String path) => path.split(RegExp(r'[/\\]')).last;

Future<bool> _launchExternalUrl(Uri uri) {
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}

class _BackupWorkOverlay extends StatelessWidget {
  const _BackupWorkOverlay({
    required this.progress,
    required this.fallbackMessage,
  });

  final BackupProgress? progress;
  final String fallbackMessage;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final value = progress?.fraction;
    final title = progress == null
        ? fallbackMessage
        : switch (progress!.phase) {
            BackupProgressPhase.preparing => stringsOf(
              context,
            ).preparingFiles417,
            BackupProgressPhase.encrypting => stringsOf(
              context,
            ).encryptingBackup,
            BackupProgressPhase.packaging => stringsOf(context).finishingBackup,
            BackupProgressPhase.complete => stringsOf(context).backupReady,
          };
    final detail = progress == null
        ? stringsOf(context).pleaseWaitAMoment
        : progress!.totalItems <= 0
        ? stringsOf(context).gatheringPhotosAndProjectReports
        : stringsOf(context).ofFiles(
            (progress!.completedItems).toString(),
            (progress!.totalItems).toString(),
          );

    return ColoredBox(
      color: colors.surface.withValues(alpha: 0.94),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              key: const ValueKey('backup-progress-overlay'),
              elevation: 2,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Icon(
                            progress?.phase == BackupProgressPhase.complete
                                ? Icons.check_rounded
                                : Icons.shield_outlined,
                            size: 30,
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: Text(
                          title,
                          key: ValueKey(title),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        detail,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          key: const ValueKey('backup-linear-progress'),
                          value: value,
                          minHeight: 8,
                        ),
                      ),
                      if (value != null) ...[
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${(value * 100).round()} %',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackupPasswordDialog extends StatefulWidget {
  const _BackupPasswordDialog({required this.confirm});

  final bool confirm;

  @override
  State<_BackupPasswordDialog> createState() => _BackupPasswordDialogState();
}

class _BackupPasswordDialogState extends State<_BackupPasswordDialog> {
  String? _validationError;
  final TextEditingController _first = TextEditingController();
  final TextEditingController _second = TextEditingController();

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.confirm
            ? stringsOf(context).setBackupPassword
            : stringsOf(context).backupPassword,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _first,
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              labelText: stringsOf(context).password,
              helperText: stringsOf(context).atLeast6Characters,
            ),
          ),
          if (_validationError != null)
            Text(
              _validationError!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          if (widget.confirm) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _second,
              obscureText: true,
              decoration: InputDecoration(
                labelText: stringsOf(context).repeatPassword,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(stringsOf(context).cancel),
        ),
        FilledButton(
          onPressed: () {
            if (_first.text.length < 6) {
              setState(
                () => _validationError = stringsOf(
                  context,
                ).thePasswordMustHaveAtLeast6Characters,
              );
              return;
            }
            if (widget.confirm && _first.text != _second.text) {
              setState(
                () => _validationError = stringsOf(context).passwordMismatch,
              );
              return;
            }
            Navigator.pop(context, _first.text);
          },
          child: Text(stringsOf(context).next),
        ),
      ],
    );
  }
}
