import 'package:shared_preferences/shared_preferences.dart';

/// Kelas ini digunakan sebagai model untuk menyimpan data log in user.
/// Untuk melakukan pembacaan atau penulisan ke dalam device,
/// ada beberapa langkah yang harus dilakukan
///
/// Contoh penggunaan
/// ```dart
/// void InstansiasiDataProfil() async {
///   // Mengambil data profil dari storage
///   var profil = await SecureProfile.getStorage();
///
///   // Membaca data
///   profil.getLoggedInStatus(); // Boolean
///   profil.getApiKey(); // String or null
///   profil.getUserId(); // int or null
///
///   // Menulis data
///   await profil.setLoggedIn(20, "secret_api_key_token");
///   await profil.setLoggedOut();
/// }
/// ```
class SecureProfile {
  final SharedPreferences storage;

  bool isLoggedIn;
  int? userId;
  String? apiKey, name;

  SecureProfile(
      {required this.storage,
      required this.isLoggedIn,
      this.userId,
      this.apiKey,
      this.name});

  static Future<SecureProfile> getStorage() async {
    var storage = await SharedPreferences.getInstance();
    var userId = storage.getInt("user_id");
    var apiKey = storage.getString("api_key");
    var name = storage.getString("user_name");

    bool loggedIn = false;
    if (userId != null && apiKey != null && name != null) {
      loggedIn = true;
    }

    return SecureProfile(
        storage: storage,
        isLoggedIn: loggedIn,
        apiKey: apiKey,
        userId: userId,
        name: name);
  }

  bool getLoggedInStatus() {
    return isLoggedIn;
  }

  String? getApiKey() {
    return apiKey;
  }

  int? getUserId() {
    return userId;
  }

  String? getUserName() {
    return name;
  }

  Future<void> setLoggedIn(int userId, String apiKey, String name) async {
    await storage.setInt("user_id", userId);
    await storage.setString("api_key", apiKey);
    await storage.setString("user_name", name);
    isLoggedIn = true;
  }

  Future<void> setLoggedOut() async {
    await storage.remove("api_key");
    await storage.remove("user_id");
    await storage.remove("user_name");
    isLoggedIn = false;
  }
}
