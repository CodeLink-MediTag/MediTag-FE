import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/screen/chatbot.dart';
import 'package:untitled9/screen/eatmed1.dart';
import 'package:untitled9/screen/recording.dart';
import 'package:untitled9/screen/settings.dart';





class MainScreen extends StatelessWidget {

  String tokenValue = '';


  Future<void> showPopupAndWait(BuildContext context) async {

    //토큰 가져오는 로직
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenValue = prefs.getString('token')?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('현재 토큰: ${tokenValue}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 확인 누르면 dialog 닫히고 함수가 다시 이어짐
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );

    // 이 아래 코드는 팝업이 닫힌 후 실행됨
    print('사용자가 확인을 눌렀습니다!');
    // 여기에 다음 로직을 이어서 작성하면 됩니다
  }

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

              SizedBox(height: 4,),
              // 토큰 확인 버튼 (임시)
              ElevatedButton(
                onPressed: (){
                  showPopupAndWait(context);
                },
                child: Text("토큰 확인")
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Eatmed1()),
                        );
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
