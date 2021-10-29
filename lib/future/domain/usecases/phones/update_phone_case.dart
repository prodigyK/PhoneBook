import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class UpdatePhoneCase extends UseCase<void, UpdatePhoneParams> {
  final PhoneRepository repository;

  UpdatePhoneCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdatePhoneParams params) async {
    return await repository.updatePhone(params.phone);
  }
}

class UpdatePhoneParams extends Equatable {
  final PhoneEntity phone;

  const UpdatePhoneParams({required this.phone});

  @override
  List<Object> get props => [phone];
}
