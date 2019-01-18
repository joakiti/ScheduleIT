import 'package:flutter/material.dart';
import '../ui/reservation_menu_item.dart';
import 'package:timeline/main_menu/menu_data.dart';
import '../models/calender_item.dart';
import '../mybloc/reservations_bloc.dart';

class ReservationList extends StatelessWidget {
  final MenuItemData label;

  ReservationList({this.label});

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllReservations();
    return Scaffold(
      appBar: AppBar(
        title: Text(label.label),
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

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20),
        itemCount: snapshot.data.reservations.length,
        itemBuilder: (BuildContext context, int index) {
          Reservation reservation = snapshot.data.reservations[index];
          return Container(
              margin: EdgeInsets.only(top: 20.0),
              child: MenuSection(
                backgroundColor: Colors.deepPurpleAccent,
                accentColor: Colors.amberAccent,
                isActive: false,
                menuOptions: [reservation.room, reservation.courseType],
                reservation: reservation,
              ));
        });
  }
}
