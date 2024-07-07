import 'package:flutter/material.dart';

class ThemedCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  const ThemedCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: textColor),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(fontSize: 24, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
