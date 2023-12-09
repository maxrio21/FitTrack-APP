// admin_comments_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCommentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Comment $index', style: GoogleFonts.outfit()),
          subtitle: Text('Details of Comment $index', style: GoogleFonts.outfit()),
        );
      },
    );
  }
}