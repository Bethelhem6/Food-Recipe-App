
import 'package:emebet/core/utils/injections.dart';
import 'package:emebet/features/auth/data/data_sources/remote/auth_impl_api.dart';
import 'package:emebet/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:emebet/features/auth/domain/repository/abstract_auth_repository.dart';
import 'package:emebet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_bloc.dart';

import '../../core/network/dio_network.dart';

initAuthInjections() {
  sl.registerSingleton<AuthImplApi>(AuthImplApi(DioNetwork.appAPI));
  sl.registerSingleton<AbstractAuthRepository>(AuthRepoImpl(sl()));
  // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
  sl.registerSingleton<AuthUsecase>(AuthUsecase(sl()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(authUsecase: sl()));
}
