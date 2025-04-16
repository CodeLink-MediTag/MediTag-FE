import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled9/screen/MedicationDetail.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';
import 'package:untitled9/screen/my_colors.dart';

class MedicationEdit extends StatefulWidget {
  final String name;
  final DateTime startDate;
  final int duration;
  final String selectedTime;
  final String selectedFrequency;
  final TimeOfDay alarmTime;

  MedicationEdit({
    required this.name,
    required this.startDate,
    required this.duration,
    required this.selectedTime,
    required this.selectedFrequency,
    required this.alarmTime,
  });

  @override
  _MedicationEditState createState() => _MedicationEditState();
}

class _MedicationEditState extends State<MedicationEdit> {
  late TextEditingController nameController;
  late TextEditingController durationController;
  late DateTime startDate;
  late String selectedTime;
  late String selectedFrequency;
  late TimeOfDay alarmTime;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    durationController = TextEditingController(text: widget.duration.toString());
    startDate = widget.startDate;
    selectedTime = widget.selectedTime;
    selectedFrequency = widget.selectedFrequency;
    alarmTime = widget.alarmTime;
  }

  void _saveChanges() {
    Navigator.pop(context, {
      'name': nameController.text,
      'startDate': startDate,
      'duration': int.parse(durationController.text),
      'selectedTime': selectedTime,
      'selectedFrequency': selectedFrequency,
      'alarmTime': alarmTime,
    });
  }

  Future<void> _pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => startDate = picked);
    }
  }

  Future<void> _pickAlarmTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: alarmTime,
    );
    if (picked != null) {
      setState(() => alarmTime = picked);
    }
  }

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
            padding: EdgeInsets.only(top: 37, bottom: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Center(
                  child: Text(
                    '정보 수정',
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.primary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          style: TextStyle(fontSize: setting.textSize, color: colors.text),
                          decoration: InputDecoration(
                            labelText: "약 이름",
                            labelStyle: TextStyle(fontSize: setting.textSize),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "복용 시작 날짜: ${DateFormat('yyyy-MM-dd').format(startDate)}",
                            style: TextStyle(fontSize: setting.textSize, color: colors.text),
                          ),
                          trailing: Icon(Icons.calendar_today, color: colors.text),
                          onTap: _pickStartDate,
                        ),
                        TextField(
                          controller: durationController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: setting.textSize, color: colors.text),
                          decoration: InputDecoration(
                            labelText: "복용 기간 (일)",
                            labelStyle: TextStyle(fontSize: setting.textSize),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("복용 시간대", style: TextStyle(fontWeight: FontWeight.bold, fontSize: setting.textSize, color: colors.text)),
                        Wrap(
                          spacing: 10,
                          children: ["아침", "점심", "저녁"].map((time) {
                            return ChoiceChip(
                              label: Text(time, style: TextStyle(fontSize: setting.textSize)),
                              selected: selectedTime == time,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) selectedTime = time;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        Text("복용 주기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: setting.textSize, color: colors.text)),
                        Wrap(
                          spacing: 10,
                          children: ["1번", "2번", "3번"].map((freq) {
                            return ChoiceChip(
                              label: Text(freq, style: TextStyle(fontSize: setting.textSize)),
                              selected: selectedFrequency == freq,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) selectedFrequency = freq;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        ListTile(
                          title: Text("알림 시간: ${alarmTime.format(context)}", style: TextStyle(fontSize: setting.textSize, color: colors.text)),
                          trailing: Icon(Icons.access_time, color: colors.text),
                          onTap: _pickAlarmTime,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      minimumSize: Size(358, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      '저장',
                      style: TextStyle(
                        fontSize: setting.textSize,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
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
