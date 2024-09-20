import '../../../features/notification/domain/models/notification_param.dart';

const String apiUrl = "http://192.168.1.15:8007/api/";
// const String apiUrl = "https:// Mvvm-lm75.onrender.com/api/";

// String baseUrl = "http://192.168.1.2:8001/";
////////////////////////////////////////////////////////////////
///
///   AUTH END POINT
class AuthEndpoint {
  static String login() {
    return "auth/login";
  }

  static String refreshToken() {
    return "auth/refresh";
  }

  static String changePassword() {
    return "auth/change-password";
  }

  static String resetPassword() {
    return "auth/update-password-app";
  }

  static String logout() {
    return "auth/logout";
  }
}

////////////////////////////////////////////////////////////////
///
///   FEED BACK

class FeedBackEndpoint {
  static String sendFeedback() {
    return "feedbacks/create-feedback";
  }

  static String announceDriver() {
    return "parents/update-kid-pickup";
  }
}

//
////////////////////////////////////////////////////////////////
///
///   NOTIFICATION END POINT
class NotificationEndPoint {
  static String getNotifications(NotificationParam param) {
    String query = '';
    if (param.top == null) {
      query = '';
    } else {
      query =
          "?orderBy[0][field]=createdAt&orderBy[0][direction]=desc&top=${param.top}&skip=${param.skip}";
    }
    return "notifications/get-my-notifications${query.isEmpty ? "" : query}";
  }
}
