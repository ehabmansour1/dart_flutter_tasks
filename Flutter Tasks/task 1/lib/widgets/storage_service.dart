import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _storage = FlutterSecureStorage();
  static const _keySelectedItem = "selected_item";
  static Future<void> saveSelectedItem(String item) async {
    await _storage.write(key: _keySelectedItem, value: item);
    print("✅ Secure Storage Updated: $item");
  }

  static Future<String?> getSelectedItem() async {
    String? value = await _storage.read(key: _keySelectedItem);
    print("🔹 Secure Storage Retrieved: $value");
    return value;
  }

  static Future<void> clearStorage() async {
    await _storage.deleteAll();
    print("🗑 Secure Storage Cleared");
  }
}
