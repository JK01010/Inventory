import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityManager {
  Future<bool> get isConnected;
}

class ConnectivityManagerImpl extends ConnectivityManager {
  final Connectivity connectivity;

  ConnectivityManagerImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    final isConnected = !(connectivityResult.contains(ConnectivityResult.none));
    return isConnected;
  }
}
