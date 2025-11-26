import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  // Key untuk Session (Login aktif)
  final String _keyIsLogin = 'is_login';
  final String _keyUserSession = 'user_session';

  // Key untuk Data Akun (Database simulasi)
  final String _keyRegUser = 'reg_username';
  final String _keyRegPass = 'reg_password';

  bool _isLoggedIn = false;
  String _username = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  // Cek status login saat aplikasi dimulai
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_keyIsLogin) ?? false;
    _username = prefs.getString(_keyUserSession) ?? '';
    notifyListeners();
  }

  // === FITUR REGISTER (Simpan Akun) ===
  Future<bool> register(String user, String pass) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Simpan username & password ke memori
      await prefs.setString(_keyRegUser, user);
      await prefs.setString(_keyRegPass, pass);
      return true; // Berhasil register
    } catch (e) {
      return false; // Gagal
    }
  }

  // === FITUR LOGIN (Validasi Akun) ===
  Future<bool> login(String inputUser, String inputPass) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Ambil data yang sudah diregister
    final String? registeredUser = prefs.getString(_keyRegUser);
    final String? registeredPass = prefs.getString(_keyRegPass);

    // Cek apakah data cocok
    if (inputUser == registeredUser && inputPass == registeredPass) {
      // Jika cocok, buat sesi login aktif
      await prefs.setBool(_keyIsLogin, true);
      await prefs.setString(_keyUserSession, inputUser);
      
      _isLoggedIn = true;
      _username = inputUser;
      notifyListeners();
      return true; // Login Sukses
    } else {
      return false; // Login Gagal (Salah password/username)
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // Hapus sesi login, TAPI JANGAN hapus data register (_keyRegUser)
    await prefs.remove(_keyIsLogin);
    await prefs.remove(_keyUserSession);
    
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }
}