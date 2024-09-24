import 'package:get_it/get_it.dart';
import 'package:qr_reader/features/history/data/history_local_data_source.dart';
import 'package:qr_reader/features/history/presentation/manager/history_cubit/history_cubit.dart';
import 'package:qr_reader/features/settings/presentation/manager/cubit/settings_cubit.dart';

final GetIt locator = GetIt.instance;
void setupServiceLocator() {
  locator.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(),
  );

  locator.registerLazySingleton<HistoryCubit>(
    () => HistoryCubit(HistoryLocalDataSource()),
  );
}
