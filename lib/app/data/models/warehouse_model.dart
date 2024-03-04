class WarehouseModelResponse {
  bool? success;
  String? requestId;
  Result? result;

  WarehouseModelResponse({this.success, this.requestId, this.result});

  WarehouseModelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    requestId = json['request_id'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['request_id'] = requestId;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  Pagination? pagination;
  List<WarehouseModel>? data;

  Result({this.pagination, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <WarehouseModel>[];
      json['data'].forEach((v) {
        data!.add(WarehouseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? totalCount;
  int? pageCount;
  int? page;
  int? perPage;

  Pagination({this.totalCount, this.pageCount, this.page, this.perPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    page = json['page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['page_count'] = pageCount;
    data['page'] = page;
    data['per_page'] = perPage;
    return data;
  }
}

class WarehouseModel {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? phone;
  var facility;
  int? price;
  String? status;
  String? createdAt;
  String? updatedAt;

  WarehouseModel(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.phone,
      this.facility,
      this.price,
      this.status,
      this.createdAt,
      this.updatedAt});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    phone = json['phone'];
    facility = json['facility'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['phone'] = phone;
    data['facility'] = facility;
    data['price'] = price;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
