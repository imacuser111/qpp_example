import 'package:dio/dio.dart' hide Headers;
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_description_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_intro_link_select.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';

part 'item_api.g.dart';

@RestApi(baseUrl: ServerConst.apiUrl)
abstract class ItemApi {
  factory ItemApi(Dio dio, {String baseUrl}) = _ItemApi;

  /// 商品列表資訊_查詢
  @POST("ItemSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<ItemSelectInfoResponse> postItemSelect(@Body() itemIds);

  /// 商品多語系說明資訊_查詢
  @POST("MultiLanguageItemDescriptionSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<MultiLanguageItemDescriptionSelectInfoResponse>
      postMultiLanguageItemDescriptionSelect(@Body() itemId);

  /// 商品多語系說明資訊_查詢
  @POST("MultiLanguageItemIntroLinkSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<MultiLanguageItemIntroLinkSelectInfoResponse>
      postMultiLanguageItemIntroLinkSelect(@Body() itemId);
}
