import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class AddPhoneCase extends UseCase<String, AddPhoneParams> {
  final PhoneRepository repository;

  AddPhoneCase(this.repository);

  @override
  Future<Either<Failure, String>> call(AddPhoneParams params) async {
    return await repository.addPhone(params.phone);
  }
}

class AddPhoneParams extends Equatable {
  final PhoneEntity phone;

  const AddPhoneParams({required this.phone});

  @override
  List<Object> get props => [phone];
}
