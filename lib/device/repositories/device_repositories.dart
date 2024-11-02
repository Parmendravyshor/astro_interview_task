import 'package:eco/domain/repositories/domain_repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class DeviceRepository extends DomainRepository {
  /// initialize flutter secure storage
  final _flutterSecureStorage = const FlutterSecureStorage();

  /// Returns the box in which the data is stored.
  Box _getBox() => Hive.box<dynamic>('airmymd');

  @override
  String getStringValue(String key) {
    var box = _getBox();
    var value = box.get(key) as String? ?? '';
    return value;
  }

  ///To get Int Value
  @override
  int getIntValue(String key) {
    var box = _getBox();
    var defaultValue = 0;
    var value = box.get(key, defaultValue: defaultValue) as int;
    return value;
  }

  ///to save a value
  @override
  void saveValue(dynamic key, dynamic value) {
    _getBox().put(key, value);
  }

  @override
  bool getBoolValue(String key) {
    var box = _getBox();
    var defaultValue = false;
    var value = box.get(key, defaultValue: defaultValue) as bool;
    return value;
  }

  ///to clear data
  @override
  void clearData(dynamic key) {
    _getBox().delete(key);
  }

  /// clear all data
  @override
  void clearBox() {
    _getBox().clear();
  }

  @override
  void deleteAllSecuredValues() {
    _flutterSecureStorage.deleteAll();
  }

  @override
  void deleteSecuredValue(String key) {
    _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String?> getSecuredValue(String key) async {
    var value = await _flutterSecureStorage.read(key: key);
    return value;
  }

  @override
  void saveValueSecurely(String key, String value) {
    _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> loginUserModel({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }
}
