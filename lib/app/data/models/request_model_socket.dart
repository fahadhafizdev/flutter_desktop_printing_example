class RequestSocketModelResponse {
  String? requestId;
  String? status;
  String? type;
  Payload? payload;

  RequestSocketModelResponse(
      {this.requestId, this.status, this.type, this.payload});

  RequestSocketModelResponse.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    status = json['status'];
    type = json['type'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? type;
  Body? body;

  Payload({this.type, this.body});

  Payload.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  String? mime;
  String? name;
  String? content;
  bool? downloadable;

  Body({this.mime, this.name, this.content, this.downloadable});

  Body.fromJson(Map<String, dynamic> json) {
    mime = json['mime'];
    name = json['name'];
    content = json['content'];
    downloadable = json['downloadable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mime'] = this.mime;
    data['name'] = this.name;
    data['content'] = this.content;
    data['downloadable'] = this.downloadable;
    return data;
  }
}
