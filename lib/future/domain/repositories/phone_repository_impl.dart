import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/phones/phone_local_data_source.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';
import 'package:phone_book/service_locator.dart' as di;

class PhoneRepositoryImpl implements PhoneRepository {
  PhoneRemoteDataSource phoneRemoteDataSource;
  PhoneLocalDataSource phoneLocalDataSource;
  NetworkInfo networkInfo;

  PhoneRepositoryImpl({
    required this.phoneRemoteDataSource,
    required this.phoneLocalDataSource,
    required this.networkInfo,
  });

  final log = di.sl<Logger>();

  Future<Either<Failure, List<PhoneEntity>>> _getPhones(Future<List<PhoneModel>> Function() getPhones) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePhones = await getPhones();
        log.fine('get from remote = ${remotePhones.length}');
        phoneLocalDataSource.savePhonesToCache(remotePhones);
        log.fine('save to cache = ${remotePhones.length}');
        return Right(remotePhones);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPhones = await phoneLocalDataSource.getPhonesFromCache();
        log.fine('get from cache = ${localPhones.length}');
        return Right(localPhones);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> getAllPhones() async {
    return _getPhones(() async => await phoneRemoteDataSource.getAllPhones());
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> getPhonesByDepartment(String depId) async {
    return _getPhones(() async => await phoneRemoteDataSource.getPhonesByDepartment(depId));
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> searchNameByNumber(String number) {
    return _getPhones(() async => await phoneRemoteDataSource.searchNameByNumber(number));
  }

  @override
  Future<Either<Failure, List<PhoneEntity>>> searchPhonesByName(String query) {
    return _getPhones(() async => await phoneRemoteDataSource.searchPhonesByName(query));
  }

  @override
  Future<Either<Failure, String>> addPhone(PhoneEntity phone) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await phoneRemoteDataSource.addPhone(phone as PhoneModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, void>> removePhone(PhoneEntity phone) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await phoneRemoteDataSource.removePhone(phone as PhoneModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, void>> updatePhone(PhoneEntity phone) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await phoneRemoteDataSource.updatePhone(phone as PhoneModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}
