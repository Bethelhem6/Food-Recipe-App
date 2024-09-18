import 'package:emebet/core/utils/utils.dart';

import '../models/announce_driver.dart';
import '../models/feedback_param.dart';

abstract class AbstractFeedBackRepository {
  ResultFuture<bool> sendFeedback(FeedbackParam param);
  ResultFuture<bool> announceDriver(AnnounceDriverParam param);
}
