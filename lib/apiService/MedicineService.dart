import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MedicineService {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<bool> registerMedicine(Medicine medicine, File? imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/medicines'));

      // 헤더 설정
      request.headers['accept'] = '*/*';
      request.headers['Content-Type'] = 'multipart/form-data';

      // 데이터 추가
      request.fields['data'] = jsonEncode(medicine.toJson());

      // 이미지 파일이 있으면 추가
      if (imageFile != null) {
        var fileExtension = imageFile.path.split('.').last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            imageFile.path,
            contentType: MediaType('image', 'png'),
          ),
        );
      }

      var response = await request.send();

      return response.statusCode == 200;
    } catch (e) {
      print('Error registering medicine: $e');
      return false;
    }
  }
}
