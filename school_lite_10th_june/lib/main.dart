// ignore_for_file: unused_local_variable, dead_code, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:school_lite_10th_june/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:username_validator/username_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Desk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        splash: Column(
          children: [
            Center(child: Image.asset('assets/logoanimation.png',height: 120,)),

          ],
        ),
        backgroundColor: Colors.amber,
        nextScreen: const MyLoginPage(),
        splashIconSize: 250,
        duration: 3000,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
      ),
    );
    
  }
}



enum ButtonState { init, loading, done }

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  ButtonState state = ButtonState.init;
  bool isLoading = true;
  bool isHiddenPassword = true;

  final UserNameController = TextEditingController();
  final PasswordController = TextEditingController();

  var SerialNumber;
  var HostName;
  var HostMAC;
  var LoginProvider;
  var ProviderKey;
  var NotificationToken;
  var LocalIP;
  var LastSeen;
  var PublicIP;
  var SessionHostId;

  void login(
    String UserName,
    String Password,
    SerialNumber,
    HostName,
    HostMAC,
    LoginProvider,
    SessionHostId,
    ProviderKey,
    LastSeen,
    PublicIP,
    LocalIP,
    NotificationToken,
  ) async {
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response response = await post(
      Uri.parse('https://mtestsd.rbkei.in/api/CreateTokan'),
      body: {
        'UserName': UserName,
        'Password': Password,
        'SerialNumber': SerialNumber,
        'HostName': HostName,
        'HostMAC': HostMAC,
        'LoginProvider': LoginProvider,
        'ProviderKey': ProviderKey,
        'LastSeen': LastSeen,
        'PublicIP': PublicIP,
        'LocalIP': LocalIP,
        'NotificationToken': NotificationToken,
      },
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        sharedPreferences.setString("Data", jsonData['fullName'] );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      } 
      );
    }
     else {
      print(response.body);
    }
  }

  bool? newuser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    UserNameController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDone = state == ButtonState.done;
    final isStretched = state == ButtonState.init;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.amber,
        systemNavigationBarDividerColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 50.0,
                    ),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                            width: 30,
                          ),
                          Image.asset(
                            'assets/bee.png',
                            height: 80.0,
                            width: 120.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'SCHOOL DESK',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, letterSpacing: 5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 27),
                        decoration: const BoxDecoration(),
                        child:
                            ////////////////////////////////////////email//////////////////////////////////////////////////
                            TextFormField(
                          controller: UserNameController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.email],
                          cursorColor: Color.fromARGB(255, 255, 204, 0),
                          decoration: InputDecoration(
                            labelText: 'Your E-mail',
                            hintText: 'abc@gmail.com',
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27),
                                borderSide: BorderSide(color: Colors.black45)),
                          ),
                          validator: (value){
                            if (!UValidator.validateThis(username: value!)){
                              return 'Invalid username';
                            }
                            return null;
                          },
                        ),
                      ),
                      ///////////////////////////////////password////////////////////////////////////////////
                      Container(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 27),
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          controller: PasswordController,
                          keyboardType: TextInputType.phone,
                          cursorColor: Color.fromARGB(255, 255, 204, 0),
                          obscureText: isHiddenPassword,
                          decoration: InputDecoration(
                            hoverColor: Color.fromARGB(255, 255, 204, 0),
                            labelText: 'Password:',
                            hintText: '****',
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility)),
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle:
                                TextStyle(color: Colors.black45, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27),
                                borderSide: BorderSide(color: Colors.black45)),
                          ),
                          validator: MinLengthValidator(3,
                              errorText: "At least 3 Character"),
                        ),
                      ),

                      ////////////////////////////////login///////////////////////////////////////
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(32),
                        child: Container(
                          width: 400,
                          height: 53,
                          child: isStretched
                              ? buildButton()
                              : buildSmallButton(isDone),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          maximumSize: Size.fromHeight(40),
        ),
        onPressed: () async {
          login(
              UserNameController.text.toString(),
              PasswordController.text.toString(),
              SerialNumber.toString(),
              HostName.toString(),
              HostMAC.toString(),
              LoginProvider.toString(),
              SessionHostId.toString(),
              ProviderKey.toString(),
              LastSeen.toString(),
              PublicIP.toString(),
              LocalIP.toString(),
              NotificationToken.toString());

          setState(() => state = ButtonState.loading);
          await Future.delayed(Duration(seconds: 3));
          setState(() => state = ButtonState.done);
          await Future.delayed(Duration(seconds: 3));
          setState(() => state = ButtonState.init);
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
  Widget buildSmallButton(bool isDone) {
    final color = isDone ? Colors.green : Colors.amber;

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      child: Center(
        child: isDone
            ? Icon(
                Icons.done,
                size: 32,
                color: Colors.white,
              )
            : CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
