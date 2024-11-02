abstract class DomainRepository {
  ///Get the string value for the [key]
  ///
  /// [key] save the needed value
  void getStringValue(String key);

  /// Get the string value for the [key].
  ///Login response which [value] will be saved.
  ///[value] : The value which needs to be saved.
  void saveValue(dynamic key, dynamic value);

  ///Clear data from local storage.
  void clearData(dynamic key);

  /// Get the boolean value for the [key].
  ///
  /// [key] : The key whose value is needed.
  bool getBoolValue(String key);

  /// Get the Int value for the [key].
  ///
  /// [key] : The key whose value is needed.
  int getIntValue(String key);

  /// [key] : The key whose value is needed.
  Future<String?> getSecuredValue(String key);

  /// Save the value to the string.
  ///
  /// [key] : The key to which [value] will be saved in secure storage.
  /// [value] : The value which needs to be saved.
  void saveValueSecurely(String key, String value);

  /// Clear data from secure storage for [key].
  void deleteSecuredValue(String key);

  /// Remove all data from secure storage.
  void deleteAllSecuredValues();

  /// clear all data
  void clearBox();

//==============================================================================
  /// User/Model register API call
  // Future<dynamic> registerUserModel({
  //   required String email,
  //   required String phoneNumber,
  // });
}
