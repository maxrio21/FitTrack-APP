//auth_repository
/*
import 'dart:convert';

import 'package:fittrack/data/network/base_api_services.dart';
import 'package:fittrack/data/network/network_api_service.dart';
import 'package:fittrack/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.registerApi(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
*/

import 'dart:convert';

import 'package:fittrack/data/network/base_api_services.dart';
import 'package:fittrack/data/network/network_api_service.dart';
import 'package:fittrack/data/session_manager.dart'; // Importa la clase SessionManager
import 'package:fittrack/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Método para realizar el inicio de sesión
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);

      // Si el inicio de sesión es exitoso, guarda el token y el estado de administrador
      String token = response['token'];
      bool isAdmin = response['isAdmin'] ?? false; // Puedes ajustar esto según la estructura de tu respuesta

      if (token != null) {
        await SessionManager.saveToken(token, isAdmin);
      }

      return response;
    } catch (e) {
      throw e;
    }
  }

  // Método para realizar el registro
  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.registerApi(AppUrl.registerEndPoint, data);

      // Si el registro es exitoso, guarda el token
      /*
      if (response['status'] == 'success' && response['data'] != null) {
        String token = response['data']['token'];
        await SessionManager.saveToken(token);
      }*/

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      // Aquí puedes realizar cualquier lógica necesaria para cerrar la sesión
      // Por ejemplo, hacer llamadas a la API para invalidar el token en el servidor.

      // Luego, borra el token almacenado
      await SessionManager.clearToken();
    } catch (e) {
      // Maneja cualquier error que pueda ocurrir durante el proceso de cierre de sesión
      print('Error during logout: $e');
      throw e; // Puedes elegir manejar el error según tus necesidades
    }
  }
}
