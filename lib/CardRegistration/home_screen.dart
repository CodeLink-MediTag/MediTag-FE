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

          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: _MainView()
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
      padding: EdgeInsets.only(top: 50),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15),
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
                      fontSize: 25,
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
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 490,
            child: _Select(),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 100,
            child: Text(
              style: Theme.of(context).textTheme.bodyLarge,
              '시간을 선택하고 카드를 태그해주세요'
            ),
          ),
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
    Column(
      children: [

        SizedBox(height: 100,),

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
    ;
  }

}