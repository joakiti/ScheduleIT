import 'package:flutter/material.dart';
import '../ui/reservation_menu_item.dart';
import 'package:timeline/main_menu/menu_data.dart';
import '../models/calender_item.dart';
import '../mybloc/reservations_bloc.dart';

class ReservationList extends StatefulWidget {
  final MenuItemData label;

  ReservationList({this.label});

  @override
  State<StatefulWidget> createState() {
    return new ReservationListState();
  }

  void onLoad(BuildContext context) {} //callback when layout build done

}

class ReservationListState extends State<ReservationList> {
  ScrollController _scrollController;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllReservations();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label.label),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildTitle(DateTime startTime) {
    String calenderDay = startTime.day.toString();
    String calenderMonth = startTime.month.toString();
    String weekDay;
    switch(startTime.weekday) {
      case 1: {
        weekDay = "Monday";
        break;
      }
      case 2: {
        weekDay = "Tuesday";
        break;

      }
      case 3: {
        weekDay = "Wednesday";
        break;

      }
      case 4: {
        weekDay = "Thursday";
        break;

      }
      case 5: {
        weekDay = "Friday";
        break;

      }
      case 6: {
        weekDay = "Saturday";
        break;

      }
      case 7: {
        weekDay = "Sunday";
        break;
      }
      default: {
        weekDay = "";
      }

    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
              child: Text(
                    "$weekDay the $calenderDay/$calenderMonth",
                    style: TextStyle(color: Colors.white, fontFamily: "Arial"),
                  )),
          (Container(
            height: 2.0,
            color: const Color.fromRGBO(255, 255, 255, 0.1),
          ))
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20),
        itemCount: snapshot.data.reservations.length,
        itemBuilder: (BuildContext context, int index) {
          Reservation reservation = snapshot.data.reservations[index];
          Widget wrapper = Container();
          if (index == 0) {
            date = reservation.startDate;
            wrapper = buildTitle(date);
          }
          if (reservation.startDate.difference(date) > Duration()) {
            date = reservation.startDate;
            wrapper = buildTitle(date);
          }
          if (reservation.startDate.difference(DateTime.now()) < Duration()) {
            return Container();
          }

          return Column(
            children: <Widget>[
              wrapper,
              Container(
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 3.0,
                          // has the effect of softening the shadow
                          spreadRadius: 1.0,
                          // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ]),
                  margin: EdgeInsets.only(top: 20.0),
                  child: MenuSection(
                    backgroundColor: Colors.indigoAccent,
                    accentColor: Colors.white,
                    isActive: false,
                    menuOptions: [reservation.room, reservation.courseType],
                    reservation: reservation,
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }
}
