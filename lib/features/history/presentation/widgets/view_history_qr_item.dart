import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_reader/core/classes/qr_parser.dart';
import 'package:qr_reader/core/functions/format_datetime.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/core/widgets/copy_and_capture_screenshot_buttons.dart';
import 'package:qr_reader/core/widgets/custom_appbar.dart';
import 'package:qr_reader/core/functions/build_action_button.dart';
import 'package:qr_reader/features/generate_qr/presentation/widgets/generate_qr_item_view_body.dart';
import 'package:qr_reader/features/history/domain/history_item_entity.dart';
import 'package:screenshot/screenshot.dart';

class ViewHistoryQrItem extends StatelessWidget {
  const ViewHistoryQrItem({super.key, required this.item});
  final HistoryItemEntity item;
  @override
  Widget build(BuildContext context) {
    final ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundCircles(),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(80),
                  Screenshot(
                    controller: screenshotController,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            color: AppColors.blackGreyish,
                          ),
                          child: Text(item.qrData ?? item.data),
                        ),
                        const Gap(40),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            child: QrImageView(
                              data: item.data,
                              backgroundColor: Colors.white,
                              size: 160,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(41),
                  CopyAndCaptureScreenshotButtons(
                    data: item.qrData ?? item.data,
                    screenshotController: screenshotController,
                  ),
                  const Gap(12),
                  buildActionbutton(
                    data: item.data,
                    type: QRCodeType.values.byName(item.type),
                  ),
                  const Gap(60),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(formatDateTime(item.date)),
            ),
          ),
          CustomAppBar(title: item.type),
        ],
      ),
    );
  }
}
