import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{
  static const storage = FlutterSecureStorage();

  Future<void> storeFile(String key,String valueToStore) async {
    await storage.write(key: key, value: valueToStore);
  }
  Future<void> deleteFile(String key) async {
    await storage.delete(key: key);
  }

  Future<String?> retrieveFile(String valueToRead) async {
     String? data = await storage.read(key: valueToRead);
     if(data != null){
       return data;
     }
     return null;
  }
}
