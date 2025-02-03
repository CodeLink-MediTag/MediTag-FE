import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_test_project/Recording/recording_start.dart';
import 'recording.dart';

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
        height: 650,
        child: Column(
          children: [

            SizedBox(height: 18,),

            Container(
              height: 500,
              width: double.infinity,
              child: RecordingStart(),
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

