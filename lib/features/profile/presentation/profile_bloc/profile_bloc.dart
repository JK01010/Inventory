import 'package:encrypt_shared_preferences/provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_string.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.encryptedSharedPreferences})
    : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      switch (event) {
        case UpdateRFIDCheckBoxSelectedStatusEvent():
          await updateRFIDCheckBoxSelectedStatus(event, emit);
          break;
        case UpdateBarCodeCheckBoxSelectedStatusEvent():
          await updateBarCodeCheckBoxSelectedStatus(event, emit);
          break;
      }
    });
  }

  final EncryptedSharedPreferences encryptedSharedPreferences;

  Future<void> updateRFIDCheckBoxSelectedStatus(
    UpdateRFIDCheckBoxSelectedStatusEvent event,
    Emitter<ProfileState> emit,
  ) async {
    encryptedSharedPreferences.setBool(AppString.isRfidEnabled, true);
    emit(state.copyWith(isRFIDEnabled: true, isBarCodeEnabled: false));
  }

  Future<void> updateBarCodeCheckBoxSelectedStatus(
    UpdateBarCodeCheckBoxSelectedStatusEvent event,
    Emitter<ProfileState> emit,
  ) async {
    encryptedSharedPreferences.setBool(AppString.isRfidEnabled, false);
    emit(state.copyWith(isRFIDEnabled: false, isBarCodeEnabled: true));
  }
}
