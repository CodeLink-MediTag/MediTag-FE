import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled9/screen/card_registration.dart';
import 'package:untitled9/screen/recording_list.dart';


class RecordingScreen extends StatelessWidget{
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      child: Scaffold(
        body: SafeArea(
            top: false,
            bottom: false ,
            child: Center(
              child: HomeScreen(),
            )
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget{
  HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          _TopBar(),

          /*
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RecordingList()
              )
          )

           */
          RecordingList()

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
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // 현재 화면 종료 (이전 화면으로 돌아감)

              },
            ),

            Container(
                // height: 70,
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

class _RecordingView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RecordingViewState();
  }
}

class _RecordingViewState extends State<_RecordingView>{

  late Widget content;
  bool mode = true;

  @override
  void initState() {
    super.initState();
    content = Recording(onPressed: SwitchMode);
  }
  void SwitchMode(){
    setState(() {
      mode = !mode;
      if (mode){
        content = Recording(onPressed: SwitchMode);
      } else{
        content = RecordingStart(onPressed: SwitchMode,);
      }
    });


    print("모드 변경/ 현재 모드 : ${content}");
  }

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
                child: content,
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

class Recording extends StatelessWidget{

  VoidCallback onPressed;

  Recording({
    super.key,
    required this.onPressed
  });

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
          onPressed: onPressed,
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

class RecordingStart extends StatelessWidget{

  VoidCallback onPressed;

  RecordingStart({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent[100], // 배경색 적용
            borderRadius: BorderRadius.circular(17), // 둥근 모서리 적용
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(height: 50,),

              Container(
                height: 100,
                width: 200,
                child: Center(
                  child: Text(
                    '00:00:01',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),

              SizedBox(height: 40,),

              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '2024.3.28\n오후 04:26 녹음',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),

              SizedBox(height: 80,),

              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,                 // 내부 여백 제거
                          minimumSize: Size.zero,                   // 기본 크기 제한 제거
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
                          backgroundColor: Colors.transparent,      // 배경 투명 (Container가 배경이 되도록)
                          elevation: 0,                              // 필요시 그림자 제거
                        ),
                        child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF547EE8), //상단바 컬러
                            ),
                            child: Center(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22
                                ),
                              ),
                            )
                        ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF547EE8), //상단바 컬러

                      ),
                      child: Icon(
                        Icons.pause,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF547EE8), //상단바 컬러

                      ),
                      child: Icon(
                        Icons.stop,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      )
    ;
  }
}

