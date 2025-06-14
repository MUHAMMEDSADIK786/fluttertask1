import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Interceptor extends StatelessWidget {
  final Widget child;

  const Interceptor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      
    }

    return child;
  }
}




