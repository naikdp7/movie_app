// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kiwi.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory((c) => MovieBloc(c<MovieRepository>()));
    container.registerFactory((c) => MovieDetailBloc(c<MovieRepository>()));
    container.registerFactory((c) => MovieRepository(c<MovieService>()));
    container.registerFactory((c) => MovieService());
  }
}
