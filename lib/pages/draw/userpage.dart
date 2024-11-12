import 'package:coffe_zone/structures/user.dart';
import 'package:flutter/material.dart';

class Userpage extends StatelessWidget {
  final User user;

  const Userpage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoCard('Nombre', user.name),
              _buildUserInfoCard('Nombre de Usuario', user.username),
              _buildUserInfoCard('Correo', user.email),
              _buildUserInfoCard(
                'Fecha de Nacimiento',
                user.birthDate.toLocal().toString().split(' ')[0],
              ),
              _buildUserInfoCard(
                'Comentario',
                user.comment.isNotEmpty ? user.comment : "N/A",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
