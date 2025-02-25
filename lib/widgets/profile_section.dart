import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';

class ProfileSection extends StatelessWidget {
  final User user;

  const ProfileSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.picture),
          ),
          const SizedBox(width: 16),
          Text(
            user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
