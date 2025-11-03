import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waveul/models/user.dart';
import 'package:waveul/models/token.dart';

/// Servicio para gestionar la sesión del usuario en Waveul.
/// Guarda el usuario, los tokens y el estado de login usando SharedPreferences.
class SessionService {
  // Singleton: una única instancia de la clase
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  static SharedPreferences? _prefs;

  // Claves para almacenamiento local
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'token_data';
  static const String _isLoggedInKey = 'is_logged_in';

  /// Inicializa SharedPreferences (debe llamarse en main antes de usar el servicio)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Guarda el usuario actual
  Future<bool> saveUser(User user) async {
    try {
      final userJson = user.toJson();
      return await _prefs!.setString(_userKey, json.encode(userJson));
    } catch (e) {
      print('⚠️ Error guardando usuario: $e');
      return false;
    }
  }

  /// Obtiene el usuario guardado (si existe)
  User? getUser() {
    try {
      final userString = _prefs!.getString(_userKey);
      if (userString != null) {
        final userMap = json.decode(userString) as Map<String, dynamic>;
        return User.fromJson(userMap);
      }
      return null;
    } catch (e) {
      print('⚠️ Error obteniendo usuario: $e');
      return null;
    }
  }

  /// Guarda los tokens de autenticación
  Future<bool> saveToken(Token token) async {
    try {
      final tokenJson = token.toJson();
      return await _prefs!.setString(_tokenKey, json.encode(tokenJson));
    } catch (e) {
      print('⚠️ Error guardando token: $e');
      return false;
    }
  }

  /// Obtiene los tokens guardados (si existen)
  Token? getToken() {
    try {
      final tokenString = _prefs!.getString(_tokenKey);
      if (tokenString != null) {
        final tokenMap = json.decode(tokenString) as Map<String, dynamic>;
        return Token.fromJson(tokenMap);
      }
      return null;
    } catch (e) {
      print('⚠️ Error obteniendo token: $e');
      return null;
    }
  }

  /// Guarda el estado de login (true = logueado)
  Future<bool> setLoggedIn(bool isLoggedIn) async {
    return await _prefs!.setBool(_isLoggedInKey, isLoggedIn);
  }

  /// Verifica si hay sesión iniciada
  bool isLoggedIn() {
    return _prefs!.getBool(_isLoggedInKey) ?? false;
  }

  /// Guarda usuario, token y marca como logueado
  Future<bool> saveAuthData(User user, Token token) async {
    try {
      final userSaved = await saveUser(user);
      final tokenSaved = await saveToken(token);
      final loginSaved = await setLoggedIn(true);
      return userSaved && tokenSaved && loginSaved;
    } catch (e) {
      print('⚠️ Error guardando datos de sesión: $e');
      return false;
    }
  }

  /// Limpia toda la información de sesión (logout)
  Future<bool> clearAll() async {
    try {
      final userRemoved = await _prefs!.remove(_userKey);
      final tokenRemoved = await _prefs!.remove(_tokenKey);
      final loginRemoved = await _prefs!.remove(_isLoggedInKey);
      return userRemoved && tokenRemoved && loginRemoved;
    } catch (e) {
      print('⚠️ Error limpiando sesión: $e');
      return false;
    }
  }

  /// Verifica si existen datos guardados de sesión
  bool hasAuthData() {
    return getUser() != null && getToken() != null;
  }

  @override
  String toString() {
    final user = getUser();
    final token = getToken();
    final isLoggedIn = this.isLoggedIn();

    return '''
SessionService{
  isLoggedIn: $isLoggedIn,
  hasAuthData: ${hasAuthData()},
  user: ${user?.toString() ?? 'null'},
  token: ${token?.toString() ?? 'null'}
}''';
  }
}
