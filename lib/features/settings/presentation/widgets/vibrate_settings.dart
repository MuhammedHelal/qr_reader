import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/features/settings/presentation/manager/cubit/settings_cubit.dart';

class VibrateSettingsWidget extends StatelessWidget {
  const VibrateSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsCubit cubit = BlocProvider.of<SettingsCubit>(context);
    return ListTile(
      leading: const Icon(
        Icons.vibration,
        size: 25,
        color: AppColors.primary,
      ),
      title: const Text('Vibrate'),
      subtitle: const Text('Vibration when scan is done.'),
      trailing: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Switch(
            value: cubit.settingsEntity.vibrate,
            onChanged: (value) {
              cubit.changeVibrate(value);
            },
          );
        },
      ),
    );
  }
}
