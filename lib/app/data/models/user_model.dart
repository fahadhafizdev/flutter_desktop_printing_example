import 'warehouse_model.dart';

class UserModelResponse {
  bool? success;
  String? requestId;
  UserModel? userModel;

  UserModelResponse({this.success, this.requestId, this.userModel});

  UserModelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    requestId = json['request_id'];
    userModel =
        json['result'] != null ? UserModel.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['request_id'] = requestId;
    if (userModel != null) {
      data['result'] = userModel!.toJson();
    }
    return data;
  }
}

class UserModel {
  Address? address;
  String? id;
  String? name;
  String? email;
  String? phone;
  String? status;
  String? lastLoginAt;
  String? createdAt;
  String? updatedAt;
  bool? fastPrint;
  Role? role;
  WarehouseModel? warehouse;
  Avatar? avatar;

  UserModel(
      {this.address,
      this.id,
      this.name,
      this.email,
      this.phone,
      this.status,
      this.lastLoginAt,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.fastPrint,
      this.warehouse,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    lastLoginAt = json['last_login_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fastPrint = json['fast_print'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    warehouse = json['warehouse'] != null
        ? WarehouseModel.fromJson(json['warehouse'])
        : null;
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    data['last_login_at'] = lastLoginAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (warehouse != null) {
      data['warehouse'] = warehouse!.toJson();
    } else {
      warehouse = WarehouseModel(id: '', name: '');
    }
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['warehouse_id'] = warehouse!.id!;
    data['role_id'] = role!.id;
    return data;
  }
}

class Address {
  String? areaCode;
  String? label;
  String? line1;
  String? line2;
  String? full;
  String? postcode;
  String? latitude;
  String? longitude;

  Address(
      {this.areaCode,
      this.label,
      this.line1,
      this.line2,
      this.full,
      this.postcode,
      this.latitude,
      this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    areaCode = json['area_code'];
    label = json['label'];
    line1 = json['line1'];
    line2 = json['line2'];
    full = json['full'];
    postcode = json['postcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_code'] = areaCode;
    data['label'] = label;
    data['line1'] = line1;
    data['line2'] = line2;
    data['full'] = full;
    data['postcode'] = postcode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Role {
  String? id;
  String? name;
  String? permissions;

  Role({this.id, this.name, this.permissions});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    permissions = json['permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['permissions'] = permissions;
    return data;
  }
}

class Avatar {
  String? id;
  String? original;
  String? thumb;

  Avatar({this.id, this.original, this.thumb});

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    original = json['original'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['original'] = original;
    data['thumb'] = thumb;
    return data;
  }
}
