// sidebar_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSideBarView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AdminSideBarView({required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFBF5D5D),
            ),
            child: Text(
              'Admin Panel',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          buildSidebarItem(Icons.dashboard, 'Statistics', 0),
          buildSidebarItem(Icons.people, 'Users', 1),
          buildSidebarItem(Icons.article, 'Posts', 2),
          buildSidebarItem(Icons.comment, 'Comments', 3),
        ],
      ),
    );
  }

  ListTile buildSidebarItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: selectedIndex == index ? Color(0xFFBF5D5D) : Colors.black54),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          color: selectedIndex == index ? Color(0xFFBF5D5D) : Colors.black,
        ),
      ),
      onTap: () {
        onItemSelected(index);
      },
    );
  }
}
