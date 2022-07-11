import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStorage {
  // ignore: unused_field
  Box? _box;

  /// for initialling app local storage
  Future<void> initAppStorage() async {
    await Hive.initFlutter();
    // TODO: add your storage name here
    _box = await Hive.openBox('hello world');
  }

  // example of storing & getting value

  /// for storing uploaded string value
  final String _upiId = 'upiId';

  /// for getting string from box
  String? getUpiId() {
    return _box?.get(_upiId) as String?;
  }

  /// for storing upiId to app
  Future<void> putUpiId(String upiId) async {
    await _box?.put(_upiId, upiId);
  }

  /// for storing uploaded string value
  final String _name = 'name';

  /// for getting string from box
  String? getName() {
    return _box?.get(_name) as String?;
  }

  /// for storing name to app
  Future<void> putName(String name) async {
    await _box?.put(_name, name);
  }

  /// for storing uploaded string value
  final String _amount = 'amount';

  /// for getting string from box
  String? getAmount() {
    return _box?.get(_amount) as String?;
  }

  /// for storing upiId to app
  Future<void> putAmount(String amount) async {
    await _box?.put(_amount, amount);
  }

  /// for storing uploaded string value
  final String _description = 'description';

  /// for getting string from box
  String? getDescription() {
    return _box?.get(_description) as String?;
  }

  /// for storing upiId to app
  Future<void> putDescription(String description) async {
    await _box?.put(_description, description);
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await _box?.clear();
  }
}

final appStorageProvider = Provider<AppStorage>(
  (_) {
    throw UnimplementedError();
  },
);
