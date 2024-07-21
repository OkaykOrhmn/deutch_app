import 'dart:io';

import 'package:deutch_app/core/services/permission_handler.dart';
import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageHandler {
  static Future<Directory?> getInAppDoc() async {
    try {
      final a = await permissionHandler
          .requestPermission(Permission.accessMediaLocation);
      final m = await permissionHandler
          .requestPermission(Permission.manageExternalStorage);
      await permissionHandler.requestPermission(Permission.mediaLibrary);

      if (a && m) {
        Directory? appDocDir = await getDownloadsDirectory();

        final Directory appDocDirFolder = Directory(appDocDir!.path);
        if (await appDocDirFolder.exists()) {
          return appDocDirFolder;
        } else {
          final Directory appDocDirNewFolder =
              await appDocDirFolder.create(recursive: true);
          return appDocDirNewFolder;
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<String?> createFolderInAppDoc(String folderName) async {
    final Directory? appDocDir = await getInAppDoc();
    try {
      final Directory appDocDirFolder =
          Directory('${appDocDir!.path}/$folderName');
      if (await appDocDirFolder.exists()) {
        return appDocDirFolder.path;
      } else {
        final Directory appDocDirNewFolder =
            await appDocDirFolder.create(recursive: true);
        return appDocDirNewFolder.path;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> getMediaFileDir(String url, List<String> names) async {
    Directory? main = await getInAppDoc();
    if (main == null) return null;
    for (var name in names) {
      main = Directory('${main!.path}/$name');
    }
    String fileName = Tools.getDownloadedFileName(url);
    File file = File('${main!.path}/$fileName');
    if (await file.exists()) {
      return "exist";
    } else {
      return file.path;
    }
  }

  static Future<File?> getMediaFileDirPath(
      String url, List<String> names) async {
    Directory? main = await getInAppDoc();
    if (main == null) return null;
    for (var name in names) {
      main = Directory('${main!.path}/$name');
    }
    String fileName = Tools.getDownloadedFileName(url);
    File file = File('${main!.path}/$fileName');
    return file;
  }
}
