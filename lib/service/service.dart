import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dynamic_textformfield/model/sample_model.dart';

class SampleService {
  Map<String, dynamic> jsonData = {
    "adharFields": {
      "status": true,
      "tffData": [
        {
          "widgetType": "tff",
          "label": "Name",
          "validation": true,
          "hint": "Enter Aadhar Name",
          "controller": "sandeep",
          "keyBord": "number",
          "calendar": false,
        },
        {
          "widgetType": "tff",
          "label": "Adhar Number",
          "validation": true,
          "hint": "Enter Aadhar Number",
          "controller": "8475 8763 7675",
          "keyBord": "number",
          "calendar": false,
        },
        {
          "widgetType": "tff",
          "label": "Father's Name",
          "validation": true,
          "hint": "Enter Father's Name",
          "controller": "Abraham",
          "keyBord": "text",
          "calendar": false,
        },
        {
          "widgetType": "tff",
          "label": "Mothers's Name",
          "validation": true,
          "hint": "Enter Mother's Name",
          "controller": "Lucy",
          "keyBord": "number",
          "calendar": true,
        },
        {
          "widgetType": "tff",
          "label": "Date of birth",
          "validation": false,
          "hint": "Date Of Birth",
          "controller": "26-11-1987",
          "keyBord": "number",
          "calendar": true,
        },
        {
          "widgetType": "tff",
          "label": "Expiry Date",
          "validation": false,
          "hint": "Date Of Birth",
          "controller": "26-11-1987",
          "keyBord": "number",
          "calendar": true,
        },
      ],
      "imgData": [
        // {
        //   "widgetType": "oneImg",
        //   "label": "Upload image",
        //   "image":
        //       "https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg"
        //           "",
        // },
        {
          "widgetType": "multyImg",
          "label": "Upload Pancard",
          "images": [
            "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Australia_green_tree_frog_%28Litoria_caerulea%29_crop.jpg/800px-Australia_green_tree_frog_%28Litoria_caerulea%29_crop.jpg"
          ],
        },
      ],
      "dropDown": [
        {
          "widgetType": "dropDown",
          "label": "Select Gender",
          "hint": "Select Gender",
          "selectedOption": "Select Gender",
          "options": ["Select Gender", "Male", "Female", "Other"]
        },
        {
          "widgetType": "dropDown",
          "label": "Select Vehicle Type",
          "hint": "Seden",
          "selectedOption": "Select Vehicle Type",
          "options": ["Select Vehicle Type", "Sedan", "Hatch Back", "SUV"]
        }
      ]
    },
  };

  Future<AdharData?> fetchAadhar() async {
    // String fetchAadharUrl = '';
    // Dio dio = Dio();

    try {
      // Response response = await dio.get(fetchAadharUrl);

      int statusCode = 200;
      if (statusCode == 200) {
        log('JSON data to be parsed: ${jsonData.toString()}');
        dynamic aadharFields = AdharData.fromJson(jsonData);
        log('Parsed data: $aadharFields');
        return aadharFields;
      } else {
        log('Unexpected status code: $statusCode');
        return null;
      }
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
      return null;
    }
  }

  // Future<void> sendDataToBackend(
  //     List<String> controllers, List<String> dropdownValue,
  //     {List<String?>? images, String? image}) async {
  //   String sampleUrl = '';
  //   Dio dio = Dio();

  //   try {
  //     // Response response = await dio.post(sampleUrl);

  //     log('controllers:  ${controllers.toString()}');
  //     log('dropdown values:  ${dropdownValue.toString()}');
  //     log('images:  ${images.toString()}');
  //     log('image:  ${image.toString()}');
  //   } catch (e) {}
  // }

  Future<void> sendDataToBackend(
      List<String> controllers, List<String> dropdownValue,
      {List<File?>? images, File? image}) async {
    // Create a map to hold the data

    log("images : $images");
    log("image : $image");

    Map<String, dynamic> data = {
      'controllers': controllers,
      'dropdownValues': dropdownValue,
    };

    FormData formData = FormData.fromMap({
      'data': jsonEncode(data),

      // Add images if they exist
      if (images != null)
        'images': images
            .where((image) => image != null)
            .map((image) => MultipartFile.fromFileSync(image!.path,
                filename: image.path.split('/').last))
            .toList(),

      // Add the single image if it exists
      if (image != null)
        'image': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
    });

    log('Map Data : ${formData.fields}');
    log('Map Data : ${formData.fields.toList()}');
    log("File Data : ${formData.files.toString()}");
    // Convert the map to a JSON string
    // String jsonData1 = jsonEncode(formData.fields);

    // log('Json Data : $jsonData1');

    String url = ''; // Replace with backend URL

    Dio dio = Dio();

    try {
      // Send the data to the backend
      Response response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: formData,
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Data sent successfully');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }
}
