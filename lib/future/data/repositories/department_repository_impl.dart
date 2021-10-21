import 'package:dartz/dartz.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/departments/department_local_data_source.dart';
import 'package:phone_book/future/data/datasources/departments/department_remote_data_source.dart';
import 'package:phone_book/future/domain/entities/department_entity.dart';
import 'package:phone_book/future/domain/repositories/department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  DepartmentRemoteDataSource departmentRemoteDataSource;
  DepartmentLocalDataSource departmentLocalDataSource;
  NetworkInfo networkInfo;

  DepartmentRepositoryImpl({
    required this.departmentRemoteDataSource,
    required this.departmentLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getAllDepartments() async {
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
