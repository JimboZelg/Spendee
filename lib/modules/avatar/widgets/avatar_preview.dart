import 'package:flutter/material.dart';

class AvatarPreview extends StatelessWidget {
  final Map<String, dynamic> avatarData;

  const AvatarPreview({super.key, required this.avatarData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(75),
      ),
      child: const Center(
        child: Text(
          'Avatar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}