import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class AlertSound extends StatefulWidget {
  @override
  _AlertSoundPageState createState() => _AlertSoundPageState();
}

class _AlertSoundPageState extends State<AlertSound> {
  String selectedSound = "";

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
                    '알림음',
                    style: TextStyle(
                      fontSize: setting.textSize + 6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildSoundTile('알림음1', setting.textSize, colors),
          _buildDivider(colors),
          _buildSoundTile('알림음2', setting.textSize, colors),
          _buildDivider(colors),
          _buildSoundTile('알림음3', setting.textSize, colors),
        ],
      ),
    );
  }

  Widget _buildSoundTile(String soundName, double fontSize, MyColors colors) {
    return Container(
      color: colors.card,
      child: ListTile(
        title: Text(
          soundName,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400, color: colors.text),
        ),
        trailing: Checkbox(
          value: selectedSound == soundName,
          onChanged: (value) {
            setState(() => selectedSound = value! ? soundName : "");
          },
          activeColor: Color(0xFF61B781),
        ),
      ),
    );
  }

  Widget _buildDivider(MyColors colors) {
    return Container(
      height: 2,
      color: colors.divider,
      width: double.infinity,
    );
  }
}
