import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // 날짜 포맷 라이브러리 추가
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:untitled9/screen/login.dart'; // 로그인 페이지 가져오기

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Flutter 엔진 초기화
  await initializeDateFormatting('ko_KR', null); // ✅ 한국어 날짜 포맷 사용 가능하도록 설정
  KakaoSdk.init(
    nativeAppKey: '0294f90ad4d3deac240d0065da6d5c5f',
  );
  runApp(const MyApp()); // ✅ MyApp 실행
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(), // ✅ 로그인 화면이 첫 화면
    );
  }
}

