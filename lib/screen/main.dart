import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/screen/chatbot.dart';
import 'package:untitled9/screen/eatmed1.dart';
import 'package:untitled9/screen/recording.dart';
import 'package:untitled9/screen/settings.dart';





class MainScreen extends StatelessWidget {

  String tokenValue = '';




  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Column(
          children: [
            // 커스텀 앱바
            Container(
              color: Color(0xFF547EE8),
              padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: (){
                      Navigator.pop(context); // 현재 화면 종료 (이전 화면으로 돌아감)
                    },
                  ),
                  Text(
                    '메인 화면',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingScreen()),
                      );
                    },
                  )

                ],
              ),
            ),


            // 메인 콘텐츠
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10), // 챗봇 버튼 위 여백
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF547EE8),
                        fixedSize: Size(340, 322),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatBotScreen()),
                        );
                      },
                      child: Text(
                        '챗봇',
                        style: TextStyle(
                          fontSize: 62,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildButton('복용 알림/여부', (){
                      // 약 등록 후 renew페이지로 바로 돌아오기 위해서 이름을 지정해주기
                      Navigator.pushNamed(context, '/A'); // A 페이지로 이동
                    }),
                    _buildButton('주의사항 녹음', (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecordingScreen()),
                      );
                    }),
                    _buildButton('카메라 인식', (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Main()),
                      // );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  }

  Widget _buildButton(String text, Function callback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF547EE8),
          fixedSize: Size(340, 86),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          callback();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
