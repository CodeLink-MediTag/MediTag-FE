

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordingStart extends StatelessWidget{
  RecordingStart({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: Colors.blueAccent[100],
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(17)
          //   ),
          // ),
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
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent
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
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent[200]
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
                          color: Colors.blueAccent
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