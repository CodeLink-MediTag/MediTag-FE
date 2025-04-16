import 'package:flutter/material.dart';
import 'package:untitled9/screen/renewday.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class RenewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Eatmed1();
  }
}

class Eatmed1 extends StatefulWidget {
  @override
  _Eatmed1State createState() => _Eatmed1State();
}

class _Eatmed1State extends State<Eatmed1> {
  @override
  Widget build(BuildContext context) {
    final setting = context.watch<SettingState>();
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          Container(
            color: colors.primary,
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(
                        fontSize: setting.textSize + 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "약의 이름과 특징을 입력해 주세요!",
                    style: TextStyle(
                      fontSize: setting.textSize,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "이름 등록",
                    style: TextStyle(
                      fontSize: setting.textSize - 2,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "이름을 지어주세요! 예) 처방약, 비타민B",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: setting.textSize - 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: TextStyle(fontSize: setting.textSize, color: colors.text),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "특징 등록",
                    style: TextStyle(
                      fontSize: setting.textSize - 2,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "특징을 등록해 주세요! 예) 동그란 통, 사각 통",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: setting.textSize - 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: TextStyle(fontSize: setting.textSize, color: colors.text),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "처방약 등록",
                            style: TextStyle(
                              fontSize: setting.textSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RenewdayScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "다음",
                            style: TextStyle(
                              fontSize: setting.textSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}