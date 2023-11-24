// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      expiredTimestamp: json['expiredTimestamp'] as String?,
      refreshTokenTimestamp: json['refreshTokenTimestamp'] == null
          ? null
          : DateTime.parse(json['refreshTokenTimestamp'] as String),
      vendorToken: json['vendorToken'] as String,
      uid: json['uid'] as String,
      uidImage: json['uidImage'] as String,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'expiredTimestamp': instance.expiredTimestamp,
      'refreshTokenTimestamp':
          instance.refreshTokenTimestamp?.toIso8601String(),
      'vendorToken': instance.vendorToken,
      'uid': instance.uid,
      'uidImage': instance.uidImage,
    };
