import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  bool notifications = true;
  bool sound = true;
  bool vibration = true;
  bool showNotifications = false;
  double textSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6), // 연한 회색 배경
      body: Column(
        children: [
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 32, bottom: 16), // 상단바 위쪽 높이 증가
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Center(
                  child: Text(
                    '환경설정',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF6F6F6), // 연한 회색 배경
              child: Column(
                children: [
                  _buildSettingTile('알림', Switch(
                    value: notifications,
                    onChanged: (value) {
                      setState(() => notifications = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),
                  _buildSettingTile('소리', Switch(
                    value: sound,
                    onChanged: (value) {
                      setState(() => sound = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),
                  _buildNavigationButton('알림음', () {}),
                  _buildDivider(),
                  _buildSettingTile('진동', Switch(
                    value: vibration,
                    onChanged: (value) {
                      setState(() => vibration = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Color(0xFFFDFDFD), // 글자 크기 바탕색
                    child: Column(
                      children: [
                        Text(
                          '글자 크기',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Slider(
                          value: textSize,
                          min: 10,
                          max: 24,
                          divisions: 7,
                          label: textSize.toString(),
                          onChanged: (value) {
                            setState(() => textSize = value);
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildDivider(),
                  _buildSettingTile('알림 표시', Switch(
                    value: showNotifications,
                    onChanged: (value) {
                      setState(() => showNotifications = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),
                  _buildNavigationButton('NFC 등록', () {}),
                  _buildDivider(),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20), // 로그아웃 버튼 아래 여백 추가
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF547EE8),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, Widget trailing) {
    return Container(
      color: Color(0xFFFDFDFD), // 설정 항목 배경 흰색
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400), // 알림, 소리, 진동, 알림표시 글씨
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _buildNavigationButton(String title, VoidCallback onPressed) {
    return Container(
      color: Color(0xFFFDFDFD), // 설정 항목 배경 흰색
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20), // 버튼 대신 아이콘
        onTap: onPressed, // 아이콘 클릭 시 이동
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2,
      color: Color(0xFFDADADA),
    );
  }
}
