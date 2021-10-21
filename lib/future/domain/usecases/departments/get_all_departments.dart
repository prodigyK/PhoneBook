import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/department_entity.dart';
import 'package:phone_book/future/domain/repositories/department_repository.dart';

class GetAllDepartmentsCase extends UseCase<List<DepartmentEntity>, DepartmentIdParams> {
  final DepartmentRepository repository;

  GetAllDepartmentsCase(this.repository);

  @override
  Future<Either<Failure, List<DepartmentEntity>>> call(DepartmentIdParams params) async {
    return await repository.getAllDepartments();
  }
}

class DepartmentIdParams extends Equatable {
  final String id;

  DepartmentIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
