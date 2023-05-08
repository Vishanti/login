import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDuteTbfb4M5BUrXbsGj4qriQwXS6W3T7c';

  // Crea la instancia de Storage
  final storage = const FlutterSecureStorage();

  //**
  // Metodo que permite crear un usuario en Firebase
  // */
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Guardar el token en el storage
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  //**
  // Metodo que permite hacer login en Firebase
  // */
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
    if (decodedResp.containsKey('idToken')) {
      // Guardar el token en el storage
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  //**
  // Metodo que permites cerrar sesión
  // */
  Future logout() async {
    // Delete value
    await storage.delete(key: 'token');
    return;
  }

  //**
  // Metodo que permites leer el "Secure Storage"
  // */
  Future<String> readToken() async {
    // Read value
    String value = await storage.read(key: 'token') ?? '';
    return value;
  }
}
