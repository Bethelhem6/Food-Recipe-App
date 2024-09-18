import 'package:emebet/features/auth/auth_injection.dart';
import 'package:emebet/shared/app_injections.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/feedback/feedback_injection.dart';
import '../../features/notification/notification_injection.dart';
import '../network/dio_network.dart';
import 'log/app_logger.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  await initAuthInjections();
  await initFeedbackInjections();
  await initNotificationInjections();
  // await initLocationInjections();
  // await initTripInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
