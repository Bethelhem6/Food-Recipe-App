import 'package:emebet/core/network/error/failures.dart';
import 'package:equatable/equatable.dart';

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

///////////////////////////////////////////////////////////
///     AnnounceDriverEvent
class AnnounceDriverEventLoading extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class AnnounceDriverEventSuccess extends FeedbackState {
  final bool logout;
  AnnounceDriverEventSuccess({required this.logout});
  @override
  List<Object?> get props => [];
}

class AnnounceDriverEventFaulire extends FeedbackState {
  final Failure failure;
  AnnounceDriverEventFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}
