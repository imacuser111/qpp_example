/// use for client api
class BaseClientResponse {
  final Map<String, dynamic> json;

  String get errorCode {
    return json['errorCode'];
  }

  const BaseClientResponse({required this.json});
}

// extension BaseResponseExtension on BaseClientResponse {
//   UserSelectInfoResponse get userSelectInfoResponse =>
//       UserSelectInfoResponse.fromJson(json);
// }
