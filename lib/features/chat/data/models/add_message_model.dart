// To parserequired this JSON data, do
//
//     final addMessgaeModel = addMessgaeModelFromJson(jsonString);

import 'dart:convert';

import 'package:makanvi_web/features/chat/data/models/get_all_messages_model.dart';

AddMessageModel addMessgaeModelFromJson(String str) =>
    AddMessageModel.fromJson(json.decode(str));

class AddMessageModel {
  AddMessageModel({
    required this.message,
  });

  MessageAll message;

  factory AddMessageModel.fromJson(Map<String, dynamic> json) =>
      AddMessageModel(
        message: MessageAll.fromJson(json["message"]),
      );
}

// class MessageAddModel {
//   MessageAddModel({
//     required this.channelId,
//     required this.body,
//     required this.seen,
//     required this.senderId,
//     required this.receiverId,
//     required this.filePath,
//     required this.fileType,
//     required this.updatedAt,
//     required this.createdAt,
//     required this.id,
//   });

//   String channelId;
//   String body;
//   String seen;
//   int senderId;
//   int receiverId;
//   dynamic filePath;
//   dynamic fileType;
//   DateTime updatedAt;
//   DateTime createdAt;
//   int id;

//   factory MessageAddModel.fromJson(Map<String, dynamic> json) =>
//       MessageAddModel(
//         channelId: json["channel_id"],
//         body: json["body"],
//         seen: json["seen"],
//         senderId: json["sender_id"],
//         receiverId: json["receiver_id"],
//         filePath: json["file_path"],
//         fileType: json["file_type"],
//         updatedAt: DateTime.parse(json["updated_at"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         id: json["id"],
//       );

  // Map<String, dynamic> toJson() => {
  //       "channel_id": channelId,
  //       "body": body,
  //       "seen": seen,
  //       "sender_id": senderId,
  //       "receiver_id": receiverId,
  //       "file_path": filePath,
  //       "file_type": fileType,
  //       "updated_at": updatedAt.toIso8601String(),
  //       "created_at": createdAt.toIso8601String(),
  //       "id": id,
  //     };
// }
