import 'dart:convert';

import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/future/data/datasources/phone_local_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneLocalDataSourceImpl implements PhoneLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String phoneList = 'PHONE_LIST';

  PhoneLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PhoneModel>> getPhonesFromCache() {
    final stringList = sharedPreferences.getStringList(phoneList) ?? [];
    if (stringList.isNotEmpty) {
      return Future.value(stringList.map((string) => PhoneModel.fromJson(json.decode(string))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> savePhonesToCache(List<PhoneModel> phones) {
    final List<String> jsonPhones = phones.map((phone) => json.encode(phone.toJson())).toList();
    return sharedPreferences.setStringList(phoneList, jsonPhones);
  }
}
