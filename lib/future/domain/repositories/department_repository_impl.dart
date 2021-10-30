import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/departments/department_local_data_source.dart';
import 'package:phone_book/future/data/datasources/departments/department_remote_data_source.dart';
import 'package:phone_book/future/domain/entities/department_entity.dart';
import 'package:phone_book/future/domain/repositories/department_repository.dart';
import 'package:phone_book/service_locator.dart' as di;

class DepartmentRepositoryImpl implements DepartmentRepository {
  DepartmentRemoteDataSource departmentRemoteDataSource;
  DepartmentLocalDataSource departmentLocalDataSource;
  NetworkInfo networkInfo;

  DepartmentRepositoryImpl({
    required this.departmentRemoteDataSource,
    required this.departmentLocalDataSource,
    required this.networkInfo,
  });

  final log = di.sl<Logger>();

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getAllDepartments() async {
    log.info('Call getAllDepartments() method');
    if (await networkInfo.isConnected) {
      try {
        final remoteDeps = await departmentRemoteDataSource.getAllDepartments();
        departmentLocalDataSource.saveDepartmentsToCache(remoteDeps);
        return Right(remoteDeps);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDeps = await departmentLocalDataSource.getDepartmentsFromCache();
        return Right(localDeps);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, DepartmentEntity>> getDepartmentById(String depId) async {
    log.fine('Call getDepartmentById($depId) method');
    if (await networkInfo.isConnected) {
      try {
        final remoteDep = await departmentRemoteDataSource.getDepartmentById(depId);
        return Right(remoteDep);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDep = await departmentLocalDataSource.getDepartmentFromCacheById(depId);
        return Right(localDep);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
