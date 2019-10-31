import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './config.dart';
import 'paypal.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<AuthModel> authWithPaypal() async {
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$ClIENT_ID:$SECRET'));
  Map<String, String> headers = <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": basicAuth
  };
  Map<String, String> body = <String, String>{
    "grant_type": "client_credentials"
  };

  var response = await http.post(PAYPAL_AUTH_URL, headers: headers, body: body);

  Map jsonResponse = jsonDecode(response.body);
  AuthModel authModel = AuthModel.fromJson(jsonResponse);

  return authModel;
}

Future<OrderDetail> makeOrder(String token, String amount) async {
  Map<String, String> headers = <String, String>{
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  Map<String, dynamic> body = {
    "intent": "CAPTURE",
    "purchase_units": [
      {
        "amount": {"currency_code": "USD", "value": amount}
      }
    ],
    "application_context": {
      "return_url": "https://code-sajad.com",
      "cancel_url": "https://google.com"
    }
  };


  var response = await http.post(PAYPAL_CREATE_ORDER_URL, headers: headers, body: jsonEncode(body));
  Map jsonResponse = jsonDecode(response.body);

  OrderDetail orderDetail = OrderDetail.fromJson(jsonResponse);
  return orderDetail;

}

captureOrder() async {

}
