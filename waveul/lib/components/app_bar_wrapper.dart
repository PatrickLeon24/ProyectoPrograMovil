import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWrapper extends StatelessWidget {
  final Widget child;
  final Color? statusBarColor;
  final Brightness? iconBrightness;

  const AppBarWrapper({
    super.key,
    required this.child,
    this.statusBarColor,
    this.iconBrightness,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? const Color.fromARGB(255, 67, 167, 174), // #1DF2FF simulado con 45% opacidad
        statusBarIconBrightness: iconBrightness ?? Brightness.light, // Iconos blancos
        statusBarBrightness: Brightness.dark, // Para iOS
      ),
      child: child,
    );
  }
}