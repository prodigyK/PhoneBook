import 'package:phone_book/future/domain/entities/phone_entity.dart';

class PhoneModel extends PhoneEntity {
  PhoneModel({
    required id,
    required name,
    required number,
    required depId,
    required isBoss,
    required createdAt,
  }) : super(
          id: id,
          name: name,
          number: number,
          depId: depId,
          isBoss: isBoss,
          createdAt: createdAt,
        );

  factory PhoneModel.fromJson(Map<String, dynamic> json, {String? docID}) {
    return PhoneModel(
      id: docID ?? '',
      name: json['name'],
      number: json['number'],
      depId: json['depId'],
      isBoss: json['isBoss'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'depId': depId,
      'isBoss': isBoss,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
