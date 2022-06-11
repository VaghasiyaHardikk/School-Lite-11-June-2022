import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:school_lite_10th_june/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences login;
  String? Data;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    login = await SharedPreferences.getInstance();
    setState(() {
      Data = login.getString('Data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/schooldesk.png',
          height: 35,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                login.setBool('Data', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => MyLoginPage()));
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: 
      Column(
   children: <Widget>[
      Container(
        height: 100,
        width: 500,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: <Widget> [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Center(child: Text('fullName - $Data',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)),
                ) ,
              )
            ],),
          ),
        ),
      ),
      Expanded(
        child: Container(
           height: 1000,
          width: 500,
          color: Colors.white,
          child: Column(
            children: [
            Expanded(child: WebView(initialUrl: 'https://test.rbkei.org/Employees/GetEmployeeProfile?IsProfile=True',))
            ],
          ),
        ),
      ),
   ],
)
      // Container(
      //   height: 200,
      //   width: 500,
      //   color: Colors.grey,
      // ),
      
      // Padding(
        
      //   padding: const EdgeInsets.all(26.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         SingleChildScrollView(
      //           child: Center(
                  
      //             child: Text(
      //               '$data',
      //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
       );
      
    
  }
}
