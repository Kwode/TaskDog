import 'package:flutter/material.dart';

class ConfirmationTiles extends StatelessWidget {
  const ConfirmationTiles({super.key, required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Color.fromRGBO(30, 58, 138, 1.0),), 
        title: Text(title), 
        subtitle: Text(subtitle), 
      ),
    );
  }
}
