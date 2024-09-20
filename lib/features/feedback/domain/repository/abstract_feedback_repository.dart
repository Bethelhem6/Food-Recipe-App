import '../../../../core/utils/utils.dart'; 
import '../models/feedback_param.dart';

abstract class AbstractFeedBackRepository {
  ResultFuture<bool> sendFeedback(FeedbackParam param);
}
