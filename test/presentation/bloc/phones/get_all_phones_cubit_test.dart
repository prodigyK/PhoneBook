import 'package:flutter_test/flutter_test.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/presentation/bloc/phones/add_phone_cubit.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:phone_book/future/presentation/bloc/phones/remove_phone_cubit.dart';
import 'package:phone_book/future/presentation/bloc/phones/update_phone_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../mock_service_locator.dart' as mock_di;
import '../../../mock_data.dart' as mock_data;

void main() {
  group('PhoneCases', () {
    String phoneId = '';

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await mock_di.init();
    });

    tearDown(() async {
      await mock_di.sl.reset(dispose: false);
    });

    blocTest(
      'Add Phone Test',
      build: () => mock_di.sl<AddPhoneCubit>(),
      act: (AddPhoneCubit cubit) async {
        final result = await cubit.addPhone(mock_data.phone);
        final phones = await mock_di.sl<GetAllPhonesCubit>().getAllPhones();
        phoneId = phones.singleWhere((phone) => phone.id == result).id;
      },
      expect: () => [
        AddPhoneLoading(),
        AddPhoneLoaded(phoneId: phoneId),
      ],
    );

    test(
      'Update Phone Test',
      () async {
        final result = await mock_di.sl<AddPhoneCubit>().addPhone(mock_data.phone);
        PhoneEntity mockPhone = PhoneModel(
          id: result,
          name: mock_data.phone.name,
          number: '777',
          depId: mock_data.phone.depId,
          isBoss: mock_data.phone.isBoss,
          createdAt: mock_data.phone.createdAt,
          ordering: mock_data.phone.ordering,
        );
        await mock_di.sl<UpdatePhoneCubit>().updatePhone(mockPhone);
        final phones = await mock_di.sl<GetAllPhonesCubit>().getAllPhones();
        final number = phones.singleWhere((phone) => phone.id == result).number;
        expect(number, '777');
      },
    );

    test(
      'Remove Phone Test',
      () async {
        final result = await mock_di.sl<AddPhoneCubit>().addPhone(mock_data.phone);
        var phones = await mock_di.sl<GetAllPhonesCubit>().getAllPhones();
        final afterAdd = phones.length;
        final phone = phones.singleWhere((phone) => phone.id == result);
        await mock_di.sl<RemovePhoneCubit>().removePhone(phone);
        phones = await mock_di.sl<GetAllPhonesCubit>().getAllPhones();
        final afterDelete = phones.length;
        expect(afterDelete, afterAdd - 1);
      },
    );

    blocTest<GetAllPhonesCubit, GetAllPhonesState>(
      'Get All Phones Empty Test',
      build: () => mock_di.sl<GetAllPhonesCubit>(),
      act: (cubitAct) async {
        await cubitAct.getAllPhones();
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
