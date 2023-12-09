// admin_users/users_view.dart
import 'package:flutter/material.dart';
import 'package:fittrack/models/usuario/full_usuario_model.dart';

class AdminUsersView extends StatelessWidget {
  final List<FullUserModel> users;

  AdminUsersView({required this.users});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Correo')),
        DataColumn(label: Text('Admin')),
        DataColumn(label: Text('Fecha de Registro')),
        DataColumn(label: Text('Última Conexión')),
        DataColumn(label: Text('Fecha de Nacimiento')),
        // Agrega más columnas según las propiedades de tu modelo de usuario
      ],
      rows: users
          .map(
            (user) => DataRow(
              cells: [
                DataCell(Text(user.id.toString())),
                DataCell(Text(user.nombre)),
                DataCell(Text(user.email)),
                DataCell(Text(user.admin.toString())),
                DataCell(Text(user.fecha_registro)),
                DataCell(Text(user.ultima_conexion)),
                DataCell(Text(user.fecha_nac)),
                // Ajusta según las propiedades de tu modelo de usuario
              ],
              onSelectChanged: (selected) {
                // Aquí puedes manejar la selección de usuarios
                // Llama a la función onUserSelected y pasa el usuario seleccionado
                if (selected != null && selected) {
                  onUserSelected(user);
                }
              },
            ),
          )
          .toList(),
    );
  }

  // Función que maneja la selección de usuarios
  void onUserSelected(FullUserModel user) {
    // Puedes agregar aquí la lógica para manejar la selección de usuarios
    print('User selected: ${user.nombre}');
    // Puedes navegar a la vista de detalles del usuario o realizar otras acciones según sea necesario
  }
}