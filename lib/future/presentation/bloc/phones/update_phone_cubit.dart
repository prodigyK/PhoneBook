import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/update_phone_case.dart';

part 'update_phone_state.dart';

class UpdatePhoneCubit extends Cubit<UpdatePhoneState> {
  final UpdatePhoneCase updatePhoneCase;

  UpdatePhoneCubit({required this.updatePhoneCase}) : super(UpdatePhoneInitial());

  Future<void> updatePhone(PhoneEntity phone) async {
    emit(UpdatePhoneLoading());

    final failureOrVoid = await updatePhoneCase(UpdatePhoneParams(phone: phone));

    failureOrVoid.fold(
        (failure) => emit(UpdatePhoneError(message: _mapFailureToString(failure))), (_) => emit(UpdatePhoneLoaded()));
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
