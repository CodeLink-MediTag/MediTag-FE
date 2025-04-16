import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _MainView(),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return Container(
      padding: EdgeInsets.only(top: 37, bottom: 12),
      color: Color(0xFF547EE8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
            width: 200,
            child: Center(
              child: Text(
                '주의사항 등록',
                style: TextStyle(
                  fontSize: setting.textSize + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<_MainView> {
  late Widget content;
  bool mode = true;

  @override
  void initState() {
    super.initState();
    content = Recording(onPressed: SwitchMode);
  }

  void SwitchMode() {
    setState(() {
      mode = !mode;
      content = mode
          ? Recording(onPressed: SwitchMode)
          : RecordingStart(onPressed: SwitchMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: content,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF547EE8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: Size(double.infinity, 50),
              textStyle: TextStyle(fontSize: setting.textSize),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Text('모든 녹음파일'),
          ),
        ],
      ),
    );
  }
}

class Recording extends StatelessWidget {
  final VoidCallback onPressed;

  Recording({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent[100],
          border: Border.all(color: Colors.blueAccent, width: 5),
        ),
        child: Center(
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: Icon(
              Icons.mic,
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class RecordingStart extends StatelessWidget {
  final VoidCallback onPressed;

  RecordingStart({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent[100],
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 100,
            width: 200,
            child: Center(
              child: Text(
                '00:00:01',
                style: TextStyle(
                  fontSize: setting.textSize + 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                '2024.3.28\n오후 04:26 녹음',
                style: TextStyle(
                  fontSize: setting.textSize + 4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 80),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF547EE8),
                    ),
                    child: Center(
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: setting.textSize,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF547EE8),
                  ),
                  child: Icon(
                    Icons.pause,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF547EE8),
                  ),
                  child: Icon(
                    Icons.stop,
                    size: 40,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}