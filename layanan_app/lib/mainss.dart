import 'package:flutter/material.dart';
import 'package:layanan_app/pages/home.dart';
import 'package:layanan_app/pages/pagar.dart';

import 'package:layanan_app/ui_login/loginPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Launch App or Web'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               openAppOrWebIfNeeded();
//             },
//             child: Text('Launch App or Web'),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> openAppOrWebIfNeeded() async {
//     String appScheme = "com.example.idp_app"; // URI scheme dari aplikasi target
//     String webUrl =
//         "http://0331kebonagung.ikc.co.id"; // URL untuk membuka di web browser

//     // Cek apakah aplikasi target terpasang
//     bool isAppInstalled = await canLaunch(appScheme);

//     if (isAppInstalled) {
//       // Jika terpasang, buka aplikasi target
//       launch(appScheme);
//     } else {
//       // Jika tidak terpasang, buka web browser
//       launch(webUrl);
//     }
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMainScreen();
  }

  _loadMainScreen() async {
    await Future.delayed(Duration(seconds: 6)); // Tunda selama 3 detik

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/logo.png")));

    //   Center(
    // child: _isLoading
    //     ? CircularProgressIndicator() // Tampilkan indikator loading jika isLoading true
    //     : Image.asset(
    //         'assets/logo.png'), // Tampilkan gambar splash screen jika isLoading false
  }
}

// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SPLandingScreen(),
//     );
//   }
// }

// class SPLandingScreen extends StatefulWidget {
//   @override
//   _SPLandingScreenState createState() => _SPLandingScreenState();
// }

// class _SPLandingScreenState extends State<SPLandingScreen> {
//   StreamSubscription? _sub;

//   @override
//   void initState() {
//     super.initState();
//     _initDeepLinkListener();
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }

//   void _initDeepLinkListener() {
//     _sub = uriLinkStream.listen((Uri? uri) {
//       if (uri != null && uri.queryParameters.containsKey('token')) {
//         final token = uri.queryParameters['token'];
//         _handleJWT(token);
//       }
//     });
//   }

//   void _handleJWT(String? token) {
//     // Simpan JWT di secure storage atau shared preferences
//     print('Received JWT: $token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SP App'),
//       ),
//       body: Center(
//         child: Text('Waiting for JWT... '),
//       ),
//     );
//   }
// }




































   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
