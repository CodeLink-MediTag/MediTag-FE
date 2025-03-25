import 'package:flutter/material.dart';
import 'package:untitled9/screen/renewday.dart';
import 'package:untitled9/provider/medicine_provider.dart';

class RenewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Eatmed1();
  }
}

class Eatmed1 extends StatefulWidget {
  @override
  _Eatmed1State createState() => _Eatmed1State();
}

class _Eatmed1State extends State<Eatmed1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _characteristicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 기존 데이터가 있으면 컨트롤러에 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      _nameController.text = provider.name;
      _characteristicController.text = provider.characteristic;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _characteristicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '복약 알림 등록',
                      style: TextStyle(
                        fontSize: 22,
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

          // 나머지 화면
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "약의 이름과 특징을 입력해 주세요!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  // 이름 등록
                  Text("이름 등록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 358,
                    height: 48,
                    child: TextField(
                      controller: _nameController,
                      onChanged: (value) => medicineProvider.setName(value),
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
                      controller: _characteristicController,
                      onChanged: (value) => medicineProvider.setCharacteristic(value),
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

                  Spacer(),

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
                          onPressed: () {
                            // 처방약 등록 로직
                            medicineProvider.setPrescribed(true);
                          },
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
                            // 다음 화면으로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RenewdayScreen()),
                            );
                          },
                          child: Text(
                            "다음",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
