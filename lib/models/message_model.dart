import 'package:flutter/cupertino.dart';

enum OwnerType { receiver, sender }

// 枚举类型在数据库中保存为string，取出是转成枚举
OwnerType _of(String name) {
  if (name == OwnerType.receiver.toString()) {
    return OwnerType.receiver;
  } else {
    return OwnerType.sender;
  }
}


class MessageModel {
  final int? id;

  // 为了避免添加数据的时候重新刷新的问题
  final GlobalKey key;

  // 消息发送方和接受方的标识，用于决定消息展示在哪一侧
  final OwnerType ownerType;

  // 发送方名称
  final String? ownerName;

  // 头像url
  final String? avatar;

  // 消息内容
  final String content;

  // milliseconds since
  final int createdAt;

  // 是否展示创建时间
  bool showCreatedTime = false;

  MessageModel({
    this.id,
    required this.ownerType,
    this.avatar,
    this.ownerName,
    required this.content,
    required this.createdAt,
  }) : key = GlobalKey();

  factory MessageModel.fromJson(Map<String, dynamic>json) =>
      MessageModel(
          id: json["id"],
          avatar: json["avatar"],
          ownerName: json["ownerName"],
          ownerType: _of(json["ownerType"]),
          content: json["content"],
          createdAt: json["createdAt"]);


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "ownerType": ownerType.toString(),
        "ownerName": ownerName,
        "createdAt": createdAt,
        "avatar": avatar,
        "content": content,
      };
}