import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:layanan_app/mahasiswa/fiturSim/sim_class.dart';
import 'package:layanan_app/model/simMhs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:http/http.dart' as http;

import '../api/link_sp.dart';

var selectedService = 0;

class simMhs extends StatefulWidget {
  final status;
  simMhs({this.status});

  @override
  State<simMhs> createState() => _simMhsState();
}

class _simMhsState extends State<simMhs> {
  @override
  void initState() {
    super.initState();
    _loadReceivedData();
    _initUniLinks();
  }

  bool _dataProcessed = false;
  Map<String, dynamic> payload;

  Future<void> _loadReceivedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _receivedData = prefs.getString('receivedData') ?? "No data";
    });

    if (_receivedData != "No data" && !JwtDecoder.isExpired(_receivedData)) {
      await _decodeToken();
      await addDataUserSIM();
      await getDataSIM();
    }
  }

  String _receivedData = "No data";
  String _userId = "No user";
  void _decodeToken() async {
    // Pastikan bahwa _receivedData memiliki nilai valid sebelum melanjutkan
    if (_receivedData != "No data") {
      try {
        final parts = _receivedData.split(".");
        assert(parts.length == 3, "Token tidak valid");

        final payloadPart = parts[1];
        final normalized = base64Url.normalize(payloadPart);
        final decodedBytes = base64Url.decode(normalized);
        final decodedString = utf8.decode(decodedBytes);

        setState(() {
          payload = jsonDecode(decodedString) as Map<String, dynamic>;
          _dataProcessed = true;
        });

        print(
            'Decoded payload: $payload'); // Anda bisa menghapus ini setelah debugging
      } catch (e) {
        // Tangani kesalahan decoding di sini
        print('Error decoding token: $e');
        setState(() {
          _dataProcessed = false;
        });
      }
    } else {
      setState(() {
        _dataProcessed = false;
      });
    }
  }

  Future<void> _initUniLinks() async {
    try {
      // Handle initial link
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      }
      // Handle incoming links
      linkStream.listen((String link) {
        if (link != null) {
          _handleIncomingLink(link);
        }
      });
    } on Exception {
      // Handle exception
    }
  }

  void _handleIncomingLink(String link) {
    final uri = Uri.parse(link);
    final data = uri.queryParameters['data'] ?? 'No data';

    setState(() {
      _receivedData = data;

      // _saveReceivedData(data);
      _decodeToken();
    });
  }

  Future<void> addDataUserSIM() async {
    var response = await http.get(
      Uri.parse(AksesSIM.UrlSim_Sp + 'api/VerifyToken/verify_token/'),
      headers: {"Authorization": "$_receivedData"},
    );

    if (response.statusCode == 200) {
      // Handle success, e.g., store any needed data from the response
      print("Token SP: $_receivedData");
    } else {
      // Handle error, maybe throw an exception or set an error state
      print("Error verifying token: ${response.statusCode}");
    }
  }

  String userDetailsText = 'Loading...';
  String userIdSim;

  Future<void> getDataSIM() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null) {
      setState(() {
        userDetailsText = 'Error: Email not found';
      });
      return;
    }

    try {
      final response = await http.get(
          Uri.parse(AksesSIM.UrlSim_Sp + "api/DataSIM/index?email=$email"));

      if (response.statusCode == 200) {
        final userData = json.decode(response.body)['data'];
        setState(() {
          userDetailsText =
              userData.isNotEmpty ? userData[0]['name'] : 'No user data found';
          userIdSim =
              userData.isNotEmpty ? userData[0]['id'] : 'No user data found';
          prefs.setString('setUserIdSim', userIdSim);
          print("Tangkep" + userIdSim);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        userDetailsText = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              _greetings(),
              SizedBox(
                height: 17,
              ),
              _card(),
              SizedBox(
                height: 20,
              ),
              // _services(),
              SizedBox(
                height: 22,
              ),
              _menuItem(),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _menuItem() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => _menuItems(menuItem[index], context),
        separatorBuilder: (context, index) => SizedBox(
              height: 11,
            ),
        itemCount: menuItem.length);
  }

  GestureDetector _menuItems(simMhsModel simmhsModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (simmhsModel.nama) {
          case "E-Learning":
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SimClass(
                      userIdSim: userIdSim, userNameSim: userDetailsText)),
            );
            break;
          default:
        }
      },
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF35385A).withOpacity(.12),
                    blurRadius: 30,
                    offset: Offset(0, 2))
              ]),
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                'assets/menuImage/${simmhsModel.image}',
                width: 110,
                height: 110,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    simmhsModel.nama,
                    style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F3E3F)),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Layanan: ${simmhsModel.ket}",
                          style: GoogleFonts.manrope(
                              fontSize: 16, color: Colors.black))),
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 38,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Text(
                          "Click to more",
                          style: GoogleFonts.manrope(
                              color: Color(0xFF50CC98),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Spacer(),
                        SvgPicture.asset('assets/svgs/pencil.svg')
                      ],
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }

  // SizedBox _services() {
  //   return SizedBox(
  //     height: 36,
  //     child: ListView.separated(
  //         padding: EdgeInsets.symmetric(horizontal: 28),
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) => Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               decoration: BoxDecoration(
  //                   color: selectedService == index
  //                       ? Colors.blue
  //                       : Color(0xFFF6F6F6),
  //                   border: selectedService == index
  //                       ? Border.all(
  //                           color: Color(0xFFF1E5E5).withOpacity(.22), width: 2)
  //                       : null,
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Center(
  //                   child: Text(
  //                 Service.all()[index],
  //                 style: GoogleFonts.manrope(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.bold,
  //                     color: selectedService == index
  //                         ? Colors.white
  //                         : Color(0xFF3F3E3F).withOpacity(.3)),
  //               )),
  //             ),
  //         separatorBuilder: (context, index) => SizedBox(
  //               width: 10,
  //             ),
  //         itemCount: Service.all().length),
  //   );
  // }

  AspectRatio _card() {
    double screenWidth = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          color: Colors.blue,
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/layananImage/mhs_sim.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Aplikasi ",
                          style: GoogleFonts.manrope(
                              fontSize: screenWidth * 0.05,
                              color: Colors.white,
                              height: 150 / 100),
                          children: [
                        TextSpan(
                            text: "Sistem Informasi Manajemen ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                        TextSpan(
                            text:
                                "Akademik\nPenyedia layanan kegiatan administrasi\nakademik kampus online")
                      ])),
                  SizedBox(
                    height: screenWidth * 0.05, // Jarak yang proporsional
                  ),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.025),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.4),
                        border: Border.all(
                            color: Colors.white.withOpacity(.12), width: 2),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025)),
                    child: Text("Status : AKTIF",
                        style: GoogleFonts.manrope(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _greetings() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            userDetailsText.isNotEmpty
                ? 'SIM, $userDetailsText!'
                : 'Loading data...',
            style: GoogleFonts.manrope(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3F3E3F)),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FeatherIcons.shield,
                    color: Colors.green,
                  )),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  height: screenWidth * 0.04, // Ukuran dinamis
                  width: screenWidth * 0.04,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Center(
                    child:
                        // Text("V")
                        Icon(FeatherIcons.check,
                            color: Colors.white, size: screenWidth * 0.03),
                  ),
                ),
              )
            ],
          )
        ],
      ),

      //  FutureBuilder(
      //   future: http.read(
      //     Uri.parse(AksesSIM.UrlSim_Sp + 'api/ValidateSP/validate_token/'),
      //     headers: {"Authorization": "${_receivedData}"},
      //   ),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text("An error occurred: ${snapshot.error}");
      //     } else if (snapshot.hasData) {
      //       return Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             'SIM, ${userDetailsText}!',
      //             style: GoogleFonts.manrope(
      //                 fontSize: screenWidth * 0.05,
      //                 fontWeight: FontWeight.w800,
      //                 color: Color(0xFF3F3E3F)),
      //           ),
      //           Stack(
      //             children: [
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: Icon(
      //                     FeatherIcons.shield,
      //                     color: Colors.green,
      //                   )),
      //               Positioned(
      //                 right: 4,
      //                 top: 4,
      //                 child: Container(
      //                   height: screenWidth * 0.04, // Ukuran dinamis
      //                   width: screenWidth * 0.04,
      //                   decoration: BoxDecoration(
      //                     color: Colors.red,
      //                     borderRadius:
      //                         BorderRadius.circular(screenWidth * 0.02),
      //                   ),
      //                   child: Center(
      //                     child:
      //                         // Text("V")
      //                         Icon(FeatherIcons.check,
      //                             color: Colors.white,
      //                             size: screenWidth * 0.03),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           )
      //         ],
      //       );
      //     } else {
      //       return Text("No data found");
      //     }
      //   },
      // ),
    );
  }
}
