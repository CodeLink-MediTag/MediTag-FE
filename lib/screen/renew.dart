import 'package:flutter/material.dart';
import 'package:untitled9/screen/eatmed1.dart';
import 'package:untitled9/screen/renewday.dart';


class RenewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Eatmed1();
  }
}

// 선택 데이터들을 수집하기 위해 필요한 클래스
class SelectionData{
  String? name;
  String? characteristic;
  String? startDate;
  int? duration;
  int? frequency;
  String? imageUrl;
  bool? prescribed;
  List<String>? dosageTimes;
  List<String>? alarmTimes;

  SelectionData({
    this.name,
    this.characteristic,
    this.startDate,
    this.duration,
    this.frequency,
    this.imageUrl,
    this.prescribed,
    this.dosageTimes,
    this.alarmTimes
});
  SelectionData copyWith({
    String? name,
    String? characteristic,
    String? startDate,
    int? duration,
    int? frequency,
    String? imageUrl,
    bool? prescribed,
    List<String>? dosageTimes,
    List<String>? alarmTimes,
}){
    return SelectionData(
      name: name ?? this.name,
      characteristic: characteristic ?? this.characteristic,
      startDate: startDate ?? this.startDate,
      duration: duration ?? this.duration,
      frequency: frequency ?? this.frequency,
      imageUrl: imageUrl ?? this.imageUrl,
      prescribed: prescribed ?? this.prescribed,
      dosageTimes: dosageTimes?? this.dosageTimes,
      alarmTimes: alarmTimes ?? this.alarmTimes
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "SelectionData(name: $name,"
        " characteristic: $characteristic,"
        " startDate: $startDate,"
        " duration: $duration,"
        " frequency: $frequency,"
        " imageUrl: $imageUrl,"
        " prescribed: $prescribed,"
        " dosageTimes: $dosageTimes,"
        " alarmTimes: $alarmTimes";
  }
}
class Eatmed1 extends StatefulWidget {
  @override
  _Eatmed1State createState() => _Eatmed1State();
}

class _Eatmed1State extends State<Eatmed1> {

  // 텍스트 입력값 가져오기 위한 컨트롤러
  final TextEditingController medicineName = TextEditingController();
  final TextEditingController characteristic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 아이콘과 텍스트 수직 중앙 정렬
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: (){
                    Navigator.pop(context); // 현재 화면 종료 (이전 화면으로 돌아감)
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상 흰색
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40), // 오른쪽 여백
              ],
            ),
          ),

          // 나머지 화면
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30), // 여백 조정
                  Text(
                    "약의 이름과 특징을 입력해 주세요!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30), // 여백 추가

                  // 이름 등록
                  Text("이름 등록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      controller: medicineName, // 약 이름 입력값 가져오기
                      decoration: InputDecoration(
                        hintText: "이름을 지어주세요! 예) 처방약, 비타민B",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // 특징 등록
                  Text("특징 등록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      controller: characteristic, // 특징 입력값 가져오기
                      decoration: InputDecoration(
                        hintText: "특징을 등록해 주세요! 예) 동그란 통, 사각 통",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),

                  Spacer(), // 버튼을 아래로 밀어줌

                  // 버튼들
                  Column(
                    children: [
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF547EE8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "처방약 등록",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 358,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF547EE8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: (){
                            // 입력받은 값 가져와서 객체에 담아 다음 페이지로 넘겨주기
                            final medicineNameInput = medicineName.text;
                            final characteristicInput = characteristic.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RenewdayScreen(
                                selectionData: SelectionData(
                                  name: medicineNameInput,
                                  characteristic: characteristicInput
                                ),
                              )),
                            );
                          },
                          child: Text(
                            "다음",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // 마지막 여백 추가
                    ],
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