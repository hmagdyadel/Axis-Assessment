import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectivityService {
  static final NetworkConnectivityService _instance = NetworkConnectivityService._internal();
  factory NetworkConnectivityService() => _instance;
  NetworkConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker.instance;

  StreamController<bool>? _connectionStreamController;
  Stream<bool>? _connectionStream;
  bool _isConnected = true;

  // Get the singleton instance
  static NetworkConnectivityService get instance => _instance;

  // Initialize the network service
  Future<void> initialize() async {
    _connectionStreamController = StreamController<bool>.broadcast();

    // Check initial connection
    _isConnected = await _connectionChecker.hasConnection;

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);

    _connectionStream = _connectionStreamController!.stream;
  }

  // Handle connectivity changes
  void _onConnectivityChanged(List<ConnectivityResult> results) async {
    if (results.contains(ConnectivityResult.none)) {
      _updateConnectionStatus(false);
    } else {
      // Double check with internet connection checker
      final hasInternet = await _connectionChecker.hasConnection;
      _updateConnectionStatus(hasInternet);
    }
  }

  /// Update connection status and notify listeners
  void _updateConnectionStatus(bool isConnected) {
    if (_isConnected != isConnected) {
      _isConnected = isConnected;
      _connectionStreamController?.add(_isConnected);
    }
  }

  /// Get current connection status
  bool get isConnected => _isConnected;

  /// Get connection status stream
  Stream<bool>? get connectionStream => _connectionStream;

  /// Check connection status (async)
  Future<bool> checkConnection() async {
    _isConnected = await _connectionChecker.hasConnection;
    return _isConnected;
  }

  /// Dispose resources
  void dispose() {
    _connectionStreamController?.close();
    _connectionStreamController = null;
    _connectionStream = null;
  }
}