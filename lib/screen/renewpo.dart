import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:untitled9/screen/eatmed1.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class RenewpoScreen extends StatelessWidget {
  const RenewpoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RenewdayScreen();
  }
}

class RenewdayScreen extends StatefulWidget {
  const RenewdayScreen({super.key});
  @override
  _RenewdayState createState() => _RenewdayState();
}

class _RenewdayState extends State<RenewdayScreen> {
  List<TimeOfDay> alarmTimes = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 13, minute: 0),
    const TimeOfDay(hour: 18, minute: 0),
  ];
  File? selectedImage;

  Future<void> selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: alarmTimes[index],
    );
    if (picked != null) {
      setState(() {
        alarmTimes[index] = picked;
      });
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textSize = context.watch<SettingState>().textSize;
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          Container(
            color: colors.primary,
            padding: const EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(fontSize: textSize + 6, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 0),
                  Text(
                    "마지막으로 알림을 원하는 시간을 등록해주세요!\n사진이 있다면 사진을 등록해도 좋아요.",
                    style: TextStyle(fontSize: textSize - 2, fontWeight: FontWeight.bold, color: colors.text),
                  ),
                  const SizedBox(height: 20),
                  Text("알림 시간", style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold, color: colors.text)),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(alarmTimes.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTap: () => selectTime(context, index),
                          child: Container(
                            height: 53,
                            decoration: BoxDecoration(
                              border: Border.all(color: colors.divider),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('a hh:mm', 'ko_KR').format(
                                    DateTime(2000, 1, 1, alarmTimes[index].hour, alarmTimes[index].minute),
                                  ),
                                  style: TextStyle(fontSize: textSize - 2, color: colors.text),
                                ),
                                Icon(Icons.access_time, color: colors.text),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Text("사진", style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold, color: colors.text)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 53,
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.divider),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedImage == null
                              ? Text("사진이 있다면 등록해주세요!", style: TextStyle(fontSize: textSize - 2, color: colors.text.withOpacity(0.5)))
                              : Text("사진 선택됨", style: TextStyle(fontSize: textSize - 2, fontWeight: FontWeight.bold, color: colors.text)),
                          Icon(Icons.image, color: colors.text),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 358,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Eatmed1()),
                  );
                },
                child: Text(
                  "등록",
                  style: TextStyle(fontSize: textSize, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}