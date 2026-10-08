import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'backup_codec.dart';

/// Shares a backup file and reads one the user picks. Nothing is uploaded.
class BackupService {
  Future<void> share(String json) async {
    final directory = await getTemporaryDirectory();
    final stamp = DateTime.now();
    final name =
        'bbuddy-backup-${stamp.year}-${stamp.month.toString().padLeft(2, '0')}-${stamp.day.toString().padLeft(2, '0')}.json';
    final file = File('${directory.path}${Platform.pathSeparator}$name');
    await file.writeAsString(json);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json', name: name)],
        subject: 'BBuddy',
      ),
    );
  }

  /// Returns the file text, or null when the user cancels the picker.
  Future<String?> pickJson() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (files.isEmpty) return null;

    final file = files.single;
    final knownLength = file.lengthSync();
    if (knownLength != null && knownLength > BackupCodec.maxBytes) {
      throw const BackupFormatException(BackupError.invalid);
    }

    final bytes = await file.readAsBytes();
    if (bytes.length > BackupCodec.maxBytes) {
      throw const BackupFormatException(BackupError.invalid);
    }
    return utf8.decode(bytes);
  }
}
