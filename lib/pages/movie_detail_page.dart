import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/utils/app_localization.dart';
import 'package:movie_app/bloc/movie_detail_bloc.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/utils/extentions.dart';
import 'package:movie_app/widgets/detail_movie_image.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          creator: (context, _) => kiwi.Container().resolve<MovieDetailBloc>(),
          child: MovieDetail(),
        ),
      ),
    );
  }
}

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int movieId = ModalRoute.of(context).settings.arguments;
    var bloc = BlocProvider.of<MovieDetailBloc>(context);
    bloc.getMovieDetail(movieId);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MovieDetailBloc>(context);
    return StreamBuilder<MovieModel>(
      stream: bloc.movieModelSubject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MovieBannerImage(
                  imgUrl: getPosterImage(snapshot.data.posterPath),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${snapshot.data.title}",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: List.generate(
                            snapshot.data.genreList.length,
                            (i) {
                              return TextSpan(
                                  text:
                                      "${snapshot.data.genreList[i]['name']} ");
                            },
                          ),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      SizedBox(height: 9.0),
                      RatingBar(
                        initialRating: snapshot.data.rating,
                        // initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 10,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 25,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(height: 13.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).translate('year'),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                "${DateTime.parse(snapshot.data.releaseData).year}",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('country'),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                "${snapshot.data.country}",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('length'),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                "${snapshot.data.runTime} min",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 13.0),
                      Text(
                        "${snapshot.data.overview}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .apply(fontSizeFactor: 1.2),
                      ),
                      SizedBox(height: 13.0),
                    ],
                  ),
                ),
                // MyScreenshots(),
                SizedBox(height: 13.0),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
