import '../../../domain/models/announce_driver.dart';
import '../../../domain/models/feedback_param.dart';

abstract class AbstractFeedbackApi {
  Future<bool> sendFeedback(FeedbackParam param);
  Future<bool> announceDriver(AnnounceDriverParam param);
}
