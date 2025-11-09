import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  friendRequests,
  friendRequestsAccepted,
  friendRequestsRejected,
  newMessages,
  friendRemoved,
}

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.data = const {},
    this.isRead = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.name,
      'data': data,
      'isRead': isRead,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  static NotificationModel fromMap(Map<String, dynamic> map) {
    int toMillis(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is Timestamp) return value.millisecondsSinceEpoch;
      if (value is DateTime) return value.millisecondsSinceEpoch;
      return 0;
    }

    return NotificationModel(
      id: map['id'] ?? "",
      userId: map['userId'] ?? "",
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      type: NotificationType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => NotificationType.newMessages,
      ),
      data: Map<String, dynamic>.from(map['data'] ?? {}),
      isRead: map['isRead'] ?? false,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(toMillis(map['createdAt'])),
    );
  }
}
