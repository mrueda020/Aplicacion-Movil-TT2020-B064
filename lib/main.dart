import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkex/inicio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Actualizacion 31-08-2021 Login sencillo con request http y Dashboard
//Para iniciar sesion se introduce nombre y password del evaluado

//Proximo Update, Login con api Laravel

void main() => runApp(MyApp());

String username = '';

class SplashPage extends StatelessWidget {
  int duration = 2;

  @override
  Widget build(BuildContext context) {
    onGoBack(dynamic value) {
      Navigator.of(context).pop(true);
      SystemNavigator.pop();
    }

    Future.delayed(Duration(seconds: duration), () {
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.push(context, route).then(onGoBack);
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Color(0xFFFFFFFF),
        //color: Color(0xFF82E2FF),
        child: Image.asset(
          'assets/images/splash.jpg',
          width: 256,
          height: 256,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    /*SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top],
    );*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LinkEX',
      home: new LoginPage(),
      //home: new SplashPage(),
      routes: <String, WidgetBuilder>{},
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';
  bool logged = false;

  onGoBack(dynamic value) {
    _onBackPressed();
  }

  Future<bool> _onBackPressed() {
    SystemNavigator.pop();
  }

  Future<bool> _onBackPressed2() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              "Usuario o contraseña incorrecta",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.indigo[50],
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.indigo[50],
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
                //color: Colors.green,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Container circularProgress() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0),
      child: CircularProgressIndicator(
        strokeWidth: 5.0,
        valueColor:
            AlwaysStoppedAnimation(Colors.blueAccent), //any color you want
      ),
    );
  }

  Container loadingScreen() {
    return circularProgress();
  }

  Future login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      //_onBackPressed2();
      logged = true;
      // msg = "Usuario o Contraseña incorrecta";
    });
    print(pass.text);
    print(user.text);
    var url = Uri.parse('http://10.0.2.2:8000/api/Login');
    final response = await http.post(url, body: {
      "email": user.text,
      "password": pass.text,
    });
    print(response.body);

    var texto = '';
    // loadingScreen();

    var datauser = response.body;
    sharedPreferences.setString("token", datauser);

    if (datauser.length == 0) {
      setState(() {
        _onBackPressed2();
        logged = false;
        // msg = "Usuario o Contraseña incorrecta";
      });
    } else {
      Route route = MaterialPageRoute(
          builder: (context) => Inicio(
              //id: datauser[0]['idEvaluado'],
              //name: datauser[0]['Nombre'],
              //username: datauser[0]['ApPaterno'],
              //image: datauser[0]['Email'],
              ));
      Navigator.push(context, route).then(onGoBack);

      setState(() {});
    }

    return texto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //onWillPop: _onBackPressed,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigoAccent[400],
                //Colors.lightBlue[100],
                Color(0xff008FFF)
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 36.0, horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenido",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Inicia Sesión",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Botones Usuario, Password y Entrar
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 25,
                                  offset: Offset(0, 5),
                                  spreadRadius: -25,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextField(
                              //obscureText: true,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000912),
                              ),
                              controller: user,
                              enabled: logged ? false : true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 25),
                                hintText: 'Usuario',
                                hintStyle: TextStyle(
                                  color: Color(0xffA6B0BD),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.blue[600]),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 75,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 25,
                                  offset: Offset(0, 5),
                                  spreadRadius: -25,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextField(
                              obscureText: true,
                              enabled: logged ? false : true,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000912),
                              ),
                              controller: pass,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 25),
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(
                                  color: Color(0xffA6B0BD),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.blue[600]),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 75,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: logged ? 100 : double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: logged
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xff008FFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x60008FFF),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: FlatButton(
                              onPressed: () => {
                                //login();
                                logged ? logged = true : login() //;
                              },
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: logged
                                  ? circularProgress()
                                  : Text(
                                      "ENTRAR",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: logged
                                            ? Colors.indigoAccent
                                            : Colors.white,
                                        letterSpacing: 3,
                                      ),
                                    ),
                            ),
                          ),
                          Text(
                            msg,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black12,
                                  offset: Offset(3.0, 3.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
