import 'package:flutter/material.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Dec 23 2024'),
          Text('Title'),
          Text('Description'),
          Text('12:30'),
        ],
      ),
    );
  }
}
