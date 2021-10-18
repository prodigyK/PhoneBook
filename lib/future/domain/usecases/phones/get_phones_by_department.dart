import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class GetPhonesByDepartment extends UseCase<List<PhoneEntity>, DepartmentIdParams> {
  final PhoneRepository repository;

  GetPhonesByDepartment(this.repository);

  @override
  Future<Either<Failure, List<PhoneEntity>>> call(DepartmentIdParams params) async {
    return await repository.getPhonesByDepartment(params.id);
  }
}

class DepartmentIdParams extends Equatable {
  final String id;

  const DepartmentIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
