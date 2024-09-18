import 'package:emebet/features/feedback/domain/models/announce_driver.dart';

import '../../domain/models/feedback_param.dart';

abstract class FeedbackEvent {}

class FeedbackSendFeedback extends FeedbackEvent {
  FeedbackParam param;
  FeedbackSendFeedback({required this.param});
}

class AnnounceDriverEvent extends FeedbackEvent {
  AnnounceDriverParam param;
  AnnounceDriverEvent({required this.param});
}
