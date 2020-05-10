import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_localization.dart';
import 'package:movie_app/bloc/movie_list_bloc.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/widgets/movie_horizontal.dart';
import 'package:movie_app/widgets/movie_image.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<MovieBloc>(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.drag_handle,
            color: Colors.black,
          ),
          title: Text(
            AppLocalizations.of(context).translate('title_netflix'),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        StreamBuilder<List<MovieModel>>(
          stream: bloc.popularMovieSubject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverToBoxAdapter(
                  child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: PageView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, id) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: MovieImage(snapshot.data[id]),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "${snapshot.data[id].title}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ));
            } else {
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        MoviesHorizontalWidget(
            AppLocalizations.of(context).translate('upcoming_movies'),
            bloc.upComingMovieSubject),
        MoviesHorizontalWidget(
            AppLocalizations.of(context).translate('latest_movies'),
            bloc.latestMoviesSubject),
        MoviesHorizontalWidget(
            AppLocalizations.of(context).translate('top_rated_movies'),
            bloc.topRatedMovieSubject)
      ],
    );
  }
}
