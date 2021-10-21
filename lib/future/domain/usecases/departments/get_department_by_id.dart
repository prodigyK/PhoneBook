import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/department_entity.dart';
import 'package:phone_book/future/domain/repositories/department_repository.dart';

class GetDepartmentByIdCase extends UseCase<DepartmentEntity, DepartmentParams> {
  final DepartmentRepository repository;

  GetDepartmentByIdCase(this.repository);

  @override
  Future<Either<Failure, DepartmentEntity>> call(DepartmentParams params) async {
    return await repository.getDepartmentById(params.id);
  }
}

class DepartmentParams extends Equatable {
  final String id;

  DepartmentParams({required this.id});

  @override
  List<Object> get props => [id];
}
