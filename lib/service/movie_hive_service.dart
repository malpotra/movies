import 'package:movies_app/service/hive_service.dart';
import 'package:movies_app/models/movie.dart';
import 'package:hive_flutter/hive_flutter.dart';


class MovieHiveService implements HiveService<Movie> {

  static const String boxName = 'movieBox';

  MovieHiveService() : super(boxName: boxName);

  @override
  Future<void> create(Movie model) async {
    final box = await _box;
    await box.add(model);
  }

  @override
  Future<List<Movie>> read() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> update(int index, Movie model) async {
    final box = await _box;
    await box.putAt(index, model);
  }

  @override
  Future<void> delete(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }

  @override
  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }
}