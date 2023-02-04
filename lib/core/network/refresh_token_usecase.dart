import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/app/storage_utils.dart';
import 'package:todo_sample_app/core/network/dio_data_source.dart';

/// The use case class to refresh the token and store the new access token.
class RefreshTokenUseCase {
  final DioDataSource dataSource;

  RefreshTokenUseCase(this.dataSource);

  /// The use case class to refresh the token and store the new access token.
  Future<void> execute() async {
    final data = {
      "email": "test@test.com",
      "password": "password",
      "returnSecureToken": true
    };

    final queryParams = {'key': firebaseApiKey};

    final response = await dataSource.post(
      RefreshEndpoint.refreshEndpoint,
      queryParameters: queryParams,
      data: data,
    );
    final accessToken = (response.data as Map)['idToken'];
    // extract the new access token and store it using secure storage or any other means
    SecureStorage.putString(SecureStorage.accessToken, accessToken);
  }

  /// Retrieve the access token from the secure storage

  Future<String> getAccessToken() async {
    return (await SecureStorage.getString(SecureStorage.accessToken) ?? '');
  }
}

/// Contains the endpoint for refreshing the token.
class RefreshEndpoint {
  static String refreshEndpoint =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
}
