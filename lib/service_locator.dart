import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/phones/phone_local_data_source.dart';
import 'package:phone_book/future/data/datasources/phones/phone_local_data_source_impl.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source_impl.dart';
import 'package:phone_book/future/domain/repositories/phone_repository_impl.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';
import 'package:phone_book/future/domain/usecases/phones/get_all_phones.dart';
import 'package:phone_book/future/domain/usecases/phones/get_phones_by_department.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_phones_by_department_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerLazySingleton(() => GetAllPhonesCubit(getAllPhonesCase: sl()));
  sl.registerLazySingleton(() => GetPhonesByDepartmentCubit(getPhonesByDepartmentCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPhonesCase(sl()));
  sl.registerLazySingleton(() => GetPhonesByDepartmentCase(sl()));

  // Repository
  sl.registerLazySingleton<PhoneRepository>(
    () => PhoneRepositoryImpl(
      phoneRemoteDataSource: sl(),
      phoneLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PhoneRemoteDataSource>(() => PhoneRemoteDataSourceImpl(instance: FirebaseFirestore.instance));
  sl.registerLazySingleton<PhoneLocalDataSource>(() => PhoneLocalDataSourceImpl(sharedPreferences: sl()));

  // External
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Logger
  sl.registerLazySingleton(() => Logger('PhoneScreen'));

}
