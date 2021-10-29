import 'package:phone_book/future/data/models/phone_model.dart';

abstract class PhoneRemoteDataSource {
  Future<String> addPhone(PhoneModel phone);
  Future<void> updatePhone(PhoneModel phone);
  Future<void> removePhone(PhoneModel phone);

  Future<List<PhoneModel>> getAllPhones();
  Future<List<PhoneModel>> getPhonesByDepartment(String depId);
  Future<List<PhoneModel>> searchPhonesByName(String query);
  Future<List<PhoneModel>> searchNameByNumber(String number);
}

