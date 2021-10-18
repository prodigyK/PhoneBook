import 'package:equatable/equatable.dart';

class PhoneEntity extends Equatable {
  final String id;
  final String name;
  final String number;
  final String depId;
  final bool isBoss;
  final DateTime createdAt;

  const PhoneEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.depId,
    required this.isBoss,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, number, depId, isBoss, createdAt];
}
