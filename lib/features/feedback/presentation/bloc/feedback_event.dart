 
import '../../domain/models/feedback_param.dart';

abstract class FeedbackEvent {}

class FeedbackSendFeedback extends FeedbackEvent {
  FeedbackParam param;
  FeedbackSendFeedback({required this.param});
}

 