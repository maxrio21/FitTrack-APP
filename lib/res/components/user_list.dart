// widgets/user_list.dart
import 'package:flutter/material.dart';
import 'package:fittrack/models/usuario/user_model.dart';

class UserList extends StatelessWidget {
  final List<UserModel> users;
  final Function(UserModel) onDelete;
  final Function(UserModel) onEdit;

  UserList({
    required this.users,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onDelete(user),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => onEdit(user),
              ),
            ],
          ),
        );
      },
    );
  }
}
