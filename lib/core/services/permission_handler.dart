import 'package:permission_handler/permission_handler.dart';

final permissionHandler = PermissionHandler();

class PermissionHandler implements PermissionInterface {
  PermissionHandler();

  @override
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }

    return await permission.isGranted;
  }
}

abstract class PermissionInterface {
  Future<bool> requestPermission(Permission permission);
}
