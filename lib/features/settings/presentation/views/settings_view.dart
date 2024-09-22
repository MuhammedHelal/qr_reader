import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:qr_reader/core/functions/launch_url.dart';
import 'package:qr_reader/core/utils/assets.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/core/utils/text_styles.dart';
import 'package:qr_reader/core/widgets/back_icon_widget.dart';
import 'package:qr_reader/core/widgets/background_greyish_black.dart';
import 'package:qr_reader/core/widgets/black_greyish_container.dart';
import 'package:qr_reader/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:qr_reader/features/settings/presentation/widgets/beep_widget.dart';
import 'package:qr_reader/features/settings/presentation/widgets/settings_item_container.dart';
import 'package:qr_reader/features/settings/presentation/widgets/vibrate_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGreyishBlack(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackIconWidget(),
                  const Gap(40),
                  const Text(
                    'Settings',
                    style: AppTextStyles.primary24W600,
                  ),
                  const Gap(20),
                  const SettingsItemContainer(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: VibrateSettingsWidget(),
                    ),
                  ),
                  const Gap(10),
                  const SettingsItemContainer(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BeepSettingsWidget(),
                    ),
                  ),
                  const Gap(40),
                  const Text(
                    'Support',
                    style: AppTextStyles.primary24W600,
                  ),
                  const Gap(10),
                  SettingsItemContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          const String appPackageName =
                              'dev.moashraf.qr_reader';

                          final Uri playStoreUri =
                              Uri.parse('market://details?id=$appPackageName');
                          final Uri playStoreWebUri = Uri.parse(
                              'https://play.google.com/store/apps/details?id=$appPackageName');

                          if (await canLaunchUrl(playStoreUri)) {
                            log('open play store');
                            await launchUrl(playStoreUri);
                          } else if (await canLaunchUrl(playStoreWebUri)) {
                            await launchUrl(playStoreWebUri);
                            log('open play store web');
                          }
                        },
                        leading: SvgPicture.asset(
                          fit: BoxFit.cover,
                          width: 24,
                          height: 24,
                          Assets.assetsImagesRateUsIcon,
                        ),
                        title: const Text('Rate us'),
                        subtitle: const Text('Your best reward to us.'),
                      ),
                    ),
                  ),
                  const Gap(10),
                  const SettingsItemContainer(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.share,
                          size: 25,
                          color: AppColors.primary,
                        ),
                        title: Text('Share the app'),
                        subtitle: Text(
                          'Sharing is always caring.',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
