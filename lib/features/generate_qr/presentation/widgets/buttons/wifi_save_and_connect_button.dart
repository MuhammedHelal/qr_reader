import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_reader/core/classes/qr_parser.dart';
import 'package:qr_reader/core/functions/show_toast.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/features/generate_qr/presentation/widgets/action_button_impl.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiSaveWifiAndConnectButton extends StatelessWidget {
  const WifiSaveWifiAndConnectButton({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return ActionButtonImpl(
      icon: const Icon(
        Icons.wifi,
        size: 30,
      ),
      title: 'Save Wifi and connect',
      onPressed: () async {
        await _saveAndConnectToWifi(data);
      },
    );
  }
}

Future<void> _saveAndConnectToWifi(String data) async {
  RegExp regex = QRCodeParser.wifiRegex;
  RegExpMatch? match = regex.firstMatch(data);

  String ssid = match?.group(1) ?? "";
  String securityType = match?.group(2) ?? "";
  String password = match?.group(3) ?? "";
  String hiddenStatus = match?.group(4) ?? "";
  bool isEnabled = await WiFiForIoTPlugin.isEnabled();
  if (!isEnabled) {
    await showToast(message: 'Please enable wifi first', color: Colors.red);

    await WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
    return;
  }
  final result = await WiFiForIoTPlugin.registerWifiNetwork(
    ssid,
    isHidden: bool.parse(hiddenStatus),
    security: _parseNetworkSecurity(securityType),
    password: password,
  );
  if (result) {
    await showToast(
      message: 'Saved $ssid successfully.',
      color: Colors.green,
    );
  } else {
    await showToast(message: 'Failed to save $ssid', color: Colors.red);
  }

  bool connected = await WiFiForIoTPlugin.connect(
    withInternet: true,
    ssid,
    joinOnce: false,
    isHidden: bool.parse(hiddenStatus),
    security: _parseNetworkSecurity(securityType),
    password: password,
  );
  if (connected) {
    await showToast(
      message: 'Connected successfully',
      color: Colors.green,
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
