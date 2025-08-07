// To parse this JSON data, do
//
//     final genderResponse = genderResponseFromJson(jsonString);

import 'dart:convert';

GenderResponse genderResponseFromJson(String str) => GenderResponse.fromJson(json.decode(str));

String genderResponseToJson(GenderResponse data) => json.encode(data.toJson());

class GenderResponse {
  int? total;
  int? limit;
  int? skip;
  List<Datum>? data;

  GenderResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  factory GenderResponse.fromJson(Map<String, dynamic> json) => GenderResponse(
    total: json["total"],
    limit: json["limit"],
    skip: json["skip"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "skip": skip,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? createdBy;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.createdBy,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    createdBy: json["created_by"],
    status: json["status"],
    type: json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_by": createdBy,
    "status": status,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
