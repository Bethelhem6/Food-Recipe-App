import 'package:dartz/dartz.dart';
import 'package:emebet/core/utils/utils.dart';

import '../../../../core/utils/usecases/usecase.dart';
import '../models/announce_driver.dart';
import '../models/feedback_param.dart';
import '../repository/abstract_feedback_repository.dart';

class FeedBackUsecase extends UseCase {
  final AbstractFeedBackRepository repository;

  FeedBackUsecase(this.repository);

  ResultFuture<bool> sendFeedback(FeedbackParam param) async {
    final result = await repository.sendFeedback(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<bool> announceDriver(AnnounceDriverParam param) async {
    final result = await repository.announceDriver(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
