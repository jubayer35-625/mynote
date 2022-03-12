
import 'package:flutter/material.dart';

void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
  scaffoldState!.currentState!.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
          const Icon(Icons.access_alarms_outlined)
        ],
      ),
    ),
  );
}