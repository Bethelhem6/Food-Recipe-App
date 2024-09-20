import '../../core/utils/injections.dart'; 
import '../../core/network/dio_network.dart';
import 'data/data_sources/remote/notifications_impl_api.dart';
import 'data/repositories/notifications_repo_impl.dart';
import 'domain/repository/abstract_notifications_repository.dart';
import 'domain/usecases/notifications_usecase.dart';
import 'presentation/bloc/notification_bloc.dart';

initNotificationInjections() {
  sl.registerSingleton<NotificationsImplApi>(
      NotificationsImplApi(DioNetwork.appAPI));
  sl.registerSingleton<AbstractNotificationsRepository>(
      NotificationsRepoImpl(sl()));
  // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
  sl.registerSingleton<NotificationsUsecase>(NotificationsUsecase(sl()));

  sl.registerFactory<NotificationBloc>(
      () => NotificationBloc(notificationsUsecase: sl()));
}
