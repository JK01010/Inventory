import '../connectivity_manager.dart';

abstract interface class NetworkConnectivityUseCase {
  Future<bool> call();
}

class NetworkConnectivityUseCaseImpl implements NetworkConnectivityUseCase {
  NetworkConnectivityUseCaseImpl({required this.connectivityManager});

  final ConnectivityManager connectivityManager;

  @override
  Future<bool> call() {
    return connectivityManager.isConnected;
  }
}
