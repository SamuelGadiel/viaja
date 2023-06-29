import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';

import '../dialogs/confirmation_dialog.dart';

class PermissionHandler {
  static Future<void> checkLocationPermission(BuildContext context, Function onPermissionGranted) async {
    PermissionStatus permissionStatus = await Permission.location.status;

    // if (Platform.isAndroid) {
    //   final AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    //   final int sdkVersion = deviceInfo.version.sdkInt ?? -1;

    //   // In version 33 of android and below storage permission are not necessary.
    //   if (sdkVersion >= 33) {
    //     onPermissionGranted();
    //     return;
    //   }
    // }

    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.location.request();
      if (permissionStatus.isPermanentlyDenied) {
        // ignore: use_build_context_synchronously
        ConfirmationDialog.showConfirmationDialog(
          context: context,
          title: 'Erro!',
          message: 'Permissão necessária. Abrir configurações?',
          onConfirmPressed: () async {
            await openAppSettings();
            Modular.to.pop();
          },
        );
        return;
      }
    }

    if (permissionStatus.isGranted) {
      onPermissionGranted();
    }
  }
}
