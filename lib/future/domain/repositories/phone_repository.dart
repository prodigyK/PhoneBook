import 'package:dartz/dartz.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';

abstract class PhoneRepository {
  Future<Either<Failure, String>> addPhone(PhoneEntity phone);
  Future<Either<Failure, void>> updatePhone(PhoneEntity phone);
  Future<Either<Failure, void>> removePhone(PhoneEntity phone);

  Future<Either<Failure, List<PhoneEntity>>> getAllPhones();
  Future<Either<Failure, List<PhoneEntity>>> getPhonesByDepartment(String depId);
  Future<Either<Failure, List<PhoneEntity>>> searchPhonesByName(String query);
  Future<Either<Failure, List<PhoneEntity>>> searchNameByNumber(String number);
}
