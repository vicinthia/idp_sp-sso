// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class jwtPage extends StatelessWidget {
//   jwtPage(this.jwt, this.payload);

//   factory jwtPage.fromBase64(String jwt) => jwtPage(
//       jwt,
//       json.decode(
//           ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

//   final String jwt;
//   final Map<String, dynamic> payload;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(title: Text("Secret Data Screen")),
//       body: Center(
//         child: FutureBuilder(
//             future: http.read(
//                 Uri.parse(
//                     'http://172.20.10.3/server/kebonagung/ssoauth/validate_token/'),
//                 headers: {"Authorization": jwt}),
//             builder: (context, snapshot) => snapshot.hasData
//                 ? Column(
//                     children: <Widget>[
//                       Text("${payload['username']}, here's the data:"),
//                       Text(snapshot.data.toString(),
//                           style: Theme.of(context).textTheme.headline4)
//                     ],
//                   )
//                 : snapshot.hasError
//                     ? Text("An error occurred")
//                     : CircularProgressIndicator()),
//       ));
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JwtPage extends StatelessWidget {
  JwtPage(this.jwt, this.payload);

  factory JwtPage.fromBase64(String jwt) {
    // Dekode payload dari JWT
    final parts = jwt.split(".");
    assert(parts.length == 3);

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decodedBytes = base64Url.decode(normalized);
    final decodedString = utf8.decode(decodedBytes);

    return JwtPage(jwt, json.decode(decodedString));
  }

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Center(
        child: FutureBuilder(
          future: http.read(
            Uri.parse(
                'http://172.20.10.3/server/kebonagung/ssoauth/validate_token/'),
            headers: {"Authorization": jwt},
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("An error occurred: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "${payload['data']['email'] ?? 'Unknown user'}, here's the data:"),
                    Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
}
