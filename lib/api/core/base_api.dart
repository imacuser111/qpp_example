import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

enum RequestMethod { get, post, put, delete, patch, copy, head }

abstract class BaseApi {
  RequestMethod get method;

  String get path;

  Map<String, String>? get header {
    switch (method) {
      case RequestMethod.post:
        return <String, String>{
          Headers.contentTypeHeader : Headers.jsonContentType
        };
      default:
        return null;
    }
  }

  Map<String, dynamic>? get query => null;

  Map<String, dynamic>? get body => null;

  void request({
    required Function(BaseResponse) successCallBack,
    required Function(String) errorCallBack,
  }) async {
    HttpService service = HttpService.instance;
    Dio dio = service.dio;

    Response? response;

    Map<String, String>? h = header;
    Map<String, dynamic>? q = query;
    Map<String, dynamic>? b = body;

    Map<String, dynamic>? queryParams = {};
    var globalQueryParams = service.serviceQuery();
    if (globalQueryParams != null) {
      queryParams.addAll(globalQueryParams);
    }
    if (q != null) {
      queryParams.addAll(q);
    }

    Map<String, dynamic>? headerParams = {};
    var globalHeaderParams = service.serviceHeader();
    if (globalHeaderParams != null) {
      headerParams.addAll(globalHeaderParams);
    }
    if (h != null) {
      headerParams.addAll(h);
    }

    Map<String, dynamic>? bodyParams = {};
    var globalBodyParams = service.serviceBody();
    if (globalBodyParams != null) {
      bodyParams.addAll(globalBodyParams);
    }
    if (b != null) {
      bodyParams.addAll(b);
    }

    String url = path;

    Options options = Options(headers: headerParams);

    dio.options.baseUrl = ServerConst.apiUrl;

    try {
      switch (method) {
        case RequestMethod.get:
          response = await dio.get(url,
              queryParameters: queryParams, options: options);
        case RequestMethod.post:
          response = await dio.post(url, data: bodyParams, options: options);
        case RequestMethod.head:
          dio.options.baseUrl = QppImageUtils.userImageUrl;
          response = await dio.head(url,
              queryParameters: queryParams, options: options);
        default:
          return;
      }
    } on DioException catch (error) {
      errorCallBack(service.errorFactory(error));
      return;
    }

    /// QPP圖片
    if (method == RequestMethod.head) {
      successCallBack(BaseResponse(json: response.headers.map));
      return;
    }

    if (response.data != null) {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      dataMap = service.responseFactory(dataMap);
      successCallBack(BaseResponse(json: dataMap));
    }
  }
}
