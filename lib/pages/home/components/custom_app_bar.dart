import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  final double horizontalPadding = 20;
  final double verticalPadding = 30;
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, 
        vertical: verticalPadding
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu,
            size: iconSize,
          ),
          
          Icon(
            Icons.person,
            size: iconSize,
            color: Colors.grey[800],
          )
        ],
      ),
    );
  }
}