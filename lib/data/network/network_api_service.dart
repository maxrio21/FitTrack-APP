//NetworkApiService
import 'dart:convert';
import 'dart:io';

import 'package:fittrack/data/app_exceptions.dart';
import 'package:fittrack/data/network/base_api_services.dart';
import 'package:fittrack/data/session_manager.dart';
import 'package:fittrack/models/usuario/full_usuario_model.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = response;
    } catch (error) {
      print('Error en getPostApiResponse: $error');
      throw error;
    }

    return responseJson;
  }

@override
Future<List<FullUserModel>> getUserListResponse(
  String url, Map<String, String> headers) async {
  try {
    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(Duration(seconds: 10));
    dynamic responseJson = returnResponse(response);

    List<FullUserModel> userList = [];

    if (responseJson != null) {
      if (responseJson is List<dynamic>) {
        // Si la respuesta es una lista, utiliza el método estático listFromJson
        userList = FullUserModel.listFromJson(responseJson);
      } else if (responseJson is Map<String, dynamic>) {
        // Si la respuesta es un objeto individual, crea una instancia de FullUserModel
        userList.add(FullUserModel.fromJson(responseJson));
      } else {
        throw ArgumentError('Invalid JSON format for FullUserModel');
      }

      // Si es necesario imprimir algo, aquí puedes hacerlo
      if (userList.isNotEmpty) {
        print("El correo del usuario es: " + userList[0].email);
      }
    }

    return userList;
  } catch (error) {
    print('Error en getUsersList: $error');
    throw error;
  }
}

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
      }).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } catch (e) {
      throw e;
    }
    return responseJson;
  }

  Future registerApi(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } catch (e) {
      print('Llego el error en NetworkApiService: $e');

      // Nuevo bloque para imprimir detalles del error
      if (e is http.Response) {
        print('Status Code: ${e.statusCode}');
        print('Response Body: ${e.body}');
      }

      throw e;
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    try {
      print('Código de estado de la respuesta: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
      dynamic responseJson = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return responseJson;
        case 400:
          throw BadRequestException("");
        case 401:
        case 404:
        case 500:
          throw UnauthorizedException("");
        default:
          throw FetchDataException(response.body.toString());
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
