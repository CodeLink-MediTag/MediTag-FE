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
      // Container(
      //   padding: EdgeInsets.only(top: 50),
      //   color: Colors.blueAccent,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         padding: EdgeInsets.only(left: 15),
      //         width: 30,
      //         child: Icon(
      //           Icons.arrow_back,
      //           color: Colors.white,
      //         ),
      //       ),
      //       Container(
      //           height: 70,
      //           width: 200,
      //           child: Center(
      //             child: Text(
      //                 style: TextStyle(
      //                     fontSize: 25,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.white
      //                 ),
      //                 '주의사항 녹음'
      //             ),
      //           )
      //
      //       ),
      //       Container(
      //         padding: EdgeInsets.only(right: 12),
      //         width: 30,
      //         height: 20,
      //         child: Icon(
      //           Icons.home,
      //           color: Colors.white,
      //         ),
      //       )
      //     ],
      //   ),
      // )
      Container(
        padding: EdgeInsets.only(top: 37, bottom: 12), // 상단바 위쪽 높이 증가
        color: Color(0xFF547EE8), //상단바 컬러
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
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
                      '주의사항 등록'
                  ),
                )

            ),
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),

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
        child: Column(
          children: [


            Expanded(
                child: Container(
                  width: double.infinity,
                  // child: Recording(),
                  child: RecordingStart(),
                ),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
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

