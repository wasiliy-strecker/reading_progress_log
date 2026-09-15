import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/features/backup/application/backup_file_picker.dart';

void main() {
  test('Android uses a MIME-compatible filter for existing backups', () {
    expect(
      PlatformBackupFilePicker.allowedExtensionsFor(
        platform: TargetPlatform.android,
        isWeb: false,
      ),
      const ['bin'],
    );
  });

  test('other platforms filter by the actual backup extension', () {
    expect(
      PlatformBackupFilePicker.allowedExtensionsFor(
        platform: TargetPlatform.iOS,
        isWeb: false,
      ),
      const ['shbackup'],
    );
    expect(
      PlatformBackupFilePicker.allowedExtensionsFor(
        platform: TargetPlatform.android,
        isWeb: true,
      ),
      const ['shbackup'],
    );
  });

  test('only Strick & Häkelbuch backup names are accepted', () {
    expect(
      PlatformBackupFilePicker.hasBackupExtension('backup.shbackup'),
      isTrue,
    );
    expect(
      PlatformBackupFilePicker.hasBackupExtension('BACKUP.SHBACKUP'),
      isTrue,
    );
    expect(
      PlatformBackupFilePicker.hasBackupExtension('backup.aicmbackup'),
      isFalse,
    );
    expect(
      PlatformBackupFilePicker.hasBackupExtension('backup.shbackup.pdf'),
      isFalse,
    );
  });
}
