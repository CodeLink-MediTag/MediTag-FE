import 'package:flutter/material.dart';
import 'package:untitled9/screen/main.dart';
import 'package:untitled9/screen/account.dart';


class Login extends StatelessWidget {
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
          flex: 4,
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
  _Input({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        flex: 6,
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
                decoration: InputDecoration(
                    labelText: 'ID',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
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
              )


            ],
          ),
        ),
      )
    ;

  }
}