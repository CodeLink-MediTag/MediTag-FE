import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          _TopBar(),

          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _MainView()

              )
          )

        ],
      );

  }
}

class _TopBar extends StatelessWidget{
  _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Container(
      padding: EdgeInsets.only(top: 37, bottom: 12), // 상단바 위쪽 높이 증가
      color: Color(0xFF547EE8), //상단바 컬러
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.only(left: 15),
            width: 30,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Container(
            height: 70,
            width: 200,
            child: Center(
              child: Text(
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  '시간카드 등록'
              ),
            )

          ),
          Container(
            width: 30,
            height: 20,
          )
        ],
      ),
    )

    ;
  }
}

class _MainView extends StatelessWidget{
  _MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return

    Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Select(),
          _Notice()
        ],
      ),
    )
    ;


  }
}

class _Select extends StatelessWidget{
  _Select ({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Expanded(
        child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                ElevatedButton(
                  onPressed: (){},
                  child: Text(
                      '아침'
                  ),
                ),

                SizedBox(height: 60,),

                ElevatedButton(
                  onPressed: (){},
                  child: Text(
                      '점심'
                  ),
                ),

                SizedBox(height: 60,),

                ElevatedButton(
                  onPressed: (){},
                  child: Text(
                      '저녁'
                  ),
                ),

              ],
            )
        )
    )

    ;
  }

}

class _Notice extends StatelessWidget{
  _Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Container(
        child: Text(
            style: Theme.of(context).textTheme.bodyLarge,
            '시간을 선택하고 카드를 태그해주세요'
        ),
    )

        ;
  }
}