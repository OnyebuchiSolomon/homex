class APIRoutes {
  /// Base
  static const String _baseUrl = 'https://5sim.net/v1/guest';

  ///Auth urls
   static const String fetchCountriesUrl = '$_baseUrl/countries';
  static const String fetchServicesUrl = '$_baseUrl/prices';

  // static const String resendPhoneValidationCodeUrl =
  //     '$_baseUrl/auth/resend-token';
  // static const String verifyPhoneUrl = '$_baseUrl/auth/verify-token';
  // static const String fetchCountriesUrl = '$_baseUrl/list-countries';
  // static const String fetchStatesUrl = '$_baseUrl/list-states';
  // static const String registerUrl = '$_baseUrl/auth/user-registration';
  // static const String loginUrl = '$_baseUrl/auth/login';
  // static const String logoutUrl = '$_baseUrl/auth/logout';
  // static const String getUserUrl = '$_baseUrl/auth/profile';
  // static const String initPasswordResetUrl = '$_baseUrl/auth/password-reset/request_property-otp';
  // static const String verifyResetPhoneUrl = '$_baseUrl/auth/password-reset/verify-otp';
  // static const String resetPasswordUrl = '$_baseUrl/auth/password-reset/reset';
  // static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  //
  // // Company urls
  // static const String addBranchUrl = '$_baseUrl/company/add-branch';
  // static const String addServicesUrl = '$_baseUrl/services';
  // static String fetchBranchesUrl({
  //   int page = 1,
  //   int? perPage,
  // }) =>
  //     '$_baseUrl/branches?page=$page&per_page=${perPage ?? 20}';
  // static const String fetchServicesUrl = '$_baseUrl/services';
  //
  // // Staff urls
  // static const String staffInvitationUrl = '$_baseUrl/staff/invitation';
}
