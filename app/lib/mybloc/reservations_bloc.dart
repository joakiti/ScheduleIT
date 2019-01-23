import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/calender_item.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllReservations(String endpoint) async {
    ItemModel itemModel = await _repository.fetchAllReservations(endpoint);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();