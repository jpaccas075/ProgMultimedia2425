import 'package:flutter/material.dart';

import '/constants/app_colors.dart';

// Pantalla de error. Esta pantalla mostrará un mensaje de error personalizado.
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
  });

  // Propiedad para almacenar el mensaje de error.
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
      ),
    );
  }
}
