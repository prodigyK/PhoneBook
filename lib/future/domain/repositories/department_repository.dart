import 'package:dartz/dartz.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/department_entity.dart';

abstract class DepartmentRepository {
  Future<Either<Failure, List<DepartmentEntity>>> getAllDepartments();
  Future<Either<Failure, DepartmentEntity>> getDepartmentById(String id);
}
