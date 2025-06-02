import 'package:flutter/material.dart';
import 'package:layanan_app/pages/home.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset('assets/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  "Sistem Layanan\nUniversitas Bhayangkara\nSurabaya",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 1.6,
                child: Center(
                  child: Image.asset(
                    "assets/ubhara.png",
                    scale: 3.2,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          "use one of your sso profile",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // JIKA DATA TERVALIDASI
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => homePage()));
                            },
                            child: Text(
                              "SSO Internal UBHARA",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 61, 145, 255),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
