import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineRegistrationScreen(),
    );
  }
}

class MedicineRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 아이콘과 텍스트 수직 중앙 정렬
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상 흰색
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40), // 오른쪽 여백
              ],
            ),
          ),

          // 나머지 화면
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30), // 여백 조정
                  Text(
                    "약의 이름과 특징을 입력해 주세요!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30), // 여백 추가

                  // 이름 등록
                  Text("이름 등록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "이름을 지어주세요! 예) 처방약, 비타민B",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // 특징 등록
                  Text("특징 등록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "특징을 등록해 주세요! 예) 동그란 통, 사각 통",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),

                  Spacer(), // 버튼을 아래로 밀어줌

                  // 버튼들
                  Column(
                    children: [
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF547EE8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "처방약 등록",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF547EE8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "다음",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // 마지막 여백 추가
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
