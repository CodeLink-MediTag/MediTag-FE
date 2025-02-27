

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recording extends StatelessWidget{
  Recording({super.key});

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