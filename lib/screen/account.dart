import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController(text: 'test@gmail.com');
  final TextEditingController nameController = TextEditingController(text: 'test');
  final TextEditingController phoneController = TextEditingController(text: '010-1234-5678');
  final TextEditingController passwordController = TextEditingController(text: 'test12345');

  String responseText = '';

  Future<void> registration(BuildContext context) async {
    var url = Uri.parse('http://localhost:8080/api/member/register');
    var headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "username": usernameController.text,
      "name": nameController.text,
      "phone": phoneController.text,
      "password": passwordController.text
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      var data = jsonDecode(response.body);
      responseText = data.toString();
      if (response.statusCode == 200) {
        await showPopupAndWait(context, "회원가입 성공");
        Navigator.pop(context);
      } else {
        await showPopupAndWait(context, "회원가입 실패");
      }
    } catch (e) {
      await showPopupAndWait(context, "에러: $e");
    }
  }

  Future<void> showPopupAndWait(BuildContext context, String title) async {
    final setting = Provider.of<SettingState>(context, listen: false);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontSize: setting.textSize)),
          content: Text('서버 반환 내용:\n$responseText', style: TextStyle(fontSize: setting.textSize)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인', style: TextStyle(fontSize: setting.textSize)),
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

    return Scaffold(
      backgroundColor: colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '회원가입',
                style: TextStyle(
                  fontSize: setting.textSize + 6,
                  fontWeight: FontWeight.bold,
                  color: colors.text,
                ),
              ),
            ),
            SizedBox(height: 30),
            _buildInputField('아이디', '아이디 입력', usernameController, setting, colors),
            _buildInputField('이름', '이름 입력', nameController, setting, colors),
            _buildInputField('전화번호', '010-0000-0000', phoneController, setting, colors),
            _buildInputField('비밀번호', '비밀번호', passwordController, setting, colors, isPassword: true),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => registration(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: setting.textSize, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, SettingState setting, MyColors colors, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: setting.textSize - 2, fontWeight: FontWeight.w500, color: colors.text),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isPassword,
            style: TextStyle(fontSize: setting.textSize, color: colors.text),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: setting.textSize, color: Colors.grey),
              filled: true,
              fillColor: colors.secondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
