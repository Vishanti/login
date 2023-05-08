import 'package:flutter/material.dart';

class NotificacionsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //*
  // Metodo estatico que permite recibir un mensaje para mostrar un "SnackBar"
  // */
  static showSnackbar(String message) {
    final snackBar = SnackBar(
        content: Center(
      child: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
