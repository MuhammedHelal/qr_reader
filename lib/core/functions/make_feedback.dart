import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qr_reader/core/services/locator.dart';
import 'package:qr_reader/core/utils/assets.dart';
import 'package:qr_reader/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:vibration/vibration.dart';

Future<void> makeFeedback() async {
  final settingsEntity = locator<SettingsCubit>().settingsEntity;
  if (settingsEntity.vibrate) {
    Vibration.vibrate(duration: 300);
  }
  if (settingsEntity.beep) {
    AudioPlayer player = AudioPlayer();
    await player.setAudioSource(AudioSource.asset(Assets.assetsSoundsDuck));
    await player.play();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        player.dispose();
      },
    );
  }
}
