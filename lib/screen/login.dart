import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/screen/main.dart';
import 'package:untitled9/screen/account.dart';

class Login extends StatelessWidget{

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, // 전체 배경 흰색

          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.transparent),  // 비활성 상태에서 테두리 색을 투명으로 설정
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF547EE8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: Size(double.infinity, 50),

                  textStyle: TextStyle(
                      fontSize: 20
                  ),
                  foregroundColor: Colors.white
              )
          )
      ),
      home: Scaffold(
          body: SafeArea(
            top: true,
            bottom: false,
            child: Center(
              child: HomeScreen(),
            ),
          )
      ),
    );
  }
}


class HomeScreen extends StatelessWidget{
  HomeScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        // padding: EdgeInsets.only(left: 13, right: 13),
          padding: const EdgeInsets.all(16.0),
          child:
          Container(
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                _Input()
              ],
            ),
          )

      )
    ;
  }
}

class _Title extends StatelessWidget{
  _Title({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
          flex: 3,
          child: Container(
            height: 100,
            child: Column(
              children: [

                SizedBox(height: 40,),

                Text(
                  style: Theme.of(context).textTheme.headlineLarge,
                  '로그인',
                ),
              ],
            ),
          )
      )
    ;
  }
}

class _Input extends StatelessWidget{
  final TextEditingController usernameController = TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'test12345');



  _Input({Key? key}): super(key: key);


  // 일반 로그인
  Future<void> loginUser(BuildContext context) async {

    // 서버 반환값
    String responseText = '';

    var url = Uri.parse('http://localhost:8080/api/auth/login');

    var headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "username": usernameController.text,
      "password": passwordController.text,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {

        // 서버에서 받은 토큰
        var data = jsonDecode(response.body);
        String token = data['accessToken'];



        responseText = data.toString();

        await showPopupAndWait(context, "로그인 성공", responseText);



        // SharedPreferences에 토큰 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);





        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );



      } else {
        var data = jsonDecode(response.body);
        responseText = data.toString();
        await showPopupAndWait(context, "로그인 실패", responseText);

      }
    } catch (e, stackTrace) {

      await showPopupAndWait(context, "에러발생 $e", responseText);

    }


  }

  // 팝업 알림창
  Future<void> showPopupAndWait(BuildContext context, String title, String content) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('내용:\n$content'),
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

  // 카톡 로그인
  Future<void> _loginWithKakao(BuildContext context) async {
    // 로그인상태
    String loginStatus = "로그인 전";

    try {
      bool isInstalled = await isKakaoTalkInstalled(); // 카카오톡 설치 여부 확인
      OAuthToken token;

      if (isInstalled) {
        token = await UserApi.instance.loginWithKakaoTalk();
        print('✅ 카카오톡으로 로그인 성공: ${token.accessToken}');
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
        print('✅ 카카오 계정으로 로그인 성공: ${token.accessToken}');
      }

      // ✅ 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      print('🔹 닉네임: ${user.kakaoAccount?.profile?.nickname}');
      print('🔹 이메일: ${user.kakaoAccount?.email}');
      print('🔹 프로필 사진: ${user.kakaoAccount?.profile?.profileImageUrl}');
      print('🔹 성별: ${user.kakaoAccount?.gender}');
      print('🔹 연령대: ${user.kakaoAccount?.ageRange}');


      loginStatus = """
        로그인 성공!
        닉네임: ${user.kakaoAccount?.profile?.nickname}
        이메일: ${user.kakaoAccount?.email}
      """;


    } catch (error) {
      print('❌ 로그인 실패: $error');
      loginStatus = "로그인 실패: $error";
    }

    // 로그인 결과 팝업으로 띄우기
    showPopupAndWait(context, "로그인결과", loginStatus);
  }

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        flex: 7,
        child: Container(
          height: 100,
          child: Column(
            children: [

              Text(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  '아이디'
              ),

              SizedBox(height: 10,),

              // 아이디 입력칸
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'ID',
                    suffixIcon: Icon(
                      Icons.person,
                      color: Colors.grey[500],
                    )
                ),
              ),

              SizedBox(height: 30,),

              Text(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  '비밀번호'
              ),

              SizedBox(height: 10,),

              // 비밀번호 입력칸
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey[500],
                    )
                ),
              ),

              SizedBox(height: 50,),

              // 로그인 버튼
              ElevatedButton(
                  onPressed: (){
                    loginUser(context);
                    // test();
                  },
                  child: Text(
                    '로그인',
                  )
              ),

              SizedBox(height: 20,),

              // 회원가입 버튼
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    '회원가입',
                    // style: TextStyle(color: Colors.white),
                  )
              ),

              SizedBox(height: 20,),

              // 카카오 로그인
              ElevatedButton(
                  onPressed: (){
                    _loginWithKakao(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow
                  ),
                  child: Text(
                    '카카오 로그인',
                    style: TextStyle(color: Colors.brown),
                  )
              )


            ],
          ),
        ),
      )
    ;

  }
}