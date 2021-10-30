import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class RemovePhoneCase extends UseCase<void, RemovePhoneParams> {
  final PhoneRepository repository;

  RemovePhoneCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(RemovePhoneParams params) async {
    return await repository.removePhone(params.phone);
  }
}

class RemovePhoneParams extends Equatable {
  final PhoneEntity phone;

  const RemovePhoneParams({required this.phone});

  @override
  List<Object> get props => [phone];
}
