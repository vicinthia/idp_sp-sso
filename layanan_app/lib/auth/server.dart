// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as shelf_io;
// import 'package:shelf_router/shelf_router.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// const secretKey = 'your_secret_key'; // Samakan dengan yang ada di IdP

// void main() async {
//   // Buat router untuk menangani request
//   final router = Router();

//   // Endpoint untuk memverifikasi token
//   router.post('/validate_token', (Request request) async {
//     final authHeader = request.headers['Authorization'];

//     // Periksa apakah header Authorization ada dan valid
//     if (authHeader == null || !authHeader.startsWith('Bearer ')) {
//       return Response.forbidden('Token not provided');
//     }

//     final token = authHeader.substring(7);

//     try {
//       // Verifikasi token
//       final jwt = JWT.verify(token, SecretKey(secretKey));

//       // Token valid, kembalikan respons
//       return Response.ok('Token is valid');
//     } catch (e) {
//       // Token tidak valid atau error lain
//       return Response.forbidden('Token is invalid: ${e.toString()}');
//     }
//   });

//   // Pipeline untuk menambahkan middleware dan router
//   final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

//   // Jalankan server
//   await shelf_io.serve(handler, '172.20.10.3', 8080);
//   print('Server listening on port 8080');
// }
