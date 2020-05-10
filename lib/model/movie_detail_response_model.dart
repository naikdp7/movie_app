class MovieDetailRS {
  final String originalTitle,
      overview,
      posterPath,
      country = "USA",
      releaseDate;
  final int id, runTime;
  final double rating;
  final List genre;

  MovieDetailRS(
      {this.rating,
      this.genre,
      this.releaseDate,
      this.runTime,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.id});

  factory MovieDetailRS.fromJson(Map<String, dynamic> json) {
    return MovieDetailRS(
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        id: json['id'],
        releaseDate: json['release_date'],
        runTime: json['runtime'],
        genre: json['genres'],
        rating: json['vote_average']);
  }
}
