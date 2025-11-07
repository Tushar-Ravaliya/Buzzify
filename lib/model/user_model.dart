import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String photoUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl = "",
     this.isOnline = false,
    required this.lastSeen,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
      // Store as milliseconds to avoid Timestamp/int mismatch
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
  static UserModel fromMap(Map<String, dynamic> map) {
    int toMillis(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is Timestamp) return value.millisecondsSinceEpoch;
      if (value is DateTime) return value.millisecondsSinceEpoch;
      return 0;
    }
    return UserModel(
      id: map['id'] ?? "",
      email: map['email'] ?? "",
      displayName: map['displayName'] ?? "",
      photoUrl: map['photoUrl'] ?? "",
      isOnline: map['isOnline'] ?? false,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(toMillis(map['lastSeen'])),
      createdAt: DateTime.fromMillisecondsSinceEpoch(toMillis(map['createdAt']))
    );
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
