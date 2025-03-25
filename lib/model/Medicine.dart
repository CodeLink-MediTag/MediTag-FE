class Medicine {
  String name;
  String characteristic;
  String startDate;
  int duration;
  int frequency;
  String imageUrl;
  bool prescribed;
  List<String> dosageTimes;
  List<String> alarmTimes;

  Medicine({
    required this.name,
    required this.characteristic,
    required this.startDate,
    required this.duration,
    required this.frequency,
    this.imageUrl = "",
    this.prescribed = true,
    required this.dosageTimes,
    required this.alarmTimes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'characteristic': characteristic,
      'startDate': startDate,
      'duration': duration,
      'frequency': frequency,
      'imageUrl': imageUrl,
      'prescribed': prescribed,
      'dosageTimes': dosageTimes,
      'alarmTimes': alarmTimes,
    };
  }
}
