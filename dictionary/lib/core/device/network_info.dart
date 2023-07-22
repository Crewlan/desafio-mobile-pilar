import 'package:connectivity_plus/connectivity_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final status = await connectivity.checkConnectivity();
    var checkStatus = status != ConnectivityResult.none && status != ConnectivityResult.bluetooth;
    return checkStatus;
  }
}
