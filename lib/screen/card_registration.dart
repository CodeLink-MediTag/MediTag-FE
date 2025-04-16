import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';

class CardRegistration extends StatelessWidget {
  const CardRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: setting.textSize,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF547EE8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(500, 80),
            textStyle: TextStyle(
              fontSize: setting.textSize + 10,
            ),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      child: const Scaffold(
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        )
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return Container(
      padding: const EdgeInsets.only(top: 37, bottom: 12),
      color: const Color(0xFF547EE8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(
            width: 200,
            child: Center(
              child: Text(
                '시간카드 등록',
                style: TextStyle(
                  fontSize: setting.textSize + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 수정된 부분
      children: const [
        _Select(),
        _Notice(),
      ],
    );
  }
}

class _Select extends StatelessWidget {
  const _Select({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('아침'),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {},
            child: Text('점심'),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {},
            child: Text('저녁'),
          ),
        ],
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '시간을 선택하고 카드를 태그해주세요',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
