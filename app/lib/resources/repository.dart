import 'dart:async';
import 'reservations_api_provider.dart';
import '../models/calender_item.dart';

class Repository {
  final courseApiProvider = ReservationsApiProvider();

  Future<ItemModel> fetchAllReservations(String endpoint) => courseApiProvider.fetchReservations(endpoint);
  Future<ItemModel> parseAllReservations(String endpoint) => courseApiProvider.parseReservations(endpoint);

}