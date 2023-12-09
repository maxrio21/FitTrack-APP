// admin_dashboard/admin_dashboard_view.dart
import 'package:fittrack/data/session_manager.dart';
import 'package:fittrack/view/admin/admin_sidebar.dart';
import 'package:fittrack/view/admin/admin_comments/admin_comments_view.dart';
import 'package:fittrack/view/admin/admin_posts/admin_posts_view.dart';
import 'package:fittrack/view/admin/admin_statistics/admin_statistics_view.dart';
import 'package:fittrack/view/admin/admin_users/admin_users_view.dart';
import 'package:flutter/material.dart';
import 'package:fittrack/data/network/network_api_service.dart';
import 'package:fittrack/models/usuario/full_usuario_model.dart';

class AdminPanelView extends StatefulWidget {
  @override
  _AdminPanelViewState createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  int _selectedIndex = 0;
  late Future<List<FullUserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

Future<List<FullUserModel>> _fetchUsers() async {
  try {
    // Ajusta la URL según la estructura de tu API
    String url = 'http://192.168.56.1:3000/api/v1/usuarios/';
    String? token = await SessionManager.getToken();

    if (token == null) {
      throw Exception("Token is null");
    }

    final headers = {'Authorization': 'Bearer $token'};
    

    // Llama directamente a getUserListResponse para obtener la lista de usuarios
    final List<FullUserModel> userList = await NetworkApiService().getUserListResponse(url, headers);

    // Devuelve la lista obtenida
    return userList;
  } catch (e) {
    print('Error al obtener usuarios: $e');
    throw e;
  }
}





  List<Widget> _widgetOptions = [
    AdminStatisticsView(),
    AdminUsersView(users: []),
    AdminPostsView(),
    AdminCommentsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Row(
        children: [
          AdminSideBarView(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ), // Sidebar a la izquierda
          Expanded(
            child: _widgetOptions[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
