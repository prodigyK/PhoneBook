import 'dart:convert';

import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/future/data/datasources/departments/department_local_data_source.dart';
import 'package:phone_book/future/data/models/department_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentLocalDataSourceImpl extends DepartmentLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String departmentList = 'DEPARTMENT_LIST';

  DepartmentLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<DepartmentModel>> getDepartmentsFromCache() async {
    final jsonList = sharedPreferences.getStringList(departmentList) ?? [];
    if (jsonList.isNotEmpty) {
      return jsonList.map((dep) => DepartmentModel.fromJson(json.decode(dep))).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<DepartmentModel> getDepartmentFromCacheById(String depId) async {
    final depList = await getDepartmentsFromCache();
    return depList.where((dep) => dep.depId == depId).first;
  }

  @override
  Future<void> saveDepartmentsToCache(List<DepartmentModel> departments) async {
    List<String> jsonList = departments.map((dep) => json.encode(dep.toJson())).toList();
    sharedPreferences.setStringList(departmentList, jsonList);
  }
}
