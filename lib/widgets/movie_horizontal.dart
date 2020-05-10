import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/widgets/movie_image.dart';

class MoviesHorizontalWidget extends StatelessWidget {
  final String title;
  final Stream<List<MovieModel>> movieStream;

  MoviesHorizontalWidget(this.title, this.movieStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieModel>>(
      stream: movieStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            return SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 8.0),
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8.0),
                                child: MovieImage(snapshot.data[index]),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter();
          }
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
