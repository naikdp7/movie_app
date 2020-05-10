import 'package:bloc_provider/bloc_provider.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends Bloc {
  MovieRepository movieRepository;
  BehaviorSubject<List<MovieModel>> popularMovieSubject = BehaviorSubject();
  BehaviorSubject<List<MovieModel>> topRatedMovieSubject = BehaviorSubject();
  BehaviorSubject<List<MovieModel>> upComingMovieSubject = BehaviorSubject();
  BehaviorSubject<List<MovieModel>> latestMoviesSubject = BehaviorSubject();

  MovieBloc(MovieRepository mainRepository) {
    this.movieRepository = mainRepository;
    _getPopularMovies();
    _getLatestMovies();
    _getTopRatedMovies();
    _getUpComingMovies();
  }

  void _getPopularMovies() {
    movieRepository.getPopularMovies().then((popularMovies) {
      if (popularMovies != null) {
        popularMovieSubject.add(popularMovies);
      }
    });
  }

  void _getLatestMovies() {
    movieRepository.getLatestMovies().then((latestMovies) {
      if (latestMovies != null) {
        latestMoviesSubject.add(latestMovies);
      }
    });
  }

  void _getTopRatedMovies() {
    movieRepository.getTopRatedMovies().then((topRatedMovies) {
      if (topRatedMovies != null) {
        topRatedMovieSubject.add(topRatedMovies);
      }
    });
  }

  void _getUpComingMovies() {
    movieRepository.getUpComingMovies().then((upComingMovies) {
      if (upComingMovies != null) {
        upComingMovieSubject.add(upComingMovies);
      }
    });
  }

  @override
  void dispose() {
    popularMovieSubject.close();
    topRatedMovieSubject.close();
    upComingMovieSubject.close();
    latestMoviesSubject.close();
  }
}
