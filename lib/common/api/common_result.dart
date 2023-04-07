///
/// <pre>
///     author : Wp
///     e-mail :
///     time   : 2019/7/7 8:35 PM
///     desc   : 通用返回数据解析类
///     version: 1.0
/// </pre>
///

class CommonResult {
	dynamic total;
	int code;
	dynamic data;
	String msg;

	CommonResult({this.total, this.code, this.data,this.msg});

	CommonResult.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		code = json['code'];
		data = json['data'];
		msg = json['msg'] ?? "";
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['code'] = this.code;
		data['data'] = this.data;
		data['msg'] = this.msg;
		return data;
	}
}
