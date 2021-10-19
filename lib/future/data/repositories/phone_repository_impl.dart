import 'package:dartz/dartz.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/phone_local_data_source.dart';
import 'package:phone_book/future/data/datasources/phone_remote_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';

class PhoneRepositoryImpl implements PhoneRepository {
  PhoneRemoteDataSource phoneRemoteDataSource;
  PhoneLocalDataSource phoneLocalDataSource;
  NetworkInfo networkInfo;

  PhoneRepositoryImpl({
    required this.phoneRemoteDataSource,
    required this.phoneLocalDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, List<PhoneEntity>>> _getPhones(Future<List<PhoneModel>> Function() getPhones) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePhones = await getPhones();
        phoneLocalDataSource.savePhonesToCache(remotePhones);
        return Right(remotePhones);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPhones = await phoneLocalDataSource.getPhonesFromCache();
        return Right(localPhones);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> getAllPhones() async {
    return _getPhones(() => phoneRemoteDataSource.getAllPhones());
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> getPhonesByDepartment(String depId) async {
    return _getPhones(() => phoneRemoteDataSource.getPhonesByDepartment(depId));
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> searchNameByNumber(String number) {
    return _getPhones(() => phoneRemoteDataSource.searchNameByNumber(number));
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> searchPhonesByName(String query) {
    return _getPhones(() => phoneRemoteDataSource.searchPhonesByName(query));
  }
}