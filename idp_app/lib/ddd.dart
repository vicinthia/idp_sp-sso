import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idp_app/auth/login_page.dart';

import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/pages/mahasiswa.dart';
import 'package:idp_app/registrasi/regis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    cekMyExp: _prefs.getString('myVlds'),
  ));

  // Workmanager().initialize(callbackDispatcher);
}

class MyApp extends StatefulWidget {
  final cekMyExp;

  final validToken;

  final exp;
  final begintoken;
  MyApp({this.validToken, this.exp, this.begintoken, this.cekMyExp});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> _checkToken() async {
    final storage = FlutterSecureStorage();
    // Future<String> attemptLogIn(String username, String password) async {
    //   var res = await http.post(
    //       Uri.parse("http://172.20.10.3/server/kebonagung/ssoauth/tokens"),
    //       body: {"email": username, "password": password});
    //   if (res.statusCode == 200) return res.body;
    //   final storage = FlutterSecureStorage();

    //   return res.body;
    // }

    // String cekNama = await storage.read(key: 'namaKey') ?? "";
    // String cekPass = await storage.read(key: 'passKey') ?? "";
    // var jwt = await attemptLogIn(cekNama, cekPass);
    // if (jwt != null) {
    //   storage.write(key: "jwt", value: jwt);
    //   print("Token" + jwt);
    //   setState(() async {
    //     await checkValid();
    //   });
    // }
    // String jwts = await storage.read(key: 'jwt') ?? "";

    String token = GlobalData.getMyToken();
    String level = GlobalData.getMyLevel();
    String validTokenx = await GlobalData.getMyExp();
    // String stringOfItems = await storage.read(key: 'jwt');
    // print("storegae" + stringOfItems);
    String cekRespon = await storage.read(key: 'status') ?? "";

    print("Respon" + cekRespon);

    print("hasil" + validTokenx);
    print("tkn" + token);
    if (cekRespon == "true") {
      return mahasiswaPage();
    } else {
      return loginPage();
    }
  }

  int _pollingInterval = 60000; // 60 seconds

