import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppLoading());

  Future<void> internetCheck() async {
    // Already sent
    emit(AppLoading());
    final isInternetFound = await _checkConnection();
    if (isInternetFound) {
      emit(AppInternetAvailable());
    } else {
      emit(AppInternetNotAvailable());
    }
  }

  // Sometime even if you connect to wifi that might not connect to the network
  // To actually see if there is a connection
  // Use this function to check if user actually has data package to there phone
  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 1));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //Internet connection available
        return true;
      } else {
        //Internet connection not available
        return false;
      }
    } on TimeoutException {
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
