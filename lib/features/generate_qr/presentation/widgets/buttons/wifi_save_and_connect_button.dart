import 'package:flutter/material.dart';
import 'package:qr_reader/core/functions/show_toast.dart';
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
        Icons.wifi_2_bar_sharp,
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
