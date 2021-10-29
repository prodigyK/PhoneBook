import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/remove_phone_case.dart';

part 'remove_phone_state.dart';

class RemovePhoneCubit extends Cubit<RemovePhoneState> {
  final RemovePhoneCase removePhoneCase;

  RemovePhoneCubit({required this.removePhoneCase}) : super(RemovePhoneInitial());

  Future<void> removePhone(PhoneEntity phone) async {
    emit(RemovePhoneLoading());

    final failureOrVoid = await removePhoneCase(RemovePhoneParams(phone: phone));

    failureOrVoid.fold(
      (failure) => emit(RemovePhoneError(message: _mapFailureToString(failure))),
      (_) => emit(RemovePhoneLoaded()),
    );
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
