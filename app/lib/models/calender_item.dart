class ItemModel {
  List<dynamic> _columnHeaders;
  Map<dynamic, dynamic> _info;
  List<Reservation> _reservations;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['reservations'].length);
    _columnHeaders = parsedJson['columnheaders'];
    _info = parsedJson['info'];
    List<Reservation> temp = [];
    for (int i = 0; i < parsedJson['reservations'].length; i++) {
      Reservation reservation = Reservation(parsedJson['reservations'][i]);
      temp.add(reservation);
    }
    _reservations = temp;
  }

  List<Reservation> get reservations => _reservations;

  Map<dynamic, dynamic> get info => _info;

  List<dynamic> get columnHeaders => _columnHeaders;
}

class Reservation {
  String _id;
  DateTime _startDate;
  String _startTime;
  String _endTime;

  String get endTime => _endTime;
  String _studyActivity;
  String _namePerson;
  String _room;
  String _programme;
  String _courseType;
  String _courseName;
  String _courseCode;
  String _lectureType;

  String get lectureType => _lectureType;

  String get id => _id;
  DateTime _endDate;



  Reservation(reservation) {
    _id = reservation['id'];
    _startDate = DateTime.parse(reservation['startdate']);
    _startTime = reservation['starttime'];
    _endDate = DateTime.parse(reservation['enddate']);
    _endTime = reservation['endtime'];
    _studyActivity = reservation['columns'][0];
    _namePerson = reservation['columns'][1];
    _room = reservation['columns'][2];
    _programme = reservation['columns'][3];
    _courseType = reservation['columns'][4];
    _lectureType = reservation['columns'][5];
    List<String> formattedActivity = _studyActivity.split(".");
    _courseName = formattedActivity[0];
    _courseCode = formattedActivity[1].split(",")[0];

  }

  DateTime get startDate => _startDate;

  String get startTime => _startTime;

  String get studyActivity => _studyActivity;

  String get namePerson => _namePerson;

  String get room => _room;

  String get programme => _programme;

  String get courseType => _courseType;

  String get courseName => _courseName;

  String get courseCode => _courseCode;

  DateTime get endDate => _endDate;
}