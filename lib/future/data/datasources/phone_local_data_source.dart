import 'package:phone_book/future/data/models/phone_model.dart';

abstract class PhoneLocalDataSource {
  /// Throws [CacheException] if no cached data is present

  Future<List<PhoneModel>> getPhonesFromCache();
  Future<void> savePhonesToCache(List<PhoneModel> phones);
}