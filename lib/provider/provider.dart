import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dynamic_textformfield/service/service.dart';
import 'package:dynamic_textformfield/model/sample_model.dart';
import 'package:intl/intl.dart';

class SampleProvider extends ChangeNotifier {
  SampleProvider() {
    fetchDataAadhar();
  }

  SampleService sampleService = SampleService();
  AdharData? formData;

  //Text Form Field data *******************************************************

  List<TffData> textFormFields = [];
  final List<TextEditingController> _controllers = [];
  List<TextEditingController> get controllers => _controllers;

  void getTffDatas() {
    if (formData == null) return;
    textFormFields = formData!.adharFields!.tffData;
    notifyListeners();
  }

  void initializeControllers() {
    _controllers.clear();
    for (var field in textFormFields) {
      _controllers.add(TextEditingController(text: field.controller));
    }
    notifyListeners();
  }

  void updateController(int index, String newValue) {
    if (index < _controllers.length) {
      _controllers[index].text = newValue;
      textFormFields[index].controller = newValue;
      notifyListeners();
    }
  }

  String? validateText(String? value, int index) {
    if (value == null || value.isEmpty) {
      return 'Please Enter ${textFormFields[index].label}';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  void showDatePicker(BuildContext context, int index) {
    final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  String date = _dateFormatter.format(newDate).toString();
                  controllers[index].text = date;
                },
                mode: CupertinoDatePickerMode.date,
              ),
            ),
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
// DropDown Data *****************************************************************

  List<DropDownData> dropdownFields = [];
  List<String> selectedOptions = [];

  void getDropdownDatas() {
    if (formData == null) return;
    dropdownFields = formData!.adharFields!.dropDown;
    initializeDropdown();
    notifyListeners();
  }

  void initializeDropdown() {
    // dropdownFields.clear();
    for (var field in dropdownFields) {
      selectedOptions.add(field.selectedOption);
      log('selectedOption = $selectedOptions');
    }
    notifyListeners();
  }

  void updateDropdown(int index, String? newValue) {
    if (newValue == null) return;

    if (index < dropdownFields.length) {
      selectedOptions[index] = newValue;

      log('Drop down value : $selectedOptions');
      notifyListeners();
    }
  }

// single image and multy image ***********************************************

  bool uploadImage = false;
  List<ImgData> imageFields = [];
  List<File?> localImg = [];
  File? localOneImg;

  void getImageDatas() {
    if (formData == null) return;
    imageFields = formData!.adharFields!.imgData;
    notifyListeners();
  }

  Future<void> pickOneFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      uploadImage = true;
      localOneImg = File(result.files.single.path!);
      notifyListeners();
    }
  }

  Future<void> pickMultyFiles() async {
    // imageFields[index].images!.clear();

    notifyListeners();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      uploadImage = true;
      localImg.add(File(result.files.single.path!));
      log(localImg.first.toString());
      notifyListeners();
    }
  }

//Fetching the data from backend **********************************************
  Future<void> fetchDataAadhar() async {
    final result = await sampleService.fetchAadhar();

    if (result != null) {
      formData = result;
      notifyListeners();

      getTffDatas();
      getImageDatas();
      getDropdownDatas();
      initializeControllers();
    }
  }

  //Senting the data to back end **********************************************

  Future<void> sentDatas() async {
    List<String> controller = [];
    for (var field in _controllers) {
      controller.add(field.text);
    }

    List<String> images = [];

    // for (var element in localImg) {
    //   String image = element!.split('/').last;
    //   images.add(image);
    // }

    // String? image = localOneImg?.split('/').last;

    final result = await sampleService.sendDataToBackend(
        controller, selectedOptions,
        image: localOneImg, images: localImg);
  }
}
