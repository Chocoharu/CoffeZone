import 'package:coffe_zone/pages/home.dart';
import 'package:flutter/material.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() async {
    if (_formKey.currentState!.validate()) {

      await Future.delayed(const Duration(seconds: 2));

      Navigator.of(context).push(_createRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu correo.';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, ingresa un correo válido.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: 'Coffe Zone',),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}