import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_reader/core/utils/text_styles.dart';
import 'package:qr_reader/features/settings/presentation/widgets/beep_widget.dart';
import 'package:qr_reader/features/settings/presentation/widgets/settings_item_container.dart';
import 'package:qr_reader/features/settings/presentation/widgets/vibrate_settings.dart';

class SettingsColumn extends StatelessWidget {
  const SettingsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: AppTextStyles.primary26W500,
        ),
        Gap(20),
        SettingsItemContainer(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: VibrateSettingsWidget(),
          ),
        ),
        Gap(10),
        SettingsItemContainer(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BeepSettingsWidget(),
          ),
        ),
        /*  const Gap(10),
        SettingsItemContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.delete_forever_sharp,
                size: 25,
                color: Colors.red,
              ),
              title: const Text('Delete history!'),
              subtitle: const Text(
                'Delete all scanned and generated history',
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}
