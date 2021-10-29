import 'package:flutter_test/flutter_test.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../mock_service_locator.dart' as mock_di;
import '../../../mock_data.dart' as mock_data;

void main() {
  group('PhoneCases', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await mock_di.init();
    });

    tearDown(() async {
      await mock_di.sl.reset(dispose: false);
    });

    blocTest<GetAllPhonesCubit, GetAllPhonesState>(
      'Get All Phones Empty Test',
      build: () => mock_di.sl<GetAllPhonesCubit>(),
      act: (cubitAct) async {
        return await cubitAct.getAllPhones();
      },
      expect: () => [
        GetAllPhonesLoading(),
        const GetAllPhonesLoaded(phones: []),
      ],
    );

    blocTest<GetAllPhonesCubit, GetAllPhonesState>(
      'Get All Phones Test',
      build: () => mock_di.sl<GetAllPhonesCubit>(),
      act: (cubitAct) async {
        await mock_di.sl<PhoneRemoteDataSource>().addPhone(mock_data.phone);
        return await cubitAct.getAllPhones();
      },
      expect: () => [
        GetAllPhonesLoading(),
        GetAllPhonesLoaded(phones: [mock_data.phone]),
      ],
    );
  });
}
