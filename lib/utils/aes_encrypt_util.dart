import 'package:encrypt/encrypt.dart';


///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 5/25/22 11:02 PM
///     desc   : 加密解密
///     version: v1.0
/// </pre>
///

String keyAes = "1234567890adbcde";
String ivAes  = "1234567890hjlkew";

//String keyAes = "sN1DEJAVZNf3OdM3";
//String ivAes = "GDHgt7hbKpsIR4b4";



///
/// aes加密
///
String aesEncode(String content){
  try {
    final key = Key.fromUtf8(keyAes);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(content, iv: IV.fromUtf8(ivAes));
    return encrypted.base64;
  } catch (err) {
    print("aes encode error:$err");
    return content;
  }
}

///
/// aes解密
///
dynamic aesDecode(dynamic base64) {
  try {
    final key = Key.fromUtf8(keyAes);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt64(base64, iv: IV.fromUtf8(ivAes));
  } catch (err) {
    print("aes decode error:$err");
    return base64;
  }
}