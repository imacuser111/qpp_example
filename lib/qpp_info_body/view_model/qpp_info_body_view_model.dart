import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/user_select_info_response.dart';

class UserSelectInfoNotifier extends StateNotifier<ApiResponse<BaseResponse>> {
  UserSelectInfoNotifier(super.state);

  getUserInfo(int userID) {
    state = ApiResponse.loading();

    final request = UserSelectInfoRequest(userID);

    request.request(successCallBack: (data) {
      state = ApiResponse.completed(data);
    }, errorCallBack: (error) {
      state = ApiResponse.error(error);
    });
  }
}