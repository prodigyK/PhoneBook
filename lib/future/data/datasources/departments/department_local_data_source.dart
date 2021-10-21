import 'package:phone_book/future/data/models/department_model.dart';

abstract class DepartmentLocalDataSource {
  Future<List<DepartmentModel>> getDepartmentsFromCache();
  Future<DepartmentModel> getDepartmentFromCacheById(String depId);
  Future<void> saveDepartmentsToCache(List<DepartmentModel> departments);
}
