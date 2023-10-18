import 'dart:convert';
import 'package:crypto/crypto.dart';

extension CryptoExtension on String {
  String get _uidPrefix => "BIGEYES::QPP";

  // String get _aesPrefix => "wanin::";

  // String get _aesSCAPPPrefix => "SCAPP::";

  Digest get getSha256 {
    var bytes1 = utf8.encode(this); // data being hashed
    var digest1 = sha256.convert(bytes1); // Hashing Process
    return digest1;
  }

  String get hashUID {
    return (_uidPrefix + this).getSha256.toString().toUpperCase();
  }
}
