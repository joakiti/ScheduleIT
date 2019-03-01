class ItemModel {
  List<Reservation> _reservations;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['reservations'].length);
    List<Reservation> temp = [];
    for (int i = 0; i < parsedJson['reservations'].length; i++) {
      Reservation reservation = Reservation.fromReservation(parsedJson['reservations'][i]);
      temp.add(reservation);
    }
    _reservations = temp;
  }

  ItemModel.fromList(List<Reservation> reservations) {
    _reservations = reservations;
  }

  List<Reservation> get reservations => _reservations;

}

class Reservation implements Comparable<Reservation> {
  String _id = "";
  String _startTime = "";
  String _endTime = "";
  String _studyActivity = "";
  String _namePerson = "";
  String _room = "";
  String _programme = "";
  String _courseType = "";
  String _courseName = "";
  String _courseCode = "";
  String _lectureType = "Activity";
  DateTime _endDate = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _startDate = DateTime.fromMillisecondsSinceEpoch(0);

  Reservation();

  Reservation.fromReservation(reservation) {
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
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
  }

  String get lectureType => _lectureType;

  set lectureType(String value) {
    _lectureType = value;
  }

  String get courseCode => _courseCode;

  set courseCode(String value) {
    _courseCode = value;
  }

  String get courseName => _courseName;

  set courseName(String value) {
    _courseName = value;
  }

  String get courseType => _courseType;

  set courseType(String value) {
    _courseType = value;
  }

  String get programme => _programme;

  set programme(String value) {
    _programme = value;
  }

  String get room => _room;

  set room(String value) {
    _room = value;
  }

  String get namePerson => _namePerson;

  set namePerson(String value) {
    _namePerson = value;
  }

  String get studyActivity => _studyActivity;

  set studyActivity(String value) {
    _studyActivity = value;
  }

  String get endTime => _endTime;

  set endTime(String value) {
    _endTime = value;
  }

  String get startTime => _startTime;

  set startTime(String value) {
    _startTime = value;
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
  }

  @override
  int compareTo(Reservation other) {
    if (startDate.isAtSameMomentAs(other.startDate)) return 0;
    else if (startDate.isAfter(other.startDate)) return 1;
    else return -1;


  }

}