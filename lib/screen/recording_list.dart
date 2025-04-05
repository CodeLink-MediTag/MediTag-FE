import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordingList extends StatelessWidget{
  var title = "회의 녹음 1";
  var date = "2025-04-05";
  var duration = "01:24";
  var onPlay = () {

  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // 전체 너비
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 내용 높이에 맞게
        children: [
          // 상단 영역 (2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목과 날짜
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              // 재생 시간 (오른쪽 정렬)
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 구분선
          const Divider(thickness: 1),

          const SizedBox(height: 8),

          // 하단 영역 (플레이 버튼 중앙)
          Center(
            child: IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32,
              onPressed: onPlay,
            ),
          ),
        ],
      ),
    );
  }
}