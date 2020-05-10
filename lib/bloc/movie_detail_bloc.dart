import 'package:bloc_provider/bloc_provider.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends Bloc {
  MovieRepository movieRepository;
  BehaviorSubject<MovieModel> movieModelSubject = BehaviorSubject();

  MovieDetailBloc(MovieRepository movieRepository) {
    this.movieRepository = movieRepository;
  }

  Future<void> getMovieDetail(int movieId) async {
    var movieDetail = await movieRepository.getMovieDetail(movieId);
    if (!movieModelSubject.isClosed) movieModelSubject.add(movieDetail);
  }

  @override
  void dispose() {
    movieModelSubject.close();
  }
}
