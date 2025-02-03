import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Padding(
      padding: EdgeInsets.only(left: 13, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Title(),
          _Input()
        ],
      ),
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
        // color: Colors.green[100],
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
        // color: Colors.blue[100],
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
              onPressed: (){},
              child: Text(
                '로그인',
                // style: TextStyle(color: Colors.white),
              )
            ),

            SizedBox(height: 20,),

            // 회원가입 버튼
            ElevatedButton(
                onPressed: (){},
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