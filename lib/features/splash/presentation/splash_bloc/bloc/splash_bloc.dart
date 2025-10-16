import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_authentication_use_case.dart';
import '../events/splash_event.dart';
import '../states/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.checkAuthenticationUseCase})
    : super(SplashInitialState()) {
    on<SplashEvent>((event, emit) async {
      switch (event) {
        case CheckAuthenticationEvent():
          await _checkAuthentication(event, emit);
          break;
      }
    });
  }

  final CheckAuthenticationUseCase checkAuthenticationUseCase;

  Future<void> _checkAuthentication(
    CheckAuthenticationEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final failureOrSuccess = await checkAuthenticationUseCase();

    await failureOrSuccess.fold(
      (failure) async {
        emit(AuthUnAuthenticated());
      },
      (success) async {
        emit(AuthAuthenticated());
      },
    );
  }
}
