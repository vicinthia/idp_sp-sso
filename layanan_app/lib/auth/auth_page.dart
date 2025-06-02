// import 'package:flutter/material.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

// class AuthPage extends StatefulWidget {
//   @override
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final FlutterAppAuth appAuth = FlutterAppAuth();

//   Future<void> _login() async {
//     try {
//       final AuthorizationTokenResponse result =
//           await appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           '9bc8370e-603a-4cbf-942f-5c3ed14cf047',
//           'MAzcCLsmiA1piXvekdQGohBB0kV7RrQnaTxkF46y',
//           discoveryUrl: 'http://192.168.43.110:8000/',
//           scopes: ['openid', 'profile', 'email'],
//         ),
//       );
//       // Setelah berhasil login, Anda dapat menggunakan token akses result.accessToken
//       print('Token akses: ${result.accessToken}');
//       // Lanjutkan ke halaman beranda atau tindakan lain setelah login sukses
//     } catch (e) {
//       // Tangani kesalahan autentikasi
//       print('Kesalahan autentikasi: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SSO Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _login,
//           child: Text('Login dengan SSO'),
//         ),
//       ),
//     );
//   }
// }

