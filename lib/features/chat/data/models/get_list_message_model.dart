// To parse this JSON data, do
//
//     final getChatListModel = getChatListModelFromJson(jsonString);

import 'dart:convert';

GetChatListModel getChatListModelFromJson(String str) =>
    GetChatListModel.fromJson(json.decode(str));

String getChatListModelToJson(GetChatListModel data) =>
    json.encode(data.toJson());

class GetChatListModel {
  GetChatListModel({
    required this.me,
    required this.channels,
  });

  Me me;
  List<Channel> channels;

  factory GetChatListModel.fromJson(Map<String, dynamic> json) =>
      GetChatListModel(
        me: Me.fromJson(json["me"]),
        channels: List<Channel>.from(
            json["channels"].map((x) => Channel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "me": me.toJson(),
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
      };
}

class Channel {
  Channel({
    required this.chatWith,
    required this.onChannelId,
    required this.lastMsg,
    required this.unseenCount,
  });

  Me chatWith;
  int onChannelId;
  LastMsg lastMsg;
  int unseenCount;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        chatWith: Me.fromJson(json["chat_with"]),
        onChannelId: json["on_channel_id"],
        lastMsg: LastMsg.fromJson(json["last_msg"]),
        unseenCount: json["unseen_count"],
      );

  Map<String, dynamic> toJson() => {
        "chat_with": chatWith.toJson(),
        "on_channel_id": onChannelId,
        "last_msg": lastMsg.toJson(),
        "unseen_count": unseenCount,
      };
}

class Me {
  Me({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoPath,
  });

  int id;
  String name;
  String email;
  dynamic profilePhotoPath;

  factory Me.fromJson(Map<String, dynamic> json) => Me(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profilePhotoPath: json["profile_photo_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_photo_path": profilePhotoPath,
      };
}

class LastMsg {
  LastMsg({
    required this.id,
    required this.channelId,
    required this.body,
    this.property,
    required this.senderId,
    required this.receiverId,
    this.time,
  });

  int id;
  int channelId;
  String body;
  dynamic property;
  int senderId;
  int receiverId;
  String? time;
  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
        id: json["id"],
        channelId: json["channel_id"],
        body: json["body"] ?? "",
        property: json["property"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        time: json["since"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel_id": channelId,
        "body": body,
        "property": property,
        "sender_id": senderId,
        "receiver_id": receiverId,
      };
}
