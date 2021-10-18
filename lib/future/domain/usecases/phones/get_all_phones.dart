import 'package:dartz/dartz.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class GetAllPhones extends UseCase<List<PhoneEntity>, PlugParams> {
  final PhoneRepository repository;

  GetAllPhones(this.repository);

  @override
  Future<Either<Failure, List<PhoneEntity>>> call(PlugParams params) async {
    return await repository.getAllPhones();
  }
}

class PlugParams {}
