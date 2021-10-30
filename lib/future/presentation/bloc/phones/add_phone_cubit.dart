import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/add_phone_case.dart';

part 'add_phone_state.dart';

class AddPhoneCubit extends Cubit<AddPhoneState> {
  final AddPhoneCase addPhoneCase;

  AddPhoneCubit({required this.addPhoneCase}) : super(AddPhoneInitial());

  Future<String> addPhone(PhoneEntity phone) async {
    emit(AddPhoneLoading());

    final failureOrId = await addPhoneCase(AddPhoneParams(phone: phone));

    String id = '';
    failureOrId.fold((failure) => emit(AddPhoneError(message: _mapFailureToString(failure))), (phoneId) {
      emit(AddPhoneLoaded(phoneId: phoneId));
      id = phoneId;
    });

    return id;
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
