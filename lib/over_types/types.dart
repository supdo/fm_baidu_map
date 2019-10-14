// 坐标点
class FmMapPoint {
  FmMapPoint({this.latitude, this.longitude});
  // 经度
  double latitude;
  // 纬度
  double longitude;
  // 是否有效
  bool isValid() {
    if (latitude == null || longitude == null) {
      return false;
    }
    if (latitude < 1 || latitude > 1000 || longitude < 1 || longitude > 1000) {
      return false;
    }
    return true;
  }

  // 数组转Map
  static List<Map> toList(List<FmMapPoint> list) {
    List<Map> m = [];
    list.forEach((it) {
      m.add({"latitude": it.latitude, "longitude": it.longitude});
    });
    return m;
  }
}

// 定位信息
class FmBaiduLocationInfo {
  // Baidu
  String coordType;
  int time;
  // 速度
  double speed;
  // 海拔
  double altitude;
  // 经纬度
  FmMapPoint point;
  // 方向
  double bearing;

  double radius;

  int locType;
  String locTypeDesc;
  String locTypeDescCN;

  /// 从map初始化
  void fronMap(Map m) {
    coordType = m["coordType"];
    time = m["time"];
    speed = m["speed"];
    point = FmMapPoint();
    // 经度
    point.latitude = m["latitude"];
    // 纬度
    point.longitude = m["longitude"];
    // 海拔
    altitude = m["altitude"];
    bearing = m["bearing"];
    radius = m["radius"];
    locType = m["locType"];
    locTypeDesc = m["locTypeDesc"];
    switch(locType) {
      case 61:
//        this.setLocTypeDescription("Location failed beacuse we can not get any loc information!");
        locTypeDescCN = "GPS定位成功。";
        break;
      case 62:
//        this.setLocTypeDescription("Location failed beacuse we can not get any loc information!");
        locTypeDescCN = "定位失败，请检查GPS。";
        break;
      case 63:
      case 67:
//        this.setLocTypeDescription("Offline location failed, please check the net (wifi/cell)!");
        locTypeDescCN = "定位失败，请检查WIFI或网络。";
        break;
      case 66:
//        this.setLocTypeDescription("Offline location successful!");
        locTypeDescCN = "离线定位成功！";
        break;
      case 161:
//        this.setLocTypeDescription("NetWork location successful!");
        locTypeDescCN = "网络定位成功！";
        break;
      case 162:
//        this.setLocTypeDescription("NetWork location failed because baidu location service can not decrypt the request query, please check the so file !");
        locTypeDescCN = "NetWork location failed because baidu location service can not decrypt the request query, please check the so file ！";
        break;
      case 167:
//        this.setLocTypeDescription("NetWork location failed because baidu location service can not caculate the location!");
        locTypeDescCN = "NetWork location failed because baidu location service can not caculate the location！";
        break;
      case 505:
//        this.setLocTypeDescription("NetWork location failed because baidu location service check the key is unlegal, please check the key in AndroidManifest.xml!");
        locTypeDescCN = "NetWork location failed because baidu location service check the key is unlegal, please check the key in AndroidManifest.xml!";
        break;
      default:
//        this.setLocTypeDescription("UnKnown!");
        locTypeDescCN = "未知错误。";
    }
  }

  /// 从map创建
  static FmBaiduLocationInfo create(Map m) {
    return FmBaiduLocationInfo()..fronMap(m);
  }
}

// 地图状态信息
class FmMapStatusInfo {
  // 坐标点
  FmMapPoint point;
  // 缩放
  double zoom;
  // 俯瞰
  double overlook;
  // 转角
  double rotate;
  // 屏幕坐标
  int screenX;
  int screenY;
  //手势
  int gesture;

  // 从map初始化
  void fromMap(Map m) {
    // 坐标点
    point = FmMapPoint();
    // 经度
    point.latitude = m["latitude"];
    // 纬度
    point.longitude = m["longitude"];
    zoom = m["zoom"];
    overlook = m["overlook"];
    rotate = m["rotate"];
    // 屏幕坐标
    screenX = m["screenX"];
    screenY = m["screenY"];
    //手势
    gesture = m["gesture"];
  }

  // 创建地图状态信息
  static FmMapStatusInfo create(Map m) {
    return FmMapStatusInfo()..fromMap(m);
  }
}
