
import 'package:phone_book/future/data/models/department_model.dart';

abstract class DepartmentRemoteDataSource {
  Future<bool> add(DepartmentModel department);
  Future<bool> update(DepartmentModel department);
  Future<void> remove(DepartmentModel department);

  Future<List<DepartmentModel>> getAllDepartments();
  Future<DepartmentModel> getDepartmentById(String depId);
}
