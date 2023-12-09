//routes
import 'package:fittrack/utils/routes/routes_name.dart';
import 'package:fittrack/view/admin/admin_dashboard_view.dart';
import 'package:fittrack/view/home/home_view.dart';
import 'package:fittrack/view/login/login_view.dart';
import 'package:fittrack/view/register/register_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());
      case RoutesName.admin_panel:
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminPanelView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No hay ruta definida"),
            ),
          );
        });
    }
  }
}
