// class TffData {
//   String widgetType;
//   String label;
//   String hint;
//   String controller;
//   String keyBoard;
//   bool calendar;

//   TffData({
//     required this.widgetType,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     required this.keyBoard,
//     required this.calendar,
//   });

//   factory TffData.fromJson(Map<String, dynamic> json) {
//     return TffData(
//       widgetType: json['widgetType'],
//       label: json['label'],
//       hint: json['hint'],
//       controller: json['controller'],
//       keyBoard: json['keyBord'], // Corrected key name
//       calendar: json['calendar'],
//     );
//   }
// }

// class ImgData {
//   String widgetType;
//   String label;

//   String? image;
//   List<String>? images;

//   ImgData({
//     required this.widgetType,
//     required this.label,
//     this.image,
//     this.images,
//   });

//   factory ImgData.fromJson(Map<String, dynamic> json) {
//     return ImgData(
//       widgetType: json['widgetType'],
//       label: json['label'],
//       image: json['image'],
//       images: json['images'] != null ? List<String>.from(json['images']) : null,
//     );
//   }
// }

// class AdharFields {
//   bool status;
//   List<TffData> tffData;
//   List<ImgData> imgData;

//   AdharFields({
//     required this.status,
//     required this.tffData,
//     required this.imgData,
//   });

//   factory AdharFields.fromJson(Map<String, dynamic> json) {
//     List<dynamic> tffList = json['tffData'];
//     List<dynamic> imgList = json['imgData'];

//     List<TffData> parsedTffList =
//         tffList.map((data) => TffData.fromJson(data)).toList();
//     List<ImgData> parsedImgList =
//         imgList.map((data) => ImgData.fromJson(data)).toList();

//     return AdharFields(
//       status: json['status'],
//       tffData: parsedTffList,
//       imgData: parsedImgList,
//     );
//   }
// }

// class FormData {
//   AdharFields? adharFields;

//   FormData({
//     this.adharFields,
//   });

//   factory FormData.fromJson(Map<String, dynamic> json) {
//     return FormData(
//       adharFields: json['adharFields'] != null
//           ? AdharFields.fromJson(json['adharFields'])
//           : null,
//     );
//   }
// }

class TffData {
  String widgetType;
  String label;
  bool validation;
  String hint;
  String controller;
  String keyBoard;
  bool calendar;

  TffData({
    required this.widgetType,
    required this.label,
    required this.validation,
    required this.hint,
    required this.controller,
    required this.keyBoard,
    required this.calendar,
  });

  factory TffData.fromJson(Map<String, dynamic> json) => TffData(
        widgetType: json['widgetType'],
        label: json['label'],
        validation: json['validation'],
        hint: json['hint'],
        controller: json['controller'],
        keyBoard: json['keyBord'], // Corrected key name
        calendar: json['calendar'],
      );
}

class ImgData {
  String widgetType;
  String label;
  String? image;
  List<String>? images;

  ImgData({
    required this.widgetType,
    required this.label,
    this.image,
    this.images,
  });

  factory ImgData.fromJson(Map<String, dynamic> json) => ImgData(
        widgetType: json['widgetType'],
        label: json['label'],
        image: json['image'],
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
      );
}

class DropDownData {
  String widgetType;
  String label;
  String hint;
  String selectedOption;
  List<String> options;

  DropDownData({
    required this.widgetType,
    required this.label,
    required this.hint,
    required this.selectedOption,
    required this.options,
  });

  factory DropDownData.fromJson(Map<String, dynamic> json) => DropDownData(
        widgetType: json['widgetType'],
        label: json['label'],
        hint: json['hint'],
        selectedOption: json['selectedOption'],
        options: List<String>.from(json['options']),
      );
}

class AdharFields {
  bool status;
  List<TffData> tffData;
  List<ImgData> imgData;
  List<DropDownData> dropDown;

  AdharFields({
    required this.status,
    required this.tffData,
    required this.imgData,
    required this.dropDown,
  });

  factory AdharFields.fromJson(Map<String, dynamic> json) {
    List<dynamic> tffList = json['tffData'];
    List<dynamic> imgList = json['imgData'];
    List<dynamic> dropDownList = json['dropDown'];

    return AdharFields(
      status: json['status'],
      tffData: tffList.map((data) => TffData.fromJson(data)).toList(),
      imgData: imgList.map((data) => ImgData.fromJson(data)).toList(),
      dropDown:
          dropDownList.map((data) => DropDownData.fromJson(data)).toList(),
    );
  }
}

class AdharData {
  AdharFields? adharFields;

  AdharData({
    this.adharFields,
  });

  factory AdharData.fromJson(Map<String, dynamic> json) => AdharData(
        adharFields: json['adharFields'] != null
            ? AdharFields.fromJson(json['adharFields'])
            : null,
      );
}
