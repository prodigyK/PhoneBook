import 'package:get_it/get_it.dart';
import 'package:phone_book/core/platform/network_info.dart';
import 'package:phone_book/future/data/datasources/phone_local_data_source.dart';
import 'package:phone_book/future/data/datasources/phone_local_data_source_impl.dart';
import 'package:phone_book/future/data/datasources/phone_remote_data_source.dart';
import 'package:phone_book/future/data/datasources/phone_remote_data_source_impl.dart';
import 'package:phone_book/future/data/repositories/phone_repository_impl.dart';
import 'package:phone_book/future/domain/repositories/phone_repository.dart';
import 'package:phone_book/future/domain/usecases/phones/get_all_phones.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerLazySingleton(() => GetAllPhonesCubit(getAllPhonesCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPhonesCase(sl()));

  // Repository
  sl.registerLazySingleton<PhoneRepository>(
    () => PhoneRepositoryImpl(
      phoneRemoteDataSource: sl(),
      phoneLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PhoneRemoteDataSource>(() => PhoneRemoteDataSourceImpl());
  sl.registerLazySingleton<PhoneLocalDataSource>(() => PhoneLocalDataSourceImpl(sharedPreferences: sl()));

  // External
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
