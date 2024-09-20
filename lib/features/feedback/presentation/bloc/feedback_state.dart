 
import 'package:equatable/equatable.dart';

import '../../../../core/network/error/failures.dart';

abstract class FeedbackState extends Equatable {}

class FeedbackLoading extends FeedbackState {
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///     feedback
class FeedbackSendFeedbackLoading extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class FeedbackSendFeedbackSuccess extends FeedbackState {
  final bool logout;
  FeedbackSendFeedbackSuccess({required this.logout});
  @override
  List<Object?> get props => [];
}

class FeedbackSendFeedbackFaulire extends FeedbackState {
  final Failure failure;
  FeedbackSendFeedbackFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}
 