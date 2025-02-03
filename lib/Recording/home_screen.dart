import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen ({super.key});

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
        color: Colors.blueAccent,
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
                      '주의사항 녹음'
                  ),
                )

            ),
            Container(
              padding: EdgeInsets.only(right: 12),
              width: 30,
              height: 20,
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
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
        height: 650,
        child: Column(

          children: [

            SizedBox(height: 18,),

            Container(


              height: 500,
              width: double.infinity,
              child: _Recording(),
            ),

            SizedBox(height: 60,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(500, 55),
                textStyle: TextStyle(
                    fontSize: 20
                ),
                foregroundColor: Colors.white
              ),
              onPressed:(){},
              child: Text('모든 녹음파일')
            )
          ],
        ),
      )
    ;
  }
}

class _Recording extends StatelessWidget{
  _Recording({super.key});

  @override
  Widget build(BuildContext context) {
    return
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17)
        ),
      ),
      onPressed: (){},
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent[100],
          border: Border.all(
            color: Colors.blueAccent,
            width: 5
          )
        ),
        child: Center(
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent
            ),
            child: Icon(
              Icons.mic,
              size: 100,
              color: Colors.white,
            ),
          )
        )


      )
    )
    ;
  }
}