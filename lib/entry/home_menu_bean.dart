/// data : [{"menuList":[{"menuIcon":null,"menuName":"APP到货验收","routerUrl":"mobile"},{"menuIcon":null,"menuName":"资产出库","routerUrl":"#"}],"menuParentTitle":"APP到货验收"},{"menuList":[{"menuIcon":null,"menuName":"APP物资领用","routerUrl":"#"}],"menuParentTitle":"APP物资领用"},{"menuList":[{"menuIcon":null,"menuName":"APP仓库查看","routerUrl":"#"}],"menuParentTitle":"APP仓库查看"},{"menuList":[{"menuIcon":null,"menuName":"APP物资类别查看","routerUrl":"#"}],"menuParentTitle":"APP物资类别查看"},{"menuList":[{"menuIcon":null,"menuName":"APP查询物资列表","routerUrl":"#"}],"menuParentTitle":"APP查询物资列表"},{"menuList":[{"menuIcon":null,"menuName":"APP货架管理","routerUrl":"#"}],"menuParentTitle":"APP货架管理"},{"menuList":[{"menuIcon":null,"menuName":"APP入库","routerUrl":"#"}],"menuParentTitle":"APP入库"},{"menuList":[{"menuIcon":null,"menuName":"APP资产盘点","routerUrl":"#"}],"menuParentTitle":"APP资产盘点"},{"menuList":[{"menuIcon":null,"menuName":"APP临时资产","routerUrl":"#"}],"menuParentTitle":"APP临时资产"},{"menuList":[{"menuIcon":null,"menuName":"APP审批","routerUrl":"#"}],"menuParentTitle":"APP审批"},{"menuList":[{"menuIcon":null,"menuName":"APP退库","routerUrl":"#"}],"menuParentTitle":"APP退库"},{"menuList":[{"menuIcon":null,"menuName":"资产出库","routerUrl":"#"}],"menuParentTitle":"资产出库"},{"menuList":[{"menuIcon":null,"menuName":"测试App菜单上传图片","routerUrl":""}],"menuParentTitle":"测试App菜单上传图片"},{"menuList":[{"menuIcon":null,"menuName":"测试App菜单上传图片2","routerUrl":""},{"menuIcon":null,"menuName":"测试App菜单上传图片4","routerUrl":""}],"menuParentTitle":"测试App菜单上传图片2"},{"menuList":[{"menuIcon":null,"menuName":"测试App菜单上传图片3","routerUrl":""}],"menuParentTitle":"测试App菜单上传图片3"}]

class HomeMenuBean {
  List<Data> _data;

  List<Data> get data => _data;

  HomeMenuBean({
      List<Data> data}){
    _data = data;
}

  HomeMenuBean.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// menuList : [{"menuIcon":null,"menuName":"APP到货验收","routerUrl":"mobile"},{"menuIcon":null,"menuName":"资产出库","routerUrl":"#"}]
/// menuParentTitle : "APP到货验收"

class Data {
  List<MenuList> _menuList;
  String _menuParentTitle;

  List<MenuList> get menuList => _menuList;
  String get menuParentTitle => _menuParentTitle;

  Data({
      List<MenuList> menuList, 
      String menuParentTitle}){
    _menuList = menuList;
    _menuParentTitle = menuParentTitle;
}

  Data.fromJson(dynamic json) {
    if (json["menuList"] != null) {
      _menuList = [];
      json["menuList"].forEach((v) {
        _menuList.add(MenuList.fromJson(v));
      });
    }
    _menuParentTitle = json["menuParentTitle"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_menuList != null) {
      map["menuList"] = _menuList.map((v) => v.toJson()).toList();
    }
    map["menuParentTitle"] = _menuParentTitle;
    return map;
  }

}

/// menuIcon : null
/// menuName : "APP到货验收"
/// routerUrl : "mobile"

class MenuList {
  dynamic _menuIcon;
  String _menuName;
  String _routerUrl;

  dynamic get menuIcon => _menuIcon;
  String get menuName => _menuName;
  String get routerUrl => _routerUrl;

  MenuList({
      dynamic menuIcon, 
      String menuName, 
      String routerUrl}){
    _menuIcon = menuIcon;
    _menuName = menuName;
    _routerUrl = routerUrl;
}

  MenuList.fromJson(dynamic json) {
    _menuIcon = json["menuIcon"];
    _menuName = json["menuName"];
    _routerUrl = json["routerUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["menuIcon"] = _menuIcon;
    map["menuName"] = _menuName;
    map["routerUrl"] = _routerUrl;
    return map;
  }

}