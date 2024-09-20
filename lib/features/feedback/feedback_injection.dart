import '../../core/utils/injections.dart'; 

import '../../core/network/dio_network.dart';
import 'data/data_sources/remote/feedback_impl_api.dart';
import 'data/repositories/feedback_repo_impl.dart';
import 'domain/repository/abstract_feedback_repository.dart';
import 'domain/usecases/feedback_usecase.dart';
import 'presentation/bloc/feedback_bloc.dart';

initFeedbackInjections() {
  sl.registerSingleton<FeedbackImplApi>(FeedbackImplApi(DioNetwork.appAPI));
  sl.registerSingleton<AbstractFeedBackRepository>(FeedbackRepoImpl(sl()));
  // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
  sl.registerSingleton<FeedBackUsecase>(FeedBackUsecase(sl()));

  sl.registerFactory<FeedbackBloc>(() => FeedbackBloc(feedbackUsecase: sl()));
}
