class MovieModel {
  int id, runTime;
  String title;
  String posterPath, releaseData, country = "USA", overview;

  List genreList = List();

  double rating;

  MovieModel(this.id, this.title, this.posterPath);

  MovieModel.getMovieModel(
      this.id,
      this.runTime,
      this.title,
      this.posterPath,
      this.releaseData,
      this.country,
      this.overview,
      this.genreList,
      this.rating);
}
