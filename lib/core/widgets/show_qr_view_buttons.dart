import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_reader/core/functions/show_toast.dart';
import 'package:qr_reader/core/utils/text_styles.dart';
import 'package:screenshot/screenshot.dart';

class ShowQrViewButtons extends StatelessWidget {
  const ShowQrViewButtons({
    super.key,
    required this.data,
    required this.screenshotController,
  });

  final String? data;
  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            icon: const Icon(
              Icons.copy,
              size: 25,
            ),
            title: 'Copy',
            onPressed: () async {
              showToast(
                message: 'Copid to clipboard',
                color: Colors.green,
              );
              await Clipboard.setData(
                ClipboardData(text: data ?? ''),
              );
            },
          ),
          CustomButton(
            onPressed: () async {
              try {
                final path = await saveScreenshotToDevice(
                  data: data,
                  screenshotController: screenshotController,
                );
                if (path == null) return;
                GallerySaver.saveImage(
                  path,
                  albumName: 'QR Scanner',
                );
                showToast(
                  message: 'Captured screenshot and saved to device',
                  color: Colors.green,
                );
              } catch (e) {}
            },
            icon: const Icon(
              size: 25,
              Icons.screenshot_outlined,
            ),
            title: 'Screenshot',
          ),
          CustomButton(
            onPressed: () async {
              final image = await ScreenshotController().captureFromWidget(
                QrImageView(data: data!),
              );
              await shareQRCodeImage(image);
            },
            title: 'Share',
            icon: const Icon(
              Icons.share,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
  });
  final Widget icon;
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
          onPressed: onPressed,
          child: icon,
        ),
        const Gap(8),
        Text(
          title,
          style: AppTextStyles.white16W400,
        )
      ],
    );
  }
}

Future<String?> saveScreenshotToDevice({
  required String? data,
  required ScreenshotController screenshotController,
}) async {
  final directory = (await getApplicationDocumentsDirectory()).path;

  final path = await screenshotController.captureAndSave(
    directory,
    fileName: '${data ?? DateTime.now().toString()}.png',
  );
  return path;
}

Future<void> shareQRCodeImage(Uint8List qrImageBytes) async {
  final tempDir = await getTemporaryDirectory();
  final file =
      await File('${tempDir.path}/qr_code.png').writeAsBytes(qrImageBytes);
/* await FlutterShare.shareFile(
    title: 'Scanned using QR Scanner',
    filePath: file.path,
    text:
        'download now from playstore https://play.google.com/store/apps/details?id=dev.moashraf.qr_reader',
  );*/
}
