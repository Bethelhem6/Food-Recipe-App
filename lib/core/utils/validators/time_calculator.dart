 String getAssignmentTime(String time, String lang) {
    int hour = 0;
    int calculatedTime = 0;
    String convertedDate = "";
    String minute = "";
    String amPm = "";
    List times = time.split(":");
    if (lang == 'English') {
      if (int.parse(times[0]) <= 12) {
        hour = int.parse(times[0]);
        amPm = 'AM';
      } else {
        hour = int.parse(times[0]) - 12;
        amPm = 'PM';
      }
    } else {
      if (int.parse(times[0]) <= 12) {
        if (int.parse(times[0]) <= 6) {
          hour = int.parse(times[0]) + 6;
          amPm = "ከምሽቱ";
        } else {
          hour = int.parse(times[0]) - 6;
          amPm = "ከጠዋት";
        }
      } else {
        calculatedTime = int.parse(times[0]) - 12;
        if (calculatedTime <= 12) {
          if (calculatedTime <= 6) {
            hour = calculatedTime + 6;
            amPm = "ከሰዓት";
          } else {
            hour = calculatedTime - 6;
            amPm = 'ከምሽቱ';
          }
        }
      }
    }
    minute = times[1];
    convertedDate = '$hour:$minute';
    return '$convertedDate $amPm';
  }