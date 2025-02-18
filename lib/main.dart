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

  void toggleTime(String key) {
    setState(() {
      if (medicationTimes[key] == '복용 완료!') {
        if (key.contains('비타민')) {
          medicationTimes[key] = key == '비타민_1' ? '오전 09:00' : '오후 08:00';
        } else {
          medicationTimes[key] = key == '처방약_1' ? '오전 09:00' : key == '처방약_2' ? '오후 02:00' : '오후 08:00';
        }
      } else {
        medicationTimes[key] = '복용 완료!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '000의 복약알림',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        actions: [SizedBox(width: 16), Icon(Icons.settings, color: Colors.white)],
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
                backgroundColor: Colors.blue,
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
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue, width: 2),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.image, color: Colors.grey),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward, color: Colors.black),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: timeKeys.map((key) => _buildTimeButton(key)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: medicationTimes[key] == '복용 완료!' ? Color(0xFF89B8FF) : Colors.white,
          minimumSize: Size(86, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () => toggleTime(key),
        child: Text(
          medicationTimes[key]!,
          style: TextStyle(fontSize: 14, color: medicationTimes[key] == '복용 완료!' ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
