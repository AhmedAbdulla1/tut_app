import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo{
  Future<bool> get isConnected;
}
class NetworkInfoImpl extends NetWorkInfo{
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpl (this._internetConnectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

}