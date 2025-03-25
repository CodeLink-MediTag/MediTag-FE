import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/renewpo.dart';
import 'package:untitled9/provider/medicine_provider.dart';
import 'package:intl/intl.dart';

class RenewdayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RenewScreen();
  }
}

class RenewScreen extends StatefulWidget {
  @override
  _RenewState createState() => _RenewState();
}

class _RenewState extends State<RenewScreen> {
  List<String> selectedDosageTimes = [];
  String? selectedPeriod = "3일";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // 기존 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      if (provider.dosageTimes.isNotEmpty) {
        setState(() {
          selectedDosageTimes = provider.dosageTimes;
        });
      } else {
        setState(() {
          selectedDosageTimes = ['아침'];
        });
      }

      if (provider.startDate.isNotEmpty) {
        setState(() {
          selectedDate = DateTime.parse(provider.startDate);
        });
      }
    });
  }

  // 선택된 기간을 일수로 변환
  int _getDurationDays() {
    switch(selectedPeriod) {
      case "3일": return 3;
      case "5일": return 5;
      case "1개월": return 30;
      case "1년": return 365;
      case "매일": return 9999; // 무기한
      default: return 3;
    }
  }

  Future _selectDate(BuildContext context) async {
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
    final medicineProvider = Provider.of<MedicineProvider>(context);

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
            onPressed: (){
              Navigator.pop(context);
            },
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

    // 복용 주기
    Text("복용 주기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Row(
    children: ["아침", "점심", "저녁"].map((time) {
    return Row(
    children: [
    Checkbox(
    value: selectedDosageTimes.contains(time),
    onChanged: (value) {
    setState(() {
    if (value == true) {
    if (!selectedDosageTimes.contains(time)) {
    selectedDosageTimes.add(time);
    }
    } else {
    selectedDosageTimes.remove(time);
    }
    medicineProvider.setDosageTimes(selectedDosageTimes);
    medicineProvider.setFrequency(selectedDosageTimes.length);
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

    // 복용 시작 날짜
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
    Text(
    DateFormat('yyyy-MM-dd').format(selectedDate),
    style: TextStyle(fontSize: 16)
    ),
    Icon(Icons.edit, color: Colors.grey),
    ],
    ),
    ),
