import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilProvider extends ChangeNotifier {
  static const String _nomeKey = 'perfil_nome';
  static const String _emailKey = 'perfil_email';
  static const String _senhaKey = 'perfil_senha';
  static const String _preferenciasKey = 'perfil_preferencias';

  String _nome = 'Mariany Freitas';
  String _email = 'mary@gmail.com';
  String _senha = '';
  final Set<String> _preferencias = {};

  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;
  Set<String> get preferencias => Set.unmodifiable(_preferencias);

  PerfilProvider() {
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    _nome = prefs.getString(_nomeKey) ?? 'Mariany Freitas';
    _email = prefs.getString(_emailKey) ?? 'mary@gmail.com';
    _senha = prefs.getString(_senhaKey) ?? '';
    final preferenciasSalvas = prefs.getStringList(_preferenciasKey) ?? [];
    _preferencias.addAll(preferenciasSalvas);
    notifyListeners();
  }

  Future<void> salvarDados({
    required String nome,
    required String email,
    required String senha,
    required Set<String> preferencias,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nomeKey, nome);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_senhaKey, senha);
    await prefs.setStringList(_preferenciasKey, preferencias.toList());

    _nome = nome;
    _email = email;
    _senha = senha;
    _preferencias
      ..clear()
      ..addAll(preferencias);
    notifyListeners();
  }

  Future<void> limparDados() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nomeKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_senhaKey);
    await prefs.remove(_preferenciasKey);

    _nome = 'Mariany Freitas';
    _email = 'mary@gmail.com';
    _senha = '';
    _preferencias.clear();
    notifyListeners();
  }
}
