//auth_view_model
import 'package:fittrack/data/repository/auth_repository.dart';
import 'package:fittrack/models/usuario/login_usuario_model.dart';
import 'package:fittrack/utils/routes/routes_name.dart';
import 'package:fittrack/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(LoginUsuarioModel usuario, BuildContext context) async {
  setLoading(true);

  try {
    final value = await _authRepo.loginApi(usuario);

    setLoading(false);
    Utils.flushBarErrorMessage('Login successfully', context);

    if (/*Platform.isWindows && */isAdmin(value)) {
      Navigator.pushNamed(context, RoutesName.admin_panel);
    } else {
      Navigator.pushNamed(context, RoutesName.home);
    }

    if (kDebugMode) {
      print(value);
    }
  } catch (error, stackTrace) {
    setLoading(false);

    if (kDebugMode) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print("Error: $error");
    }
  }
}

  bool isAdmin(dynamic value) {
  try {
    final isAdmin = value['isAdmin'] ?? false;  
    return isAdmin;
  } catch (e) {
    print('Error al verificar si es admin: $e');
    return false;
  }
}

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _authRepo.registerApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Registration successfully', context);
      // Puedes agregar la navegación a la pantalla de inicio de sesión después del registro si lo deseas.
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print("Error: " + error.toString());
      }
    });
  }
  /*
  Future<void> checkAndRedirect(BuildContext context) async {
    try {
      // Obtener el token y la información de administrador
      String? token = await SessionManager.getToken();
      bool isAdmin = await SessionManager.isAdmin() ?? false;

      if (token != null) {
        // Si hay un token, realizar otras comprobaciones según tus necesidades
        // Por ejemplo, comprobar la condición de administrador y plataforma
        notifyListeners();
        if (!isAdmin /*&& Platform.isWindows*/) {
          // Redirigir a la ruta de administrador en el escritorio
          Future.delayed(Duration.zero, () {
            Navigator.pushNamed(context, RoutesName.adminDashboard);
          });
        } else {
          // Redirigir a la ruta predeterminada (puedes cambiar esto según tu necesidad)
          Future.delayed(Duration.zero, () {
            Navigator.pushNamed(context, RoutesName.home);
          });
          notifyListeners();
        }
      } else {
        // Si no hay token, redirigir a la pantalla de inicio de sesión
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(context, RoutesName.login);
        });
      }
    } catch (e) {
      print('Error in checkAndRedirect: $e');
      // Puedes manejar el error según tus necesidades
    }
  }
  */
}
