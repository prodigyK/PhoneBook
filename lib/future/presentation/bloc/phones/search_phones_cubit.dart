import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/search_phones_by_number.dart';
import 'package:phone_book/future/domain/usecases/phones/search_phones_by_name.dart';

part 'search_phones_state.dart';

class SearchPhonesCubit extends Cubit<SearchPhonesState> {
  SearchPhonesCubit({required this.searchPhonesByNameCase, required this.searchNameByNumberCase})
      : super(SearchPhonesInitial());

  final SearchPhonesByNameCase searchPhonesByNameCase;
  final SearchPhonesByNumberCase searchNameByNumberCase;

  Future<List<PhoneEntity>> _getPhones({required Function() getPhones}) async {
    final failureOrPhones = await getPhones();

    List<PhoneEntity> phoneList = [];
    failureOrPhones.fold(
          (failure) => emit(SearchPhonesError(message: _mapFailureToString(failure))),
          (phones) {
        emit(SearchPhonesLoaded(phones: phones));
        phoneList = phones;
      },
    );
    return phoneList;
  }

  Future<List<PhoneEntity>> searchPhonesByName({required String name}) async {
    return await _getPhones(getPhones: () async {
      return await searchPhonesByNameCase(SearchQueryParams(query: name));
    });
  }

  Future<List<PhoneEntity>> searchPhonesByNumber({required String number}) async {
    return await _getPhones(getPhones: () async {
      return await searchNameByNumberCase(PhoneNameParams(number: number));
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureConsts.SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return FailureConsts.CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
