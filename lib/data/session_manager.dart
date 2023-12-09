// session_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _tokenKey = 'token';
  static const String _isAdminKey = 'isAdmin';

  // Método para guardar el token en SharedPreferences
  static Future<void> saveToken(String token, bool isAdmin) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      await prefs.setBool(_isAdminKey, isAdmin);
      print('Token and isAdmin status saved successfully: $token, $isAdmin');
    } catch (e) {
      print('Error saving token and isAdmin status: $e');
      throw e;
    }
  }

  // Método para obtener el token almacenado
  static Future<String?> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      print('Error getting token: $e');
      throw e; // Puedes manejar el error según tus necesidades
    }
  }

  // Método para obtener el estado de administrador almacenado
  static Future<bool?> isAdmin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isAdminKey);
    } catch (e) {
      print('Error getting isAdmin status: $e');
      throw e;
    }
  }

  // Método para borrar el token almacenado
  static Future<void> clearToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      print('Token cleared successfully');
    } catch (e) {
      print('Error clearing token: $e');
      throw e; // Puedes manejar el error según tus necesidades
    }
  }

  // Método para verificar si hay una sesión activa (si hay un token almacenado)
  static Future<bool> isSessionActive() async {
    try {
      String? token = await getToken();
      return token != null;
    } catch (e) {
      print('Error checking session: $e');
      throw e; // Puedes manejar el error según tus necesidades
    }
  }
}
