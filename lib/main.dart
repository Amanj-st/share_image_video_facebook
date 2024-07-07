import 'package:automoution1/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options:const FirebaseOptions(
      apiKey: "",
      appId: "", 
      messagingSenderId: "", 
      projectId: ""
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
