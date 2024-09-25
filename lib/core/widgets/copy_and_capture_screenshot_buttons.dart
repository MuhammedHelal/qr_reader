import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/core/functions/show_toast.dart';
import 'package:qr_reader/core/utils/text_styles.dart';
import 'package:screenshot/screenshot.dart';

class CopyAndCaptureScreenshotButtons extends StatelessWidget {
  const CopyAndCaptureScreenshotButtons({
    super.key,
    required this.data,
    required this.screenshotController,
  });

  final String? data;
  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.copy,
                size: 25,
              ),
              onPressed: () async {
                showToast(
                  message: 'Copid to clipboard',
                  color: Colors.green,
                );
                await Clipboard.setData(
                  ClipboardData(text: data ?? ''),
                );
              },
              label: const Text(
                'Copy',
                style: AppTextStyles.blackGreyish16W400,
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(
                size: 25,
                Icons.screenshot_outlined,
              ),
              onPressed: () async {
                showToast(
                  message: 'Captured screenshot and saved to device',
                  color: Colors.green,
                );
                final directory =
                    (await getApplicationDocumentsDirectory()).path;
                try {
                  final path = await screenshotController.captureAndSave(
                    directory,
                    fileName: '${data ?? DateTime.now().toString()}.png',
                  );
                  GallerySaver.saveImage(
                    path!,
                    albumName: 'QR Scanner',
                  );
                } catch (e) {}
              },
              iconAlignment: IconAlignment.start,
              label: const Text(
                'Screenshot',
                style: AppTextStyles.blackGreyish16W400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
