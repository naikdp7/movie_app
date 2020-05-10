import 'package:kiwi/kiwi.dart';
import 'package:movie_app/bloc/movie_detail_bloc.dart';
import 'package:movie_app/bloc/movie_list_bloc.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/service/movie_service.dart';

part 'kiwi.g.dart';

abstract class Injector {
  @Register.factory(MovieBloc)
  @Register.factory(MovieDetailBloc)
  @Register.factory(MovieRepository)
  @Register.factory(MovieService)
  void configure();
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
