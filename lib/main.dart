import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:movie_app/utils/app_localization.dart';
import 'package:movie_app/di/kiwi.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/movie_list_page.dart';
import 'package:movie_app/utils/routes.dart';
import 'bloc/movie_list_bloc.dart';

void main() {
  setup();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Raleway'),
    routes: {
      "/": (context) => MovieApp(),
      AppRoute.movieDetail: (context) => MovieDetailPage()
    },
    supportedLocales: [Locale('en', 'US')],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },
  ));
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieBloc>(
        creator: (context, test) => kiwi.Container().resolve<MovieBloc>(),
        child: MoviePage(),
      ),
    );
  }
}
