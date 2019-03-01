import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import "package:flutter/services.dart" show rootBundle;
import '../models/calender_item.dart';

class ReservationsApiProvider {
  Client client = Client();
  List<Reservation> reservations;
  RegExp nameSeperator = new RegExp(r"(.*?)(Study Activity)([\\ , :]+)([A-Za-zæøåÆØÅ: ,.0-9\-&]+)");
  RegExp lectureSeperator = new RegExp(r"(Activity: )([A-Za-zæøåÆØÅ: ,.0-9\-&]+)");



  Future<ItemModel> fetchReservations(String endpoint) async {
    final response = await client
        .get("https://itu-schedule.herokuapp.com" + endpoint);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> parseReservations(String endpoint) async {
    final success = await loadFromBundle("assets/schedules" + endpoint + ".ics");
    if (success) {
      reservations.sort();
      return ItemModel.fromList(reservations);
    }
    else {
      print("Error occured during parsing!!!!");
      return ItemModel.fromList([new Reservation()]);
    }

  }

  /**
   * STRUCTURE OF COURSEFILE:
   * --- HEADER ---
   * BEGIN: VCALENDAR
   * VERSION: 2.0
   * METHOD:PUBLISH
   * X-WR-CALNAME:TimeEdit-SWU 1st year-20190225
   * X-WR-CALDESC:Date limit -
   * X-PUBLISHED-TTL:PT20M
   * CALSCALE:GREGORIAN
   * PRODID:-//TimeEdit\\\, //TimeEdit//EN
   * --- END HEADER ---
   *
   * BEGIN: VEVENT
   *
   */

  Future<bool> loadFromBundle(String path) async {
    List<Reservation> menu = List<Reservation>();
    List<String> data = (await rootBundle.loadString(path)).split("\r\n");
    Reservation r;
    reservations = [];
    for (int i = 0; i < data.length; i++ ) {
      RegExp colonSeperator = new RegExp("^([\\w-]*?):(.*)\$");
      String entry = data[i];
      Match match = colonSeperator.firstMatch(entry);
      if (match == null) {
        continue;
      }
      String icsKey = match.group(1);
      String icsValue = match.group(2);
      print(icsKey);
      print(icsValue);
      switch (icsKey) {
        case "BEGIN": {
          r = new Reservation();
          break;
        }
        case "LOCATION": {
          icsValue = icsValue.replaceAll("Room:", "");
          icsValue = icsValue.replaceAll("\\", "");
          r.room = icsValue;
          break;
        }
        case "SUMMARY": {
          StringBuffer sb = new StringBuffer(entry);
          int next = 1;
            while (!data[i + next].startsWith("LOCATION")) {
              sb.write(data[i+next].substring(1)); // Remove space in beginning... shitty format
              next++;
            }
          String summary = sb.toString();
          Match m = nameSeperator.firstMatch(summary);
          String isMatch;
          if (m != null) {
            isMatch = m.group(4);
          }
          /**
           * Now we need to recognize some specific facts in the Summary string. For example, i only want the course name right now.
           */
          r.courseName = isMatch;
          Iterable<Match> lectureTypes = lectureSeperator.allMatches(summary);
          if (lectureTypes.length > 0) {
            r.lectureType = "";
            int j = 0;
            for (Match m in lectureTypes) {
              if (j > 0) {
                r.lectureType = m.group(2)+ " and " +  r.lectureType;
              }
              else {
                r.lectureType = m.group(2);
              }
              j++;
            }
          }
          break;
        }
        case "DTSTART": {
          entry = entry.replaceAll("DTSTART:", "");
          DateTime dt = new DateTime.utc(int.parse(entry.substring(0,4)), int.parse(entry.substring(4,6)), int.parse(entry.substring(6,8)), int.parse(entry.substring(9,11)));
          dt = dt.toLocal();
          r.startDate = dt;
          r.startTime = dt.hour.toString() + (dt.minute == 0 ? "" : ":" + (dt.minute.toString().length < 2 ? "0" + dt.minute.toString() : dt.minute.toString()));
          break;
        }
        case "DTEND": {
          entry = entry.replaceAll("DTEND:", "");
          DateTime dt = new DateTime.utc(int.parse(entry.substring(0,4)), int.parse(entry.substring(4,6)), int.parse(entry.substring(6,8)), int.parse(entry.substring(9,11)));
          dt = dt.toLocal();
          r.endDate = dt;
          r.endTime = dt.hour.toString() + (dt.minute == 0 ? "" : ":" + (dt.minute.toString().length < 2 ? "0" + dt.minute.toString() : dt.minute.toString()));
          break;
        }
        case "END": {
          menu.add(r);
          break;
        }
        default: {
          //return false;
        }
      }
    }
    reservations = menu;
    return true;
  }

}