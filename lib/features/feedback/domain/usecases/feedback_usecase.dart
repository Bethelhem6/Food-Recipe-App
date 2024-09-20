import 'package:dartz/dartz.dart'; 

import '../../../../core/utils/usecases/usecase.dart';
import '../../../../core/utils/utils.dart';
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

  
}
