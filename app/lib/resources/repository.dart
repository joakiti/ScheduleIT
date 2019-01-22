import 'dart:async';
import 'reservations_api_provider.dart';
import '../models/calender_item.dart';

class Repository {
  final moviesApiProvider = ReservationsApiProvider();

  Future<ItemModel> fetchAllReservations(String endpoint) => moviesApiProvider.fetchReservations(endpoint);
}