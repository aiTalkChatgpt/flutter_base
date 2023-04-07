///
/// <pre>
///     author : Wp
///     e-mail : 神州友创
///     time   : 2019/7/7 8:35 PM
///     desc   : 接口请求方法全局常量
///     version: 1.0
/// </pre>
///
class BaseApi {

  static  String BASE_URL = 'http://81.69.4.61:8085/mat/';//线上测试地址

  static  String BASE_UNIFY_APP_URL = 'http://81.69.4.61:8081/manage/';//一体化接口

  static const String upload = 'file/upload';

  ///上传头像
  static const String uploadAvatar = 'mobile/avatar';

  /// baseimgurl
  static String baseImgUrl = BaseApi.BASE_URL + 'profile';

  static String updateVersion = 'mobile/selectAppVersionByAppId';

  ///上报本地版本
  static String postVersion = BASE_UNIFY_APP_URL + 'mobile/appInfo/add';


  static const String  login = "login";
}
