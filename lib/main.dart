import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // 외부 박스 (가로로 꽉 채우고 위쪽 선만 표시)
          Positioned(
            top: 260, // 사진 바로 아래 위치
            left: -5, // 가로로 꽉 채우기 위해 여백 없음
            right: -5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFDFDFD), // 배경색
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), // 테두리 끝 둥글게
                  topRight: Radius.circular(16), // 테두리 끝 둥글게
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // 그림자 색상
                    offset: Offset(0, 4), // 그림자 위치 (x, y)
                    blurRadius:12, // 그림자 흐림 효과
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5), // 테두리 색상
                  width: 2, // 테두리 두께
                ),
              ),
              height: 580, // 외부 박스 높이 (임의로 설정)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0), //전체적 테두리 여백
            child: Column( //Colum 위젯들을 수직으로 정렬
              crossAxisAlignment: CrossAxisAlignment.stretch, //crossAxisAlignment.stretch: 자식 위젯들이 가로 방향으로 꽉 차도록 설정
              children: [
                Row( //로고 아이콘과 텍스트를 가로로 배치
                  children: [
                    Icon(Icons.local_pharmacy, size: 24, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'MediTag',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '시각장애인을 위한 NFC 기반\nAI 대화형 챗봇 복약 관리 서비스',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12), // 텍스트와 이미지 간격
                    Align(
                      alignment: Alignment.centerRight, // 이미지를 오른쪽 정렬
                      child: Image.asset(
                        'assets/images/pill_hand.png', // 이미지 경로
                        width: 111,
                        height: 97,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCard(
                        title: '전맹이에요',
                        description:
                        '음성을 통해 처방 받은 약의 정보와\n복용 방법, 복용 빈도를 제공 받을 수 있어요!',
                        color: Color(0xFFFDFDFD),
                        borderColor: Color(0xFF4660DA),
                      ),
                      SizedBox(height: 16),
                      _buildCard(
                        title: '저시력자에요',
                        description:
                        '시각장애인을 위해 처방 받은 약의 정보와\n복용 방법을 등록해주세요!',
                        color: Color(0xFFFDFDFD),
                        borderColor: Color(0xFFECECEC),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  _buildCard(
  title: '전맹이에요',
  description: '음성을 통해 처방 받은 약의 정보와\n복용 방법, 복용 빈도를 제공 받을 수 있어요!',
  color: Color(0xFFFDFDFD),
  borderColor: Color(0xFF4660DA),
),
   */

  Widget _buildCard({
    required String title,
    required String description,
    required Color color,
    required Color borderColor, //borderColor: 카드의 테두리 색상
  }) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 180, // 카드 최소 높이 고정 높이 대신 최소 높이를 설정하고, 내용에 따라 크기를 동적으로 조정할 수도 있음
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, //카드의 제목
                    style: TextStyle(
                      fontSize: 24, //전맹이에요 폰트 사이즈
                      fontWeight: FontWeight.bold,
                      color: borderColor == Colors.transparent //텍스트 색상은 borderColor에 따라 다름 borderColor: 카드의 테두리 색상
                          ? Colors.black
                          : Color(0xFF547EE8),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description, //카드의 설명 텍스트
                    style: TextStyle(
                        fontSize: 16, //밑에 설명 글자 사이즈
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
