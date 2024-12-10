class RealTimeRecognitionModel {
  Rect? rect;
  double? confidenceInClass;
  String? detectedClass;

  RealTimeRecognitionModel(
      {this.rect, this.confidenceInClass, this.detectedClass});

  RealTimeRecognitionModel.fromJson(Map json) {
    rect = json['rect'] != null ? new Rect.fromJson(json['rect']) : null;
    confidenceInClass = json['confidenceInClass'];
    detectedClass = json['detectedClass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    if (this.rect != null) {
      data['rect'] = this.rect!.toJson();
    }
    data['confidenceInClass'] = this.confidenceInClass;
    data['detectedClass'] = this.detectedClass;
    return data;
  }
}

class Rect {
  double? w;
  double? x;
  double? h;
  double? y;

  Rect({this.w, this.x, this.h, this.y});

  Rect.fromJson(Map json) {
    w = json['w'];
    x = json['x'];
    h = json['h'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['w'] = this.w;
    data['x'] = this.x;
    data['h'] = this.h;
    data['y'] = this.y;
    return data;
  }
}
