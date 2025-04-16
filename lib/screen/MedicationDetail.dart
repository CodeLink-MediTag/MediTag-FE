import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled9/screen/MedicationEdit.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class MedicationDetail extends StatefulWidget {
  @override
  _MedicationDetailState createState() => _MedicationDetailState();
}

class _MedicationDetailState extends State<MedicationDetail> {
  String medicationName = "처방약";
  DateTime startDate = DateTime.now();
  int duration = 7;
  String selectedTime = "아침";
  String selectedFrequency = "3번";
  TimeOfDay alarmTime = TimeOfDay.now();

  void _navigateToEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicationEdit(
          name: medicationName,
          startDate: startDate,
          duration: duration,
          selectedTime: selectedTime,
          selectedFrequency: selectedFrequency,
          alarmTime: alarmTime,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        medicationName = result['name'];
        startDate = result['startDate'];
        duration = result['duration'];
        selectedTime = result['selectedTime'];
        selectedFrequency = result['selectedFrequency'];
        alarmTime = result['alarmTime'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final setting = context.watch<SettingState>();
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: colors.primary,
              padding: EdgeInsets.only(top: 37, bottom: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      '상세 페이지',
                      style: TextStyle(
                        fontSize: setting.textSize + 6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.primary, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleWithValue("약 이름", medicationName, setting.textSize, colors),
                    _buildTitleWithValue("복용 시작 날짜", DateFormat('yyyy-MM-dd').format(startDate), setting.textSize, colors),
                    _buildTitleWithValue("복용 기간", "${duration}일", setting.textSize, colors),
                    _buildTitleWithValue("복용 시간대", selectedTime, setting.textSize, colors),
                    _buildTitleWithValue("복용 주기", selectedFrequency, setting.textSize, colors),
                    _buildTitleWithValue("알림 시간", alarmTime.format(context), setting.textSize, colors),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _navigateToEditPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  minimumSize: Size(358, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  '정보수정',
                  style: TextStyle(
                    fontSize: setting.textSize,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWithValue(String title, String value, double fontSize, MyColors colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: colors.text),
          ),
          SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: colors.divider.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize, color: colors.text),
            ),
          ),
        ],
      ),
    );
  }
}
