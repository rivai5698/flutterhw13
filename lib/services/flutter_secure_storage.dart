import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager{
  static final _sManager = SecureStorageManager._internal();
  factory SecureStorageManager() => _sManager;
  SecureStorageManager._internal();

  FlutterSecureStorage? _storage;

  Future init() async{
    _storage = const FlutterSecureStorage();
  }
  Future remove(String key)async{
    await _storage?.delete( key: key);
  }

  Future setString(String key, String value) async{
    await _storage?.write(key: key, value: value);
  }

  Future<String?> getString(String key)async{
    return _storage?.read(key: key);
  }

}

SecureStorageManager _storageManager = SecureStorageManager();