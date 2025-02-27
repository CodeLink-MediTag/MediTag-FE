import 'package:flutter/material.dart';
import 'package:git_test_project/login/home_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent),  // 비활성 상태에서 테두리 색을 투명으로 설정
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF547EE8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(500, 55),
            textStyle: TextStyle(
                fontSize: 20
            ),
            foregroundColor: Colors.white
          )
        )
      ),
      home: Scaffold(
        body: SafeArea(
          top: true,
          bottom: false,
          child: Center(
            child: HomeScreen(),
          ),
        )
      ),
    );
  }
}