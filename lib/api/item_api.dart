import 'package:dio/dio.dart' hide Headers;
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';

part 'item_api.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class ItemApi {
  factory ItemApi(Dio dio, {String baseUrl}) = _ItemApi;

  /// 商品列表資訊_查詢
  @POST("ItemSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<ItemSelectResponse> postItemSelect(@Body() itemIds);
}
