part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppLoading extends AppState {
  @override
  List<Object> get props => [];
}

class AppInternetAvailable extends AppState {
  @override
  List<Object> get props => [];
}

class AppInternetNotAvailable extends AppState {
  @override
  List<Object> get props => [];
}
