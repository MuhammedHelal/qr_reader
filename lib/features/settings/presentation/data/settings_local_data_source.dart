import 'package:hive/hive.dart';
import 'package:qr_reader/core/utils/strings.dart';
import 'package:qr_reader/features/settings/domain/settings_entity.dart';

class SettingsLocalDataSource {
  void saveBeep(bool value) async {
    await Hive.box(AppStrings.settingsBoxName).put(
      AppStrings.beepKey,
      value,
    );
  }

  void saveVibrate(bool value) async {
    await Hive.box(AppStrings.settingsBoxName).put(
      AppStrings.vibrateKey,
      value,
    );
  }

  bool getBeep() {
    return Hive.box(AppStrings.settingsBoxName).get(
      AppStrings.beepKey,
      defaultValue: false,
    );
  }

  bool getVibrate() {
    return Hive.box(AppStrings.settingsBoxName).get(
      AppStrings.vibrateKey,
      defaultValue: true,
    );
  }
}
