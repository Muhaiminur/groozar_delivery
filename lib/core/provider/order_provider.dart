import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grozaar_delivery/core/api/base_api_controller.dart';
import 'package:grozaar_delivery/model/order_response.dart';

import '../../model/order_details_response.dart';
import '../api/api_url.dart';
import '../api/interceptor.dart';
import '../singleton/logger.dart';
import '../utility/progressBar.dart';

class OrderProvider extends BaseApiController with ChangeNotifier {
  ///for api
  bool _isLoading = false;
  String _resMessage = '';
  int _statusCode = 0;
  int _workCode = 0;

  OrderResponse _orderResponse = OrderResponse();

  OrderResponse get orderResponse => _orderResponse;

  OrderResponse _currentOrderResponse = OrderResponse();

  OrderResponse get currentOrderResponse => _currentOrderResponse;

  OrderDetailsResponse? _orderDetailsResponse;

  OrderDetailsResponse? get orderDetailsResponse => _orderDetailsResponse;

  //Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  int get statusCode => _statusCode;

  int get workCode => _workCode;

  Future<OrderResponse> acceptedOrderCall() async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.get(ApiUrl.acceptedOrderUrl);
      if (response.statusCode == 200) {
        _orderResponse = OrderResponse.fromJson(response.data);
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return _orderResponse;
    } on DioException catch (e) {
      _resMessage = '';
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return OrderResponse();
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<OrderResponse> completedOrderCall() async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.get(ApiUrl.completeOrderListUrl);
      if (response.statusCode == 200) {
        _orderResponse = OrderResponse.fromJson(response.data);
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return _orderResponse;
    } on DioException catch (e) {
      _resMessage = '';
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return OrderResponse();
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<OrderResponse> currentOrderCall() async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.get(ApiUrl.currentOrderListUrl);
      if (response.statusCode == 200) {
        _currentOrderResponse = OrderResponse.fromJson(response.data);
      } else {
        final responseJson = json.decode(response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      }
      notifyListeners();
      return _currentOrderResponse;
    } on DioException catch (e) {
      _resMessage = '';
      final responseJson = json.decode(e.response.toString());
      Log().showMessageToast(message: responseJson["message"]);
      return OrderResponse();
    } finally {
      _isLoading = false; // Set loading flag to false
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<int> orderUpdateCall(String id, String status) async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.post(
        "${ApiUrl.orderUpdateUrl}$id/status-change",
        data: {"status": status},
      );
      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      try {
        _resMessage = e.toString();
        Log().printError(_resMessage);
        final responseJson = json.decode(e.response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      } on Exception catch (_) {
        Log().showMessageToast(message: AppInterceptors.handleError(e));
        rethrow;
      }
      notifyListeners();
      return e.response!.statusCode!;
    } finally {
      CustomProgressDialog.hide();
      _isLoading = false;
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<OrderDetailsResponse?> orderDetailsCall(String id) async {
    Future.delayed(Duration.zero, () async {
      CustomProgressDialog.show(message: "Loading", isDismissible: false);
    });
    try {
      final response = await getDio()!.get(
        "${ApiUrl.orderUpdateUrl}$id/details",
      );
      _orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);
      notifyListeners();
      return _orderDetailsResponse;
    } on DioException catch (e) {
      try {
        _resMessage = e.toString();
        Log().printError(_resMessage);
        final responseJson = json.decode(e.response.toString());
        Log().showMessageToast(message: responseJson["message"]);
      } on Exception catch (_) {
        Log().showMessageToast(message: AppInterceptors.handleError(e));
        rethrow;
      }
      notifyListeners();
      return OrderDetailsResponse();
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
