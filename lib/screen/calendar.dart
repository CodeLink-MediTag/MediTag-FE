import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled9/screen/setting_state.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? token;
  List<Medicine> selectedMedicines = [];
  Set<DateTime> medicationDays = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    fetchMedicinesForDate(_selectedDay!);
    fetchMedicationDays();
  }

  Future<void> fetchMedicinesForDate(DateTime date) async {
    if (token == null) return;

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/medicines?date=$formattedDate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Medicine> fetched = (data['medicines'] as List)
            .map((m) => Medicine.fromJson(m))
            .toList();
        setState(() {
          selectedMedicines = fetched;
        });
      } else {
        setState(() {
          selectedMedicines = [];
        });
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }

  Future<void> fetchMedicationDays() async {
    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/calendar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> dates = json.decode(response.body);
        Set<DateTime> parsedDates = dates.map((d) => DateTime.parse(d)).toSet();
        setState(() {
          medicationDays = parsedDates;
        });
      }
    } catch (e) {
      print("회색 점 날짜 불러오기 실패: $e");
    }
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return medicationDays.any((d) => isSameDay(d, day)) ? ['복약 있음'] : [];
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingState>(context);

    return MaterialApp(
      locale: Locale('ko', 'KR'),
      supportedLocales: [Locale('ko', 'KR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: setting.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Color(0xFF547EE8),
              padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context)),
                  Text('복약기록 캘린더',
                      style: TextStyle(fontSize: setting.textSize + 6, color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.home, color: Colors.white),
                ],
              ),
            ),
            TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                fetchMedicinesForDate(selectedDay);
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
              headerStyle: HeaderStyle(titleCentered: true, formatButtonVisible: false),
            ),
            SizedBox(height: 20),
            Text("약 목록", style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.bold)),
            Expanded(
              child: selectedMedicines.isEmpty
                  ? Center(child: Text("선택 날짜에 복용 약이 없어요", style: TextStyle(fontSize: setting.textSize)))
                  : ListView.builder(
                  itemCount: selectedMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = selectedMedicines[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(medicine.medicineName,
                                style: TextStyle(fontSize: setting.textSize, fontWeight: FontWeight.bold)),
                            ...medicine.alarms.map((alarm) {
                              String time = DateFormat('HH:mm').format(alarm.alarmTime);
                              return Row(
                                children: [
                                  Text("$time", style: TextStyle(fontSize: setting.textSize - 2)),
                                  SizedBox(width: 12),
                                  Text(
                                    alarm.taking ? "복용" : "미복용",
                                    style: TextStyle(
                                      fontSize: setting.textSize - 2,
                                      color: alarm.taking ? Colors.green : Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class Medicine {
  final String medicineName;
  final List<Alarm> alarms;

  Medicine({required this.medicineName, required this.alarms});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      alarms: (json['alarms'] as List).map((a) => Alarm.fromJson(a)).toList(),
    );
  }
}

class Alarm {
  final DateTime alarmTime;
  final bool taking;

  Alarm({required this.alarmTime, required this.taking});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      alarmTime: DateTime.parse(json['alarmTime']),
      taking: json['taking'],
    );
  }
}
