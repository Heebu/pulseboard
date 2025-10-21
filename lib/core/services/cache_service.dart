import 'package:hive/hive.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  final _box = Hive.box('cache');

  Future<void> saveData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic getData(String key) => _box.get(key);

  bool containsKey(String key) => _box.containsKey(key);

  Future<void> clearKey(String key) async => _box.delete(key);
}
