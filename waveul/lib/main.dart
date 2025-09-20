import 'package:flutter/material.dart';

// Importa todas tus páginas aquí
import 'pages/bienvenida/bienvenida_page.dart';
import 'pages/iniciar_sesion/iniciar_sesion_page.dart';

import 'pages/registro_usuario/registro_usuario1/registrousuario_page.dart';
import 'pages/registro_usuario/registro_usuario2/registrousuario2_page.dart';

import 'pages/registro_artista/registro_artista1/registroartista_page.dart';
import 'pages/registro_artista/registro_artista2/registroartista2_page.dart';
import 'pages/registro_artista/registro_artista3/registroartista3_page.dart';

import 'pages/recuperar_cuenta/recuperar_cuenta_1/recuperar_cuenta1_page.dart';
import 'pages/recuperar_cuenta/recuperar_cuenta_2/recuperar_cuenta2_page.dart';
import 'pages/recuperar_cuenta/recuperar_cuenta_3/recuperar_cuenta3_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaveUL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),

      // 🔹 Aquí defines la ruta inicial
      initialRoute: '/bienvenida',

      // 🔹 Aquí registras todas tus rutas
      routes: {
        '/bienvenida': (context) => BienvenidaPage(),
        '/iniciar_sesion': (context) => IniciarSesionPage(),

        '/registro_usuario1': (context) => RegistroUsuarioPage(),
        '/registro_usuario2': (context) => RegistroUsuario2Page(),
        
        '/registro_artista1': (context) => RegistroArtistaPage(),
        '/registro_artista2': (context) => RegistroArtista2Page(),
        '/registro_artista3': (context) => RegistroArtista3Page(),

        '/recuperar_cuenta_1': (context) => RecuperarCuenta1Page(),
        '/recuperar_cuenta_2': (context) => RecuperarCuenta2Page(),
        '/recuperar_cuenta_3': (context) => RecuperarCuenta3Page(),
      },
    );
  }
}
