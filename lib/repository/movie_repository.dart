import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/movie_response_model.dart';
import 'package:movie_app/service/movie_service.dart';

class MovieRepository {
  MovieService _movieService;

  MovieRepository(MovieService mainService) {
    this._movieService = mainService;
  }

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      return _mapToMovieModel(_movieService.downloadPopularMovies());
    } catch (exception) {
      return null;
    }
  }

  Future<List<MovieModel>> getLatestMovies() async {
    try {
      return _mapToMovieModel(_movieService.downloadLatestMovies());
    } catch (exception) {
      return null;
    }
  }

  Future<List<MovieModel>> getUpComingMovies() async {
    try {
      return _mapToMovieModel(_movieService.downloadUpComingMovies());
    } catch (exception) {
      return null;
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      return _mapToMovieModel(_movieService.downloadTopRatedMovies());
    } catch (exception) {
      return null;
    }
  }

  Future<MovieModel> getMovieDetail(int movieId) async {
    try {
      return _movieService.downloadMovieDetail(movieId).then(
        (movieRS) {
          return MovieModel.getMovieModel(
              movieRS.id,
              movieRS.runTime,
              movieRS.originalTitle,
              movieRS.posterPath,
              movieRS.releaseDate,
              movieRS.country,
              movieRS.overview,
              movieRS.genre,
              movieRS.rating);
        },
      );
    } catch (exception) {
      return null;
    }
  }

  Future<List<MovieModel>> _mapToMovieModel(Future<MovieRS> movies) {
    List<MovieModel> movieModels = List();
    return movies.then((moviesRs) {
      List<Result> results = moviesRs.results;
      for (int i = 0; i < results.length; i++) {
        MovieModel movieModel =
            MovieModel(results[i].id, results[i].title, results[i].posterPath);
        movieModels.add(movieModel);
      }
      return movieModels;
    });
  }
}
