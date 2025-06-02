// import 'dart:convert';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:http/http.dart' as http;

// class LoginBloc extends BlocBase {
//   LoginBloc();

//   final stream = BehaviorSubject<Map<String, dynamic>>();

//   void doLogin(Map params) async {
//     var url = await http
//         .post(Uri.parse("http://0331kebonagung.ikc.co.id/api/admin/mylogin"),
//             body: jsonEncode(params))
//         .then(
//       (value) {
//         Map<String, dynamic> dataResponse = jsonDecode(value.body);
//         stream.add(dataResponse);
//         // print(value.body);
//       },
//     ).catchError((onError) {
//       print(onError);
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     stream.close();
//   }
// }



