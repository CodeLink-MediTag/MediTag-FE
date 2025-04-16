import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/screen/main.dart';
import 'package:untitled9/screen/account.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: setting.textSize + 12,
                          fontWeight: FontWeight.bold,
                          color: colors.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 6, child: _Input()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'test12345');
  String responseText = '';

  Future<void> loginUser(BuildContext context) async {
    var url = Uri.parse('http://localhost:8080/api/auth/login');

    var headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "username": usernameController.text,
      "password": passwordController.text,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      var data = jsonDecode(response.body);
      responseText = data.toString();

      if (response.statusCode == 200) {
        String token = data['accessToken'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        await showPopupAndWait(context, "로그인 성공");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
      } else {
        await showPopupAndWait(context, "로그인 실패");
      }
    } catch (e) {
      await showPopupAndWait(context, "에러발생 $e");
    }
  }

  Future<void> showPopupAndWait(BuildContext context, String title) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('서버 반환 내용:\n$responseText'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);
    final colors = Theme.of(context).extension<MyColors>()!;

    InputDecoration baseInput(String label, IconData icon) => InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colors.text.withOpacity(0.6), fontSize: setting.textSize),
      filled: true,
      fillColor: colors.secondary,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      suffixIcon: Icon(icon, color: Colors.grey[500]),
    );

    return Container(
      child: Column(
        children: [
          Text('아이디', style: TextStyle(fontSize: setting.textSize, color: colors.text)),
          SizedBox(height: 10),
          TextField(
            controller: usernameController,
            style: TextStyle(fontSize: setting.textSize, color: colors.text),
            decoration: baseInput('ID', Icons.person),
          ),
          SizedBox(height: 30),
          Text('비밀번호', style: TextStyle(fontSize: setting.textSize, color: colors.text)),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(fontSize: setting.textSize, color: colors.text),
            decoration: baseInput('PASSWORD', Icons.lock),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => loginUser(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('로그인', style: TextStyle(fontSize: setting.textSize, color: Colors.white)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('회원가입', style: TextStyle(fontSize: setting.textSize, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
