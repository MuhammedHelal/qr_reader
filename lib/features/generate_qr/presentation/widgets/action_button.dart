import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/core/classes/qr_parser.dart';
import 'package:qr_reader/core/functions/launch_url.dart';
import 'package:qr_reader/core/functions/show_toast.dart';
import 'package:qr_reader/features/generate_qr/presentation/manager/show_qr_cubit/show_qr_cubit.dart';
import 'package:qr_reader/features/generate_qr/presentation/widgets/action_button_impl.dart';
import 'package:wifi_iot/wifi_iot.dart';

const platform = MethodChannel('dev.moashraf.qr_reader.fileprovider');

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ShowQrCubit>(context);
    switch (cubit.qrType) {
      case QRCodeType.email:
        return ActionButtonImpl(
          icon: const Icon(
            Icons.email,
            size: 30,
          ),
          title: 'Send Email',
          onPressed: () async {
            await myLaunchURL(cubit.data);
          },
        );
      case QRCodeType.website:
        return ActionButtonImpl(
          icon: const Icon(
            Icons.open_in_browser,
            size: 30,
          ),
          title: 'Open URL',
          onPressed: () async {
            await myLaunchURL(cubit.data);
          },
        );

      case QRCodeType.sms:
        return ActionButtonImpl(
          icon: const Icon(
            Icons.send,
            size: 30,
          ),
          title: 'Send SMS',
          onPressed: () async {
            await myLaunchURL(cubit.data);
          },
        );
      case QRCodeType.wifi:
        return ActionButtonImpl(
          icon: const Icon(
            Icons.wifi_2_bar_sharp,
            size: 30,
          ),
          title: 'Save Wifi and connect',
          onPressed: () async {
            await _saveAndConnectToWifi(cubit.data);
          },
        );
      /* case QRCodeType.event:
        return ActionButtonImpl(
          icon: const Icon(
            Icons.event,
            size: 30,
          ),
          title: 'Add to calendar',
          onPressed: () async {
            await saveAndOpenICS(cubit.data);
          },
        );*/
      default:
        return const SizedBox.shrink();
    }
  }
}

Future<void> saveAndOpenICS(String ics) async {
  final directory = await getApplicationCacheDirectory();
  final file = File('${directory.path}/event.ics');

  await file.writeAsString(ics);

  final uri = await platform.invokeMethod<String>(
    'getFileUri',
    {'path': file.path},
  );

  final intent = AndroidIntent(
    action: 'android.intent.action.VIEW',
    data: uri,
    type: 'text/calendar',
    flags: [
      Flag.FLAG_GRANT_READ_URI_PERMISSION,
      Flag.FLAG_GRANT_WRITE_URI_PERMISSION,
      Flag.FLAG_ACTIVITY_NEW_TASK,
      Flag.FLAG_ACTIVITY_BROUGHT_TO_FRONT,
    ],
  );
  await intent.launch();
  /*final result = await Share.shareXFiles(
    [
      XFile(
        file.path,
        name: 'event.ics',
        mimeType: 'text/calendar',
      ),
    ],
    text: 'Add event to calendar',
  );
  log(result.status.toString());*/
}

Future<void> _saveAndConnectToWifi(String data) async {
  try {
    RegExp regex = RegExp(r'WIFI:T:(.*?);S:(.*?);P:(.*?);H:(.*?);');
    RegExpMatch? match = regex.firstMatch(data);

    String securityValue = match?.group(1) ?? '';
    String networkName = match?.group(2) ?? '';
    String password = match?.group(3) ?? '';
    String hidden = match?.group(4) ?? '';
    await WiFiForIoTPlugin.registerWifiNetwork(
      //  withInternet: true,
      networkName,
      //  joinOnce: false,
      isHidden: bool.parse(hidden),
      security: _parseNetworkSecurity(securityValue),
      password: password,
    );
    await WiFiForIoTPlugin.setEnabled(true);
    bool isConnected = await WiFiForIoTPlugin.connect(
      withInternet: true,
      networkName,
      joinOnce: false,
      isHidden: bool.parse(hidden),
      security: _parseNetworkSecurity(securityValue),
      password: password,
    );
    if (isConnected) {
      showToast(
        message: 'Connected to $networkName',
        color: Colors.green,
      );
    }
  } catch (e) {
    showToast(
      message: e.toString(),
      color: Colors.red,
    );
  }
}

NetworkSecurity _parseNetworkSecurity(String networkSecurity) {
  switch (networkSecurity) {
    case 'NONE':
      return NetworkSecurity.NONE;
    case 'WEP':
      return NetworkSecurity.WEP;
    default:
      return NetworkSecurity.WPA;
  }
}
