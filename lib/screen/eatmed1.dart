import 'package:flutter/material.dart';
import 'package:untitled9/screen/renew.dart';
import 'package:untitled9/screen/MedicationDetail.dart';
import 'package:untitled9/screen/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class Eatmed1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Medicine> medicines = [];
  bool isLoading = true;
  String currentDate = '';
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    if (token == null) {
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = true);
    try {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      currentDate = today;

      final response = await http.get(
        Uri.parse('http://localhost:8080/api/medicines?date=$today'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Medicine> fetchedMedicines = (data['medicines'] as List)
            .map((medicine) => Medicine.fromJson(medicine))
            .toList();

        setState(() {
          medicines = fetchedMedicines;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateMedicineTaking(Medicine medicine, Alarm alarm) async {
    if (token == null) return;

    try {
      await http.post(
        Uri.parse('http://localhost:8080/api/medicines/taking'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'medicineName': medicine.medicineName,
          'alarmTime': alarm.alarmTime.toIso8601String(),
          'taking': alarm.taking,
        }),
      );
    } catch (e) {
      print('약 복용 상태 업데이트 중 오류 발생: $e');
    }
  }

  void _toggleTaking(Medicine medicine, Alarm alarm) {
    setState(() => alarm.taking = !alarm.taking);
    updateMedicineTaking(medicine, alarm);
  }

  void _showMedicationDialog(Medicine medicine, Alarm alarm) {
    final setting = Provider.of<SettingState>(context, listen: false);
    final colors = Theme.of(context).extension<MyColors>()!;
    String formattedTime = DateFormat('a hh:mm', 'ko_KR').format(alarm.alarmTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 330,
            height: 210,
            padding: EdgeInsets.all(20),
            color: colors.secondary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(medicine.medicineName, style: TextStyle(fontSize: setting.textSize + 6, fontWeight: FontWeight.bold, color: colors.text)),
                SizedBox(height: 10),
                Text("$formattedTime에 약을 드셨나요?", style: TextStyle(fontSize: setting.textSize, color: colors.text.withOpacity(0.7))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        fixedSize: Size(128, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        _toggleTaking(medicine, alarm);
                        Navigator.pop(context);
                      },
                      child: Text("네", style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: colors.divider.withOpacity(0.3),
                        fixedSize: Size(128, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text("아니요", style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.bold, color: colors.text)),
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
    final setting = Provider.of<SettingState>(context);
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          Container(
            color: colors.primary,
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Text('메인 화면',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: setting.textSize + 4,
                      color: Colors.white,
                    )),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarScreen()),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : medicines.isEmpty
                ? Center(child: Text('등록된 약이 없습니다.', style: TextStyle(fontSize: setting.textSize, color: colors.text)))
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ...medicines.map((medicine) => Column(
                    children: [
                      _buildMedicationCard(medicine, setting.textSize, colors),
                      SizedBox(height: 40),
                    ],
                  )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RenewScreen()),
                      );
                    },
                    child: Text('알림 받을 약 추가', style: TextStyle(fontSize: setting.textSize, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Medicine medicine, double fontSize, MyColors colors) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
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
                  color: colors.divider,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: medicine.imageUrl != null && medicine.imageUrl!.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    medicine.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image, color: Colors.grey, size: 35),
                  ),
                )
                    : Icon(Icons.image, color: Colors.grey, size: 35),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medicine.medicineName, style: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold, color: colors.text)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicationDetail()),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(medicine.characteristic, style: TextStyle(fontSize: fontSize, color: colors.text.withOpacity(0.6))),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: medicine.alarms.map((alarm) => _buildTimeButton(medicine, alarm, fontSize, colors)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(Medicine medicine, Alarm alarm, double fontSize, MyColors colors) {
    String formattedTime = DateFormat('a hh:mm', 'ko_KR').format(alarm.alarmTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: alarm.taking ? colors.primary.withOpacity(0.7) : colors.secondary,
          minimumSize: Size(110, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          if (alarm.taking) {
            _toggleTaking(medicine, alarm);
          } else {
            _showMedicationDialog(medicine, alarm);
          }
        },
        child: Text(
          alarm.taking ? '복용 완료!' : formattedTime,
          style: TextStyle(fontSize: fontSize - 2, color: alarm.taking ? Colors.white : colors.text),
        ),
      ),
    );
  }
}

class Medicine {
  final String medicineName;
  final String characteristic;
  final String? imageUrl;
  final bool prescribed;
  final List<Alarm> alarms;

  Medicine({required this.medicineName, required this.characteristic, this.imageUrl, required this.prescribed, required this.alarms});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      characteristic: json['characteristic'],
      imageUrl: json['imageUrl'],
      prescribed: json['prescribed'],
      alarms: (json['alarms'] as List).map((alarm) => Alarm.fromJson(alarm)).toList(),
    );
  }
}

class Alarm {
  final DateTime alarmTime;
  bool taking;

  Alarm({required this.alarmTime, required this.taking});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      alarmTime: DateTime.parse(json['alarmTime']),
      taking: json['taking'],
    );
  }
}
