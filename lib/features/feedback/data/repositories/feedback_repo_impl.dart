import 'package:dartz/dartz.dart';
import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/feedback/domain/models/feedback_param.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/models/announce_driver.dart';
import '../../domain/repository/abstract_feedback_repository.dart';
import '../data_sources/remote/feedback_impl_api.dart';

class FeedbackRepoImpl extends AbstractFeedBackRepository {
  final FeedbackImplApi feedbackImplApi;

  FeedbackRepoImpl(this.feedbackImplApi);

  @override
  ResultFuture<bool> sendFeedback(FeedbackParam param) async {
    try {
      final result = await feedbackImplApi.sendFeedback(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<bool> announceDriver(AnnounceDriverParam param) async {
    try {
      final result = await feedbackImplApi.announceDriver(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
