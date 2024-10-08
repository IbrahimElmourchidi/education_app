import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required super.avatar,
    required super.createdAt,
    required super.id,
    required super.name,
  });

  const UserModel.empty() : this(id: '', createdAt: '', name: '', avatar: '');

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
