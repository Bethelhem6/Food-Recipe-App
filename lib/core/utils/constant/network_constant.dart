
import 'package:emebet/features/notification/domain/models/notification_param.dart';

const String apiUrl = "http://192.168.1.15:8007/api/";
// const String apiUrl = "https://linq-lm75.onrender.com/api/";

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

  static String getChildByParentId(String parentId) {
    String query =
        'includes[]=busStop&includes[]=busStop.stations&includes[]=stations.route&includes[]=route.vehicle&includes[]=vehicle.driver';
    return "parents/get-kids-with-parent-id/$parentId?$query";
  }

  static String updateParent() {
    return "parents/update-parent";
  }

  static String getParent(String parentId) {
    return "parents/get-parent/$parentId";
  }

  static String checkParent(String phoneNumber) {
    return "parents/check-parent?phoneNumber=$phoneNumber";
  }

  static String getKidByCity(String commonName) {
    return "parents/get-kids-by-common-name?commonName=$commonName";
  }

  static String assignKid() {
    return "parents/assign-kid";
  }

  static String unassignKid() {
    return "parents/unassign-kid";
  }

  static String registerParent() {
    return "parents/register-parent";
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

////////////////////////////////////////////////////////////////
///
///   TRIP END POINT

class TripEndPoint {
  static String getRoutes(String routeId) {
    // String filter =
    //     "includes[0]=stations&includes[1]=stations.busStop&includes[2]=busStop.kid&includes[3]=bookings";
    String filter = "includes[0]=stations&includes[1]=stations";

    return "routes/get-route/$routeId?$filter";
  }

  static String getBookings(String kidId, String routeId) {
    String includes =
        '&includes[]=kid&includes[]=route&includes[]=route.stations&includes[]=stations.busStop';
    String filter =
        "?filter[0][0][field]=kidId&filter[0][0][operator]==&filter[0][0][value]=$kidId&filter[0][1][field]=routeId&filter[0][1][operator]==&filter[0][1][value]=$routeId&filter[0][2][field]=status&filter[0][2][operator]==&filter[0][2][value]=Created";
    return "bookings/get-bookings$filter$includes";
  }
}



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
