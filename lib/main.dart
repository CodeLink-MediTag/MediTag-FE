import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineScheduleScreen(),
    );
  }
}

class MedicineScheduleScreen extends StatefulWidget {
  @override
  _MedicineScheduleScreenState createState() => _MedicineScheduleScreenState();
}

class _MedicineScheduleScreenState extends State<MedicineScheduleScreen> {
  String? selectedTime = "아침";
  String? selectedPeriod = "3일";
  TextEditingController customDaysController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(
                        fontSize: 26,
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "복용 주기, 복용 시작 날짜, 기간을 입력해주세요!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("복용 주기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: ["아침", "점심", "저녁"].map((time) {
                      return Row(
                        children: [
                          Radio(
                            value: time,
                            groupValue: selectedTime,
                            onChanged: (value) {
                              setState(() {
                                selectedTime = value as String;
                              });
                            },
                          ),
                          Text(time, style: TextStyle(fontSize: 14)),
                          SizedBox(width: 10),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text("복용 시작 날짜", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 16)),
                          Icon(Icons.edit, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("복용 기간", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Column(
                    children: ["3일", "5일", "1개월", "1년", "매일"].map((period) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 358,
                          height: 53,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RadioListTile(
                            title: Text(period, style: TextStyle(fontSize: 20)),
                            value: period,
                            groupValue: selectedPeriod,
                            onChanged: (value) {
                              setState(() {
                                selectedPeriod = value as String;
                              });
                            },
                            activeColor: Colors.blue,
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 358,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF547EE8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: Text(
                  "다음",
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