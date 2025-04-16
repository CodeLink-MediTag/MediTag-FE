import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/screen/chatbot.dart';
import 'package:untitled9/screen/eatmed1.dart';
import 'package:untitled9/screen/recording.dart';
import 'package:untitled9/screen/settings.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class MainScreen extends StatelessWidget {
  String tokenValue = '';

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          Container(
            color: colors.primary,
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  '메인 화면',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: setting.textSize + 6,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
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
                        fontSize: setting.textSize + 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildButton('복용 알림/여부', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Eatmed1()),
                    );
                  }, setting.textSize + 12, colors),
                  _buildButton('주의사항 녹음', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordingScreen()),
                    );
                  }, setting.textSize + 12, colors),
                  _buildButton('카메라 인식', () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Main()),
                    // );
                  }, setting.textSize + 12, colors),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Function callback, double fontSize, MyColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
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
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
