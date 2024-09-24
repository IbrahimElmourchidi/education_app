import 'dart:convert';

import 'package:education_app/src/core/utils/typedef.dart';
import 'package:education_app/src/features/authentication/data/models/user_model.dart';
import 'package:education_app/src/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test("should be a sub class of the [User] entity", () {
    // arrange : already above [tModel]
    // act : no act needed here

    // assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json')
      .replaceAll('\n', '')
      .replaceAll('\r', '')
      .replaceAll('  ', '');
  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test('Should return a [UserModel] with the right data', () {
      //arrange : already above [tJson, tMap]
      //act
      final result = UserModel.fromMap(tMap);
      // assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test('Should return a [UserModel] with the right data', () {
      //arrange : already above [tJson, tMap]
      //act
      final result = UserModel.fromJson(tJson);
      // assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test('should return a [Map] with the right data', () {
      //arrange : already above [tJson, tMap]
      //act
      final result = tModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test('should return a [json] with the right data', () {
      //arrange : already above [tJson, tMap]
      //act
      final result = tModel.toJson();
      // assert
      expect(result, equals('{"id":"","createdAt":"","name":"","avatar":""}'));
    });
  });

  group("copyWith", () {
    test('Should return a [UserModel] with the different data', () {
      //arrange : already above [tJson, tMap]
      //act
      final result = tModel.copyWith(name: 'Hema');
      // assert
      expect(result.name, equals('Hema'));
      expect(result.avatar, equals(tModel.avatar));
      expect(result.createdAt, equals(tModel.createdAt));
      expect(result.id, equals(tModel.id));
    });
  });
}
