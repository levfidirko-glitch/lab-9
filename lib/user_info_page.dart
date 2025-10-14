import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String story;

  const UserInfoPage({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('Name', name),
            _info('Phone', phone),
            _info('Email', email),
            const SizedBox(height: 7),
            const Text('Story:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(story.isEmpty ? '-' : story),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}
