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
  String _startDate;
  String _starttime;
  String _studyActivity;
  String _namePerson;
  String _room;
  String _programme;
  String _courseType;



  Reservation(reservation) {
    _id = reservation['id'];
    _startDate = reservation['startdate'];
    _starttime = reservation['starttime'];
    _studyActivity = reservation['columns'][0];
    _namePerson = reservation['columns'][1];
    _room = reservation['columns'][2];
    _programme = reservation['columns'][3];
    _courseType = reservation['columns'][4];

  }

  String get id => _id;
  String get starttime => _starttime;
  String get namePerson => _namePerson;
  String get studyActivity => _studyActivity;
  String get startDate => _startDate;
  String get room => _room;
  String get programme => _programme;
  String get courseType => _courseType;


}