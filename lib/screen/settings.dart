// settings.dart - Provider 기반 전역 설정 적용된 SettingScreen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/setting_state.dart';
import 'alert_sound.dart';
import 'card_registration.dart';
import 'my_colors.dart';

class SettingScreen extends StatelessWidget {
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
            padding: EdgeInsets.only(top: 37, bottom: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
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
              color: colors.background,
              child: Column(
                children: [
                  _buildSwitchTile('알림', setting.notifications, (v) => setting.updateBoolSetting('notifications', v), setting.textSize, colors),
                  _buildDivider(colors),
                  _buildSwitchTile('소리', setting.sound, (v) => setting.updateBoolSetting('sound', v), setting.textSize, colors),
                  _buildDivider(colors),
                  _buildNavigationButton('알림음', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AlertSound()));
                  }, setting.textSize, colors),
                  _buildDivider(colors),
                  _buildSwitchTile('진동', setting.vibration, (v) => setting.updateBoolSetting('vibration', v), setting.textSize, colors),
                  _buildDivider(colors),

                  // ✅ 다크 모드 스위치 추가
                  _buildSwitchTile('다크 모드', setting.isDarkMode, setting.toggleDarkMode, setting.textSize, colors),
                  _buildDivider(colors),

                  Container(
                    padding: EdgeInsets.all(16),
                    color: colors.card,
                    child: Column(
                      children: [
                        Text('글자 크기', style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.w400)),
                        Slider(
                          value: setting.textSize,
                          min: 10,
                          max: 24,
                          divisions: 7,
                          label: setting.textSize.toStringAsFixed(0),
                          onChanged: setting.setTextSize,
                        ),
                      ],
                    ),
                  ),
                  _buildDivider(colors),
                  _buildSwitchTile('알림 표시', setting.showNotifications, (v) => setting.updateBoolSetting('showNotifications', v), setting.textSize, colors),
                  _buildDivider(colors),
                  _buildNavigationButton('NFC 등록', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CardRegistration()));
                  }, setting.textSize, colors),
                  _buildDivider(colors),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        minimumSize: Size(358, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.w400, color: Colors.white),
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

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged, double fontSize, MyColors colors) {
    return Container(
      color: colors.card,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String title, VoidCallback onPressed, double fontSize, MyColors colors) {
    return Container(
      color: colors.card,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildDivider(MyColors colors) {
    return Container(
      height: 2,
      color: colors.divider,
    );
  }
}
