import 'package:flutter/material.dart';

/// An abstract class that helps in detecting network connectivity.
@immutable
abstract class NetworkConnectivity {
  const NetworkConnectivity();

  /// Checks the current network connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> checkConnection();

  /// Gets the current network connectivity state.
  NetworkConnectivityState get currentState;

  /// Returns `true` if the device is currently connected to a network.
  bool get isConnected;

  /// A stream that emits network connectivity state changes.
  Stream<NetworkConnectivityState> get connectivityStream;

  /// Cleans up resources when the connectivity monitoring is no longer needed.
  void dispose();
}

/// Represents the possible states of network connectivity.
enum NetworkConnectivityState {
  /// Device is connected to a network
  connected,

  /// Device is not connected to any network
  disconnected,
}

/// Fake implementation of [NetworkConnectivity] that always returns true.
class FakeNetworkConnectivity extends NetworkConnectivity {
  @override
  Future<bool> checkConnection() async => true;

  @override
  Stream<NetworkConnectivityState> get connectivityStream => throw UnimplementedError();

  @override
  NetworkConnectivityState get currentState => NetworkConnectivityState.connected;

  @override
  void dispose() {}

  @override
  bool get isConnected => true;
}
