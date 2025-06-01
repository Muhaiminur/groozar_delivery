import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grozaar_delivery/core/api/base_api_controller.dart';

import '../../model/user_response.dart';
import '../api/api_url.dart';
import '../singleton/logger.dart';
import '../utility/progressBar.dart';

class AuthProvider extends BaseApiController with ChangeNotifier {
  ///for api
  bool _isLoading = false;
  String _resMessage = '';
  int _statusCode = 0;
  int _workCode = 0;

  UserResponse _logInResponse = UserResponse();

  UserResponse get logInResponse => _logInResponse;

  /*UserDetailsResponse _userDetailsResponse = UserDetailsResponse();

  UserDetailsResponse get userDetailsResponse => _userDetailsResponse;*/

  //Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  int get statusCode => _statusCode;

  int get workCode => _workCode;

  Future<int> signInCall({
    required String username,
    required String password,
  }) async {
    CustomProgressDialog.show(message: "Loading...", isDismissible: false);
    try {
      final response = await getDio()!.post(
        ApiUrl.signInUrl,
        data: {'login': username, 'password': password},
      );
      if (response.statusCode == 200) {
        _logInResponse = UserResponse.fromJson(response.data);
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      _resMessage = '';
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return e.response!.statusCode!;
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  /*Future<UserDetailsResponse> userDetailsCall() async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.get(ApiUrl.userDetailsUrl);
      if (response.statusCode == 200) {
        _userDetailsResponse = UserDetailsResponse.fromJson(response.data);
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return _userDetailsResponse;
    } on DioException catch (e) {
      _resMessage = '';
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return UserDetailsResponse();
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }*/

  Future<int?> userUpdateCall({
    String? username,
    String? phone,
    String? password,
    String? manNumber,
  }) async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final params = <String, dynamic>{};
      params["_method"] = "put";
      if (username != null && username.isNotEmpty) {
        params["first_name"] = username;
      }
      if (password != null && password.isNotEmpty) {
        params["password"] = password;
        params["password_confirmation"] = password;
      }
      if (phone != null && phone.isNotEmpty) {
        params["phone"] = phone;
      }
      if (manNumber != null && manNumber.isNotEmpty) {
        params["manager_phone"] = manNumber;
      }
      final response = await getDio()!.post(ApiUrl.userUpdateUrl, data: params);
      if (response.statusCode == 200) {
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return response.statusCode;
    } on DioException catch (e) {
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return e.response!.statusCode!;
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  void clear() {
    _resMessage = "";
    _isLoading = false;
    _statusCode = 0;
    _workCode = 0;
    notifyListeners();
  }
}
