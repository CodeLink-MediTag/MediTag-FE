import 'package:flutter/material.dart';
import 'dart:io';
import 'package:untitled9/model/medicine.dart';

class MedicineProvider extends ChangeNotifier {
  String _name = '';
  String _characteristic = '';
  String _startDate = '';
  int _duration = 3;
  int _frequency = 1;
  List<String> _dosageTimes = ['아침'];
  List<String> _alarmTimes = [];
  bool _prescribed = false;
  File? _imageFile;

  // Getters
  String get name => _name;
  String get characteristic => _characteristic;
  String get startDate => _startDate;
  int get duration => _duration;
  int get frequency => _frequency;
  List<String> get dosageTimes => _dosageTimes;
  List<String> get alarmTimes => _alarmTimes;
  bool get prescribed => _prescribed;
  File? get imageFile => _imageFile;

  // Setters
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setCharacteristic(String characteristic) {
    _characteristic = characteristic;
    notifyListeners();
  }

  void setStartDate(String startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  void setDuration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  void setFrequency(int frequency) {
    _frequency = frequency;
    notifyListeners();
  }

  void setDosageTimes(List<String> dosageTimes) {
    _dosageTimes = dosageTimes;
    notifyListeners();
  }

  void setAlarmTimes(List<String> alarmTimes) {
    _alarmTimes = alarmTimes;
    notifyListeners();
  }

  void setPrescribed(bool value) {
    _prescribed = value;
    notifyListeners();
  }

  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  // 데이터 초기화
  void reset() {
    _name = '';
    _characteristic = '';
    _startDate = '';
    _duration = 3;
    _frequency = 1;
    _dosageTimes = ['아침'];
    _alarmTimes = [];
    _imageFile = null;
    notifyListeners();
  }

  // Medicine 객체 생성
  Medicine createMedicine() {
    return Medicine(
      name: _name,
      characteristic: _characteristic,
      startDate: _startDate,
      duration: _duration,
      frequency: _frequency,
      imageUrl: _imageFile != null ? _imageFile!.path : "",
      prescribed: true,
      dosageTimes: _dosageTimes,
      alarmTimes: _alarmTimes,
    );
  }
}
