class UpdateVersionEntity {
	String updateInfo;
	String appId;
	String downloadUrl;
	String id;
	String isForce;
	int versionCode;

	UpdateVersionEntity({this.updateInfo, this.appId, this.downloadUrl, this.id, this.isForce, this.versionCode});

	UpdateVersionEntity.fromJson(Map<String, dynamic> json) {
		updateInfo = json['updateInfo'];
		appId = json['appId'];
		downloadUrl = json['downloadUrl'];
		id = json['id'];
		isForce = json['isForce'];
		versionCode = json['versionCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['updateInfo'] = this.updateInfo;
		data['appId'] = this.appId;
		data['downloadUrl'] = this.downloadUrl;
		data['id'] = this.id;
		data['isForce'] = this.isForce;
		data['versionCode'] = this.versionCode;
		return data;
	}
}
