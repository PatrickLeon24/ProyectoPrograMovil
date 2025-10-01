import 'package:flutter/material.dart';
//Importación de colores personalizado
import 'configs/theme.dart';
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

import 'pages/explorar_genero/explorar_genero_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(const TextTheme());
    return MaterialApp(
      title: 'WaveUL',
      // Para tema claro y oscuro
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),

      // 🔹 Aquí defines la ruta inicial (poner a /bienvenida cuando) haga commit
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

        '/explorar_genero': (context) => ExplorarGeneroPage(),
      },
    );
  }
}
