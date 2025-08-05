import 'package:hive_flutter/hive_flutter.dart';


abstract class HiveService<T> {
  final String boxName;

  HiveService({required this.boxName});

  Future<Box<T>> get _box async => await Hive.openBox<T>(boxName);

  Future<void> create(T model);
  Future<List<T>> read();
  Future<void> update(int index, T model);
  Future<void> delete(int index);
  Future<void> clear();

}