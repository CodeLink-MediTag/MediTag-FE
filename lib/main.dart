import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // 날짜 포맷 라이브러리 추가
import 'package:untitled9/screen/eatmed1.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Flutter 엔진 초기화
  await initializeDateFormatting('ko_KR', null); //한국어 날짜 포맷 사용 가능하도록 설정
  runApp(const MyApp()); // ✅ MyApp 실행
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Eatmed1(),
    );
  }
}