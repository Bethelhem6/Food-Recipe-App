 
import '../../../domain/models/feedback_param.dart';

abstract class AbstractFeedbackApi {
  Future<bool> sendFeedback(FeedbackParam param); 
}
