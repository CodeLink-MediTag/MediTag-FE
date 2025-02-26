import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, String> medicationTimes = {
    '처방약_1': '오전 09:00',
    '처방약_2': '오후 02:00',
    '처방약_3': '오후 08:00',
    '비타민_1': '오전 09:00',
    '비타민_2': '오후 08:00',
  };

  Map<String, String> originalTimes = {}; // 원래 시간 저장용

  @override
  void initState() {
    super.initState();
    originalTimes.addAll(medicationTimes);
  }

  void toggleTime(String key) {
    setState(() {
      if (medicationTimes[key] == '복용 완료!') {
        medicationTimes[key] = originalTimes[key]!; // 원래 시간으로 복구
      } else {
        _showMedicationDialog(key);
      }
    });
  }

  void _confirmMedication(String key) {
    setState(() {
      medicationTimes[key] = '복용 완료!';
    });
  }

  void _showMedicationDialog(String key) {
    String currentTime = medicationTimes[key]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 330,
            height: 210,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "처방약",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "$currentTime에 약을 드셨나요?",
                  style: TextStyle(fontSize: 19, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF547EE8),
                        fixedSize: Size(128, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        _confirmMedication(key);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "네",
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        fixedSize: Size(128, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "아니요",
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF547EE8),
        toolbarHeight: 80.0,
        title: Text(
          '000의 복약알림',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        actions: [SizedBox(width: 20), Icon(Icons.settings, color: Colors.white)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildMedicationCard('처방약', '긴 상자', ['처방약_1', '처방약_2', '처방약_3']),
            SizedBox(height: 40),
            _buildMedicationCard('비타민', '원형 긴 통', ['비타민_1', '비타민_2']),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF547EE8),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {},
              child: Text(
                '알림 받을 약 추가',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationCard(String title, String subtitle, List<String> timeKeys) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16), // 상자 크기 통일
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF547EE8), width: 2),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.image, color: Colors.grey, size: 35),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(subtitle, style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8), // 여백을 추가하여 버튼들이 잘리지 않게 함
              child: Row(
                children: timeKeys.map((key) => _buildTimeButton(key)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // 간격을 조금 더 넓게
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: medicationTimes[key] == '복용 완료!' ? Color(0xFFA3BCF1) : Colors.white,
          minimumSize: Size(110, 55), // 버튼 크기 통일 (너비 늘리기)
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          if (medicationTimes[key] == '복용 완료!') {
            toggleTime(key);
          } else {
            _showMedicationDialog(key);
          }
        },
        child: Text(
          medicationTimes[key]!,
          style: TextStyle(fontSize: 14, color: medicationTimes[key] == '복용 완료!' ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