  void startRealTimeValidation() {
    final storage = FlutterSecureStorage();
    Timer.periodic(Duration(milliseconds: _pollingInterval), (timer) async {
      final prefs = await SharedPreferences.getInstance();
      String jwts = await storage.read(key: 'jwt') ?? "";
      final jwtss = prefs.getString(jwts);
      // if (jwtss != null) {
      //   await checkValid();
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // startRealTimeValidation();
  }

  @override
  Widget build(BuildContext context) {
    String token = GlobalData.getMyToken();
    String validTokenx = GlobalData.getMyExp();
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'SSO IdP',
      // routes: {
      //   '/': (context) => loginPage(), // Route '/' mengarah ke HomePage
      //   // Route '/detail/:id' mengarah ke DetailPage dengan parameter id
      // },

      // home: FutureBuilder<Widget>(
      //   future: _checkToken(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else {
      //       return snapshot.data ?? loginPage();
      //     }
      //   },
      // ),
      home: (widget.cekMyExp) == "true" ? mahasiswaPage() : loginPage(),
    );
  }
}

// import 'package:flutter/material.dart';

// String ubahCiphertext(String ciphertext, int kunci) {
//   // Inisialisasi array untuk menampung baris-baris ciphertext
//   List<String> arrayBaris = List.filled(kunci, '');

//   // Inisialisasi variabel untuk menentukan apakah kita sedang bergerak ke bawah atau ke atas
//   bool turun = true;
//   int barisSekarang = 0;

//   // Menyusun ciphertext menjadi pola zig-zag
//   for (int i = 0; i < ciphertext.length; i++) {
//     arrayBaris[barisSekarang] += ciphertext[i];
//     if (barisSekarang == 0) {
//       turun = true;
//     } else if (barisSekarang == kunci - 1) {
//       turun = false;
//     }
//     if (turun) {
//       barisSekarang++;
//     } else {
//       barisSekarang--;
//     }
//   }

//   // Menggabungkan setiap baris menjadi chipertext baru
//   String chipertextBaru = '';
//   for (int i = 0; i < arrayBaris.length; i++) {
//     chipertextBaru += arrayBaris[i];
//   }

//   return chipertextBaru;
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chipertext Zig-Zag',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Chipertext Zig-Zag'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Ciphertext: Tsmohh ep eptedaa rix iXmns',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Panggil fungsi untuk mengubah ciphertext menjadi chipertext dengan kunci 3
//                   String chipertextBaru = ubahCiphertext(')U?LEW?', 3);
//                   print('Chipertext baru: $chipertextBaru');
//                 },
//                 child: Text('Ubah ke Chipertext Baru'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// String ubahCiphertext(String ciphertext, int kunci) {
//   List<String> arrayBaris = List.filled(
//       kunci, ''); // Inisialisasi array untuk menampung baris-baris ciphertext
//   bool turun =
//       true; // Inisialisasi variabel untuk menentukan apakah kita sedang bergerak ke bawah atau ke atas
//   int barisSekarang = 0;

//   // Menyusun ciphertext menjadi pola zig-zag
//   for (int i = 0; i < ciphertext.length; i++) {
//     arrayBaris[barisSekarang] +=
//         ciphertext[i]; // Menambahkan karakter ke baris saat ini
//     if (barisSekarang == 0) {
//       turun = true;
//     } else if (barisSekarang == kunci - 1) {
//       turun = false;
//     }
//     if (turun) {
//       barisSekarang++;
//     } else {
//       barisSekarang--;
//     }
//   }

//   // Mengambil karakter dari setiap baris sesuai jumlah karakter di baris tersebut
//   String chipertextBaru = '';
//   for (int i = 0; i < arrayBaris.length; i++) {
//     chipertextBaru += arrayBaris[i];
//   }

//   return chipertextBaru;
// }

// void main() {
//   String ciphertext = ')U?LEW?'; // Ciphertext yang diberikan
//   int kunci = 3; // Key yang digunakan

//   // Panggil fungsi untuk mengubah ciphertext menjadi chipertext dengan kunci 3
//   String chipertextBaru = ubahCiphertext(ciphertext, kunci);
//   print('Chipertext baru: $chipertextBaru'); // Output: E)WLU??
// }

// import 'package:flutter/material.dart';

// String enkripsi(String plaintext, int kunci) {
//   String ciphertext = '';
//   for (int i = 0; i < plaintext.length; i++) {
//     // Mendapatkan kode ASCII asli dari karakter
//     int kode_ascii_asli = plaintext.codeUnitAt(i);
//     // Mengenkripsi kode ASCII dengan menggunakan kunci (dengan modulus 93 untuk loop)
//     int enkripsi = (kode_ascii_asli + kunci) % 93;
//     // Mengembalikan karakter terenkripsi dari enkripsi
//     String karakter_terenkripsi = String.fromCharCode(33 + enkripsi);
//     // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
//     ciphertext += karakter_terenkripsi;
//   }
//   return ciphertext;
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Enkripsi Text',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Enkripsi Text'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Masukkan plaintext',
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implementasi tombol enkripsi di sini
//                   String plaintext = 'Kwangya';
//                   int kunci = 119;
//                   String teks_terenkripsi = enkripsi(plaintext, kunci);
//                   print('Plaintext: $plaintext');
//                   print('Chipertext: $teks_terenkripsi');
//                 },
//                 child: Text('Enkripsi'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// String decrypt(String ciphertext, int key) {
//   List<List<String>> grid = List.generate(key, (_) => []);

//   // Inisialisasi variabel
//   int row = 0;
//   bool down = true;

//   // Menghitung jumlah karakter yang akan diisi dalam masing-masing baris grid
//   List<int> rowCount = List.filled(key, 0);
//   for (int i = 0; i < ciphertext.length; i++) {
//     rowCount[row]++;
//     if (down) {
//       row++;
//       if (row == key - 1) {
//         down = false;
//       }
//     } else {
//       row--;
//       if (row == 0) {
//         down = true;
//       }
//     }
//   }

//   // Mengisi grid sesuai pola zig-zag untuk dekripsi
//   int index = 0;
//   for (int i = 0; i < key; i++) {
//     for (int j = 0; j < rowCount[i]; j++) {
//       grid[i].add('');
//       grid[i][grid[i].length - 1] = ciphertext[index];
//       index++;
//     }
//   }

//   // Membaca karakter dari grid secara zig-zag untuk menghasilkan teks terdekripsi
//   String decryptedText = '';
//   row = 0;
//   down = true;
//   for (int i = 0; i < ciphertext.length; i++) {
//     decryptedText += grid[row][0];
//     grid[row].removeAt(0);

//     if (down) {
//       row++;
//       if (row == key - 1) {
//         down = false;
//       }
//     } else {
//       row--;
//       if (row == 0) {
//         down = true;
//       }
//     }
//   }
//   return decryptedText;
// }

// void main() {
//   String ciphertext2 = ")EULW??";
//   int key = 3;

//   String decryptedText = decrypt(ciphertext2, key);
//   print("Ciphertext 2: $ciphertext2");
//   print("Decrypted Text: $decryptedText");
// }

// import 'package:flutter/material.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String token;

//   // Fungsi untuk menghasilkan token
//   String generateToken() {
//     const secretKey = 'your_secret_key';

//     final jwt = JWT(
//       {
//         'id': 1,
//         'username': 'testuser',
//         'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
//         'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) +
//             (60 * 60), // Token berlaku selama 1 jam
//       },
//     );

//     final token = jwt.sign(SecretKey(secretKey));
//     return token;
//   }

//   // Fungsi untuk mengirim token ke SP
//   Future<void> sendTokenToSP(String token) async {
//     final response = await http.post(
//       Uri.parse('http://0331kebonagung.ikc.co.id/validate_token'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       print('Token is valid');
//     } else {
//       print('Token is invalid');
//     }
//   }

//   // Handler untuk tombol
//   void handleGenerateAndSendToken() {
//     setState(() {
//       token = generateToken();
//     });

//     if (token != null) {
//       sendTokenToSP(token);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SSO IdP Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (token != null) Text('Generated Token: $token'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: handleGenerateAndSendToken,
//               child: Text('Generate and Send Token'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EmailValidationForm(),
//     );
//   }
// }

// class EmailValidationForm extends StatefulWidget {
//   @override
//   _EmailValidationFormState createState() => _EmailValidationFormState();
// }

// class _EmailValidationFormState extends State<EmailValidationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();

//   Future<void> checkEmailAvailability() async {
//     final response = await http.post(
//       Uri.parse('http://0331kebonagung.ikc.co.id/api/emailvalid/check_email/'),
//       body: {'email': _emailController.text},
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       print('respon :' + response.statusCode.toString());
//       print(responseData['status']);
//       if (responseData['status'] == false) {
//         _showEmailRegisteredDialog();
//       } else {
//         _showEmailAvailableDialog();
//       }
//     } else {
//       _showErrorDialog();
//     }
//   }

//   void _showEmailRegisteredDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Email Unavailable'),
//           content: Text(
//               'Email is already registered. Please use a different email.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEmailAvailableDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Email Available'),
//           content: Text('Email is available.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(
//               'Unable to check email availability. Please try again later.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Validation Form'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter an email.';
//                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Format email tidak valid';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState.validate()) {
//                     checkEmailAvailability();
//                   }
//                 },
//                 child: Text('Check Email Availability'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:idp_app/localstorage/bio_user.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GlobalDatas {
//   static String getMyToken() {
//     // Kode untuk mendapatkan token Anda
//     return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTcxMjMzOTQsImV4cCI6MTcxNzEyMzY5NCwiZGF0YSI6eyJpZCI6IjIiLCJlbWFpbCI6InZpY2luQGdtYWlsLmNvbSIsImxldmVsIjoic3RhZmYifX0.FBkRm4IgUkr2muPByWqaxpyuZECopjXpvy1eoPbtPK4";
//   }

//   static Future<void> setMyValidToken(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("MyValidToken", value);
//   }

//   static Future<String> getMyValidToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("MyValidToken");
//   }
// }

// Future<void> checkValid(BuildContext context) async {
//   String token = GlobalDatas.getMyToken();

//   final response = await http.get(
//     Uri.parse(
//         'http://192.168.43.110/server/kebonagung/ssoauth/decode_token/${token}'),
//     // headers: {"Authorization": "Bearer $token"},
//   );

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     print('Response status: ${response.statusCode}');
//     print('Response data: ${responseData}');
//     if (responseData['status'] == false) {
//       print('Error: ${responseData['status']}');
//       await GlobalData.setMyExp("false");
//       // Navigator.of(context)
//       //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
//     } else {
//       await GlobalData.setMyExp("true");
//     }
//   } else {
//     print('Error: ${response.reasonPhrase}');
//     await GlobalData.setMyExp("false");
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   String validToken = await GlobalData.getMyExp();

//   print("token sebelumnya" + validToken);
//   runApp(MyApp(validToken: validToken));
// }

// class MyApp extends StatefulWidget {
//   final String validToken;

//   MyApp({this.validToken});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     checkValid(context);
//     return MaterialApp(
//       home: widget.validToken != "true" ? LoginPage() : HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Center(
//         child: Text("Welcome to the Home Page!"),
//       ),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page"),
//       ),
//       body: Center(
//         child: Text("Please login to continue."),
//       ),
//     );
//   }
// }
