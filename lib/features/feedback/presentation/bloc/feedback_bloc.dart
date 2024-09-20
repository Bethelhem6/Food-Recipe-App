import 'package:dartz/dartz.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/usecases/feedback_usecase.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedBackUsecase feedbackUsecase;

  FeedbackBloc({required this.feedbackUsecase}) : super(FeedbackLoading()) {
    on<FeedbackSendFeedback>(_onSendFeedback); 
  }

  void _onSendFeedback(
      FeedbackSendFeedback event, Emitter<FeedbackState> emit) async {
    emit(FeedbackSendFeedbackLoading());
    Either<Failure, bool> result =
        await feedbackUsecase.sendFeedback(event.param);
    result.fold(
        (Failure failure) => emit(
              FeedbackSendFeedbackFaulire(failure: failure),
            ), (bool logout) {
      emit(FeedbackSendFeedbackSuccess(logout: logout));
    });
  }

   
}
