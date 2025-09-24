// lib/shared/mixins/loader_mixin.dart
import 'package:flutter/material.dart';

mixin LoaderMixin<T extends StatefulWidget> on State<T> {
  void showLoader(bool isLoading) {
    if (isLoading) {
      showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
