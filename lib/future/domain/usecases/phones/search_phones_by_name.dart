import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/usecases/usecase.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class SearchPhonesByNameCase extends UseCase<List<PhoneEntity>, SearchQueryParams> {
  final PhoneRepository repository;

  SearchPhonesByNameCase(this.repository);

  @override
  Future<Either<Failure, List<PhoneEntity>>> call(params) async {
    return await repository.searchPhonesByName(params.query);
  }
}

class SearchQueryParams extends Equatable {
  final String query;

  const SearchQueryParams({required this.query});

  @override
  List<Object> get props => [query];
}
