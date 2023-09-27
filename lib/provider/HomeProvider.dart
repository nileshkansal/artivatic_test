import 'package:artivatic_test/model/HomeModel.dart';
import 'package:artivatic_test/model/HomeModel.dart' as hModel;
import 'package:artivatic_test/repository/APIRequest.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier implements ResponseListener {

  String TAG = "HomeProvider";
  TextEditingController controller = TextEditingController();
  bool showClose = false;
  HomeModel? model;
  List<hModel.Row> rows = [];

  // This function is used to set text form field empty
  void clearTextField() {
    controller.clear();
    setDataInRows();
    notifyListeners();
  }

  // This function is used to check text form field is empty or not
  void updateStatus() {
    showClose = controller.text.length >= 2;
    notifyListeners();
  }

  // This function is used to search by title in list
  void searchTitle(String value) {
    if(value == "") {
     setDataInRows();
    } else {
      debugPrint("$TAG search Title value ======> $value");
      if (model != null && model!.rows != null) {
        debugPrint("$TAG search Title model ========> ${model!.rows}");
        rows.clear();
        for (int i = 0; i < model!.rows!.length; i++) {
          debugPrint("$TAG search Title title =======> ${model!.rows![i].title.toString()}");
          if (model!.rows![i].title != null && model!.rows![i].title!.toString().toLowerCase().contains(value.toLowerCase())) {
            debugPrint("$TAG title =======> ${model!.rows![i].title.toString()}");
            rows.add(model!.rows![i]);
          }
        }
      } else {
        debugPrint("$TAG search Title ========> model is null");
      }
      debugPrint("$TAG search Title rows ========> ${rows.length.toString()}");
    }
    notifyListeners();
  }

  // This function is used to set data in list
  void updateHomeModel(Map<String, dynamic> response) {
    model = HomeModel.fromJson(response);
    setDataInRows();
    notifyListeners();
  }

  void setDataInRows() {
    if(model!.rows == null) {
      rows = [];
    } else {
      rows.clear();
      rows.addAll(model!.rows!);
    }
    notifyListeners();
  }

  // This function is used to set title in app bar
  String showTitle() {
    if(model == null) {
      return "";
    } else if(model != null && model!.title == null) {
      return "";
    } else {
      return model!.title.toString();
    }
  }

  // This function is used to implement API
  void callAPI() {
    final getRequest = APIRequest(listener: this);
    getRequest.getResponse();
  }

  // This function is used to show failed status after API call
  @override
  void onFailed(Map<String, dynamic> response) {
    debugPrint("$TAG failed to load");
  }

  // This function is used to show success status after API call
  @override
  void onSuccess(Map<String, dynamic> response) {
    debugPrint("$TAG response loaded ========> ${response.toString()}");
    updateHomeModel(response);
  }

}
