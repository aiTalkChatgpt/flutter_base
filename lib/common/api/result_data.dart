
///
/// <pre>
///     author : Wp
///     e-mail : 神州友创
///     time   : 2019/7/7 8:35 PM
///     desc   : 返回数据传输
///     version: 1.0
/// </pre>
///
///
class ResultData {
  dynamic data;
  bool result;
  int code;
  dynamic total;
  dynamic headers;
  String msg;

  ResultData(this.data, this.result, this.code, this.total, {this.headers,this.msg});
}
