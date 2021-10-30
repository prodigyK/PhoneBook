import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';

List<PhoneEntity> phones = [
  PhoneModel(
      id: '',
      name: 'Somebody',
      number: '123',
      depId: '1000',
      isBoss: false,
      createdAt: DateTime.parse('2021-04-01T19:19:15.761'),
      ordering: '101'),
  PhoneModel(
      id: '',
      name: 'Ivan Ivanov',
      number: '232',
      depId: '1000',
      isBoss: false,
      createdAt: DateTime.parse('2021-04-01T19:19:15.761'),
      ordering: '102')
];
