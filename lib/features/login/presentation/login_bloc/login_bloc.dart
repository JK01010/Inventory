import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/network/domain/network_connectivity_usecase.dart';
import '../../data/models/identity_server_model.dart';
import '../../domain/usecases/identity_server_verification_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.identityServerVerificationUseCase,
    required this.networkConnectivityUseCase,
  }) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      switch (event) {
        case IdentityServerLoginVerification():
          await onIdentityServerLoginVerification(event, emit);
          break;
      }
    });
  }

  final IdentityServerVerificationUseCase identityServerVerificationUseCase;
  final NetworkConnectivityUseCase networkConnectivityUseCase;

  Future<void> onIdentityServerLoginVerification(
    IdentityServerLoginVerification event,
    Emitter emit,
  ) async {
    final result = await identityServerVerificationUseCase(
      params: IdentityServerVerificationParams(
        identityServerResponse: event.identityServerResponse,
        verificationBaseUrl: event.verificationBaseUrl,
      ),
    );
    await result.fold(
      (failure) async {
        debugPrint("failure.message : ${failure.message}");
        emit(
          state.copyWith(loginSuccess: false, errorMessage: failure.message),
        );
      },
      (value) async {
        if (value == true) {
          emit(state.copyWith(loginSuccess: true, errorMessage: ''));
          emit(state.copyWith(loginSuccess: false, errorMessage: ''));
        }
      },
    );
  }

  Future<bool> isNetworkConnected() async {
    return networkConnectivityUseCase();
  }
}
