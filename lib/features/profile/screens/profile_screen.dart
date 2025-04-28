import 'package:flutter/material.dart';
import 'package:discounttour/core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/profile.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'اسم المستخدم',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('user@example.com'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('تعديل الملف الشخصي'),
            ),
          ],
        ),
      ),
    );
  }
}