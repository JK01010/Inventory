
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/api_constant.dart';

Future<bool>testVesselURL(String url)async{
  try {
    Dio dio = Dio();
    GetStorage storage = GetStorage();
    var response = await dio.get(
      '$url/ApiGateway/_health',
    ).timeout(Duration(seconds: 60));
    log("Response code ${response.statusCode}");
    if (response.statusCode == 200) {
      storage.write('vesselURL', url);
      ApiConstant.baseUrl = url;
      return true;
    } else {
      return false;
    }
  }
  catch(e){
    return false;
  }
}