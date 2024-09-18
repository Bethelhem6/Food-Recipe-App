import 'package:dartz/dartz.dart';
import 'package:emebet/core/network/error/failures.dart';
import 'package:emebet/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:emebet/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/feedback_usecase.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedBackUsecase feedbackUsecase;

  FeedbackBloc({required this.feedbackUsecase}) : super(FeedbackLoading()) {
    on<FeedbackSendFeedback>(_onSendFeedback);
    on<AnnounceDriverEvent>(_onAnnounceDriverEvent);
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

  void _onAnnounceDriverEvent(
      AnnounceDriverEvent event, Emitter<FeedbackState> emit) async {
    emit(AnnounceDriverEventLoading());
    Either<Failure, bool> result =
        await feedbackUsecase.announceDriver(event.param);
    result.fold(
        (Failure failure) => emit(
              AnnounceDriverEventFaulire(failure: failure),
            ), (bool logout) {
      emit(AnnounceDriverEventSuccess(logout: logout));
    });
  }
}
