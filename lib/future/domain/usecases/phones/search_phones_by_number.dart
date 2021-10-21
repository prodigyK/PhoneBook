import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class SearchPhonesByNumberCase extends UseCase<List<PhoneEntity>, PhoneNameParams> {
  final PhoneRepository repository;

  SearchPhonesByNumberCase(this.repository);

  @override
  Future<Either<Failure, List<PhoneEntity>>> call(PhoneNameParams params) async {
    return await repository.searchNameByNumber(params.number);
  }
}

class PhoneNameParams extends Equatable {
  final String number;

  const PhoneNameParams({required this.number});

  @override
  List<Object> get props => [number];
}
