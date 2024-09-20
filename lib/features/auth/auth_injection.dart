import 'package:mvvm/features/auth/data/repositories/auth_repo_impl.dart';

import '../../core/utils/injections.dart'; 

import '../../core/network/dio_network.dart';
import 'data/data_sources/remote/auth_impl_api.dart';
import 'domain/repository/abstract_auth_repository.dart';
import 'domain/usecases/auth_usecase.dart';
import 'presentaion/bloc/auth_bloc.dart';

initAuthInjections() {
  sl.registerSingleton<AuthImplApi>(AuthImplApi(DioNetwork.appAPI));
  sl.registerSingleton<AbstractAuthRepository>(AuthRepoImpl(sl()));
  // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
  sl.registerSingleton<AuthUsecase>(AuthUsecase(sl()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(authUsecase: sl()));
}
