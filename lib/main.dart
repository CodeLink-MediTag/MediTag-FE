import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_test_project/CardRegistration/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700]
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF547EE8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(500, 80),
                textStyle: TextStyle(
                    fontSize: 30
                ),
                foregroundColor: Colors.white
            )
        )
      ),
      home: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false ,
          child: Center(
            child: HomeScreen(),
          )
        ),
      ),
    );
  }
}