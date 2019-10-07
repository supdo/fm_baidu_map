import 'package:uuid/uuid.dart';
import './base.dart';
import './types.dart';

// 线标记
class FmMapOverlaysPolygon extends FmMapOverlays {
  FmMapOverlaysPolygon({
    this.id,
    this.layer = "0",
    this.points,
    this.visible = true,
    this.zIndex,
    this.fillColor,
    this.color,
    this.width,
  }) {
    if (id == null) {
      var uuid = new Uuid();
      id = uuid.v1();
    }
  }

  String id;
  String layer;
  bool visible;
  int zIndex;
  int fillColor;
  int color;
  int width;
  List<FmMapPoint> points;

  /// 删除标注
  @override
  Future remove() async {
    if (map != null) {
      await map.removeOverlays(id: id, layer: layer);
    }
  }

  @override
  Future setVisible(bool visible) async {
    if (map != null) {
      await map.setOverlaysVisible(id: id, layer: layer, visible: visible);
    }
  }

  @override
  Future setZIndex(int zIndex) async {
    if (map != null) {
      await map.setOverlaysZIndex(id: id, layer: layer, zIndex: zIndex);
    }
  }

  @override
  void fromMap(Map m) {
    if (!m.containsKey("id")) {
      var uuid = new Uuid();
      id = uuid.v1();
    }
    layer = m["layer"] ?? "0";
    visible = m["visible"] ?? true;
    zIndex = m["zIndex"];
    if (m.containsKey("points")) {
      points = [];
      m["points"].forEach((it) {
        points.add(
          FmMapPoint(latitude: it["latitude"], longitude: it["longitude"]),
        );
      });
    }
    color = m["color"];
    width = m["width"];
    fillColor = m["fillColor"];
  }

  // 转json
  @override
  Map toMap() {
    Map option = {
      "id": id,
      "type": "polygon",
      "layer": layer,
      "visible": visible,
      "fillColor": fillColor,
      "points": FmMapPoint.toList(points),
    };
    if (zIndex != null) {
      option["zIndex"] = zIndex;
    }
    if (color != null) {
      option["color"] = color;
    }
    if (width != null) {
      option["width"] = width;
    }
    return option;
  }
}
