import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  static Future<void> sendEmail(String name, String email, String feedback) async {
    final Email sendEmail = Email(
      body: 'Nombre: $name\nCorreo: $email\n\nRetroalimentación:\n$feedback',
      subject: 'Retroalimentación de la Aplicación',
      recipients: ['achocobarbel@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(sendEmail);
  }
}
