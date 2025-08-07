///
/// Created By Sambit <sambit@smartters.in> on 06-08-2025 at 10:46.
///

// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

List<MessageResponse> messageResponseFromJson(String str) => List<MessageResponse>.from(json.decode(str).map((x) => MessageResponse.fromJson(x)));

String messageResponseToJson(List<MessageResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageResponse {
  String? id;
  ChatId? chatId;
  SenderId? senderId;
  String? content;
  MessageType? messageType;
  List<dynamic>? deletedBy;
  Status? status;
  dynamic deliveredAt;
  DateTime? seenAt;
  List<SenderId>? seenBy;
  List<dynamic>? reactions;
  DateTime? sentAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  FileUrl? fileUrl;
  String? fileName;
  int? fileSize;
  Location? location;

  MessageResponse({
    this.id,
    this.chatId,
    this.senderId,
    this.content,
    this.messageType,
    this.deletedBy,
    this.status,
    this.deliveredAt,
    this.seenAt,
    this.seenBy,
    this.reactions,
    this.sentAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.fileUrl,
    this.fileName,
    this.fileSize,
    this.location,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    id: json["_id"],
    chatId: chatIdValues.map[json["chatId"]]!,
    senderId: senderIdValues.map[json["senderId"]]!,
    content: json["content"],
    messageType: messageTypeValues.map[json["messageType"]]!,
    deletedBy: json["deletedBy"] == null ? [] : List<dynamic>.from(json["deletedBy"]!.map((x) => x)),
    status: statusValues.map[json["status"]]!,
    deliveredAt: json["deliveredAt"],
    seenAt: json["seenAt"] == null ? null : DateTime.parse(json["seenAt"]),
    seenBy: json["seenBy"] == null ? [] : List<SenderId>.from(json["seenBy"]!.map((x) => senderIdValues.map[x]!)),
    reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
    sentAt: json["sentAt"] == null ? null : DateTime.parse(json["sentAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
     fileName: json["fileName"],
    fileSize: json["fileSize"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatId": chatIdValues.reverse[chatId],
    "senderId": senderIdValues.reverse[senderId],
    "content": content,
    "messageType": messageTypeValues.reverse[messageType],
    "deletedBy": deletedBy == null ? [] : List<dynamic>.from(deletedBy!.map((x) => x)),
    "status": statusValues.reverse[status],
    "deliveredAt": deliveredAt,
    "seenAt": seenAt?.toIso8601String(),
    "seenBy": seenBy == null ? [] : List<dynamic>.from(seenBy!.map((x) => senderIdValues.reverse[x])),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "sentAt": sentAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "fileUrl": fileUrlValues.reverse[fileUrl],
    "fileName": fileName,
    "fileSize": fileSize,
    "location": location?.toJson(),
  };
}

enum ChatId {
  THE_679_BBD688_C09_DF5_B75_CD1070
}

final chatIdValues = EnumValues({
  "679bbd688c09df5b75cd1070": ChatId.THE_679_BBD688_C09_DF5_B75_CD1070
});

enum FileUrl {
  EMPTY,
  VENDOR_31_JU_XY_PS_UCL_SX300_SY300_QL70_F_MWEBP_WEBP,
  VENDOR_MORGAN_HOUSEL_IU_SQWZ_G_ZV8_M_UNSPLASH_JPG
}

final fileUrlValues = EnumValues({
  "": FileUrl.EMPTY,
  "vendor/31JuXYPsUCL._SX300_SY300_QL70_FMwebp_.webp": FileUrl.VENDOR_31_JU_XY_PS_UCL_SX300_SY300_QL70_F_MWEBP_WEBP,
  "vendor/morgan-housel-iuSqwzGZv8M-unsplash.jpg": FileUrl.VENDOR_MORGAN_HOUSEL_IU_SQWZ_G_ZV8_M_UNSPLASH_JPG
});

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

enum MessageType {
  FILE,
  HI_IT_IS_VERY_NICE_TO_MEET,
  TEXT
}

final messageTypeValues = EnumValues({
  "file": MessageType.FILE,
  "Hi it is very nice to meet": MessageType.HI_IT_IS_VERY_NICE_TO_MEET,
  "text": MessageType.TEXT
});

enum SenderId {
  THE_673_D80_BC2330_E08_C323_F4393,
  THE_673_DBBF72330_E08_C323_F4818,
  THE_674197949_A892274_FC701686
}

final senderIdValues = EnumValues({
  "673d80bc2330e08c323f4393": SenderId.THE_673_D80_BC2330_E08_C323_F4393,
  "673dbbf72330e08c323f4818": SenderId.THE_673_DBBF72330_E08_C323_F4818,
  "674197949a892274fc701686": SenderId.THE_674197949_A892274_FC701686
});

enum Status {
  SEEN,
  SENT
}

final statusValues = EnumValues({
  "seen": Status.SEEN,
  "sent": Status.SENT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
