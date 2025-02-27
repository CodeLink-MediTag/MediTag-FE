import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ 추가!
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Flutter 엔진 초기화
  await initializeDateFormatting('ko_KR', null); // ✅ 한국어 날짜 포맷 사용 가능하도록 설정
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlarmRegistrationScreen(),
    );
  }
}

class AlarmRegistrationScreen extends StatefulWidget {
  const AlarmRegistrationScreen({super.key});

  @override
  AlarmRegistrationScreenState createState() => AlarmRegistrationScreenState();
}

class AlarmRegistrationScreenState extends State<AlarmRegistrationScreen> {
  List<TimeOfDay> alarmTimes = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 13, minute: 0),
    const TimeOfDay(hour: 18, minute: 0),
  ];
  File? selectedImage;

  // 시간 선택 함수
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

  // 사진 선택 함수
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Container(
            color: Color(0xFF547EE8),
            padding: const EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
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
                  const Text(
                    "마지막으로 알림을 원하는 시간을 등록해주세요!\n사진이 있다면 사진을 등록해도 좋아요.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // 알림 시간
                  const Text("알림 시간", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                              border: Border.all(color: Colors.grey),
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
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const Icon(Icons.access_time, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // 사진 업로드
                  const Text("사진", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 53,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedImage == null
                              ? const Text("사진이 있다면 등록해주세요!", style: TextStyle(fontSize: 16, color: Colors.grey))
                              : const Text("사진 선택됨", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const Icon(Icons.image, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // 등록 버튼
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 358,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF547EE8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // 알림 등록 로직 추가 가능
                },
                child: const Text(
                  "등록",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
