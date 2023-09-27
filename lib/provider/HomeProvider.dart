import 'package:artivatic_test/model/HomeModel.dart';
import 'package:artivatic_test/repository/APIRequest.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier implements ResponseListener {
  String TAG = "HomeProvider";
  TextEditingController controller = TextEditingController();
  bool showClose = false;
  HomeModel? model;

  void clearTextField() {
    controller.clear();
    notifyListeners();
  }

  void updateStatus() {
    showClose = controller.text.length > 2;
    notifyListeners();
  }

  void searchTitle(String value) {}

  void updateHomeModel(Map<String, dynamic> response) {
    model = HomeModel.fromJson(response);
    notifyListeners();
  }

  void callAPI() {
    final getRequest = APIRequest(listener: this);
    getRequest.getResponse();
  }

  @override
  void onFailed(Map<String, dynamic> response) {
    debugPrint("$TAG failed to load");
  }

  @override
  void onSuccess(Map<String, dynamic> response) {
    debugPrint("$TAG response loaded ========> ${response.toString()}");
    updateHomeModel(response);
  }
}
