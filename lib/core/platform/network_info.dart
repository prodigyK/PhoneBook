import 'package:universal_internet_checker/universal_internet_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    final checkInternet = await UniversalInternetChecker.checkInternet();
    return checkInternet == ConnectionStatus.online;
  }

}