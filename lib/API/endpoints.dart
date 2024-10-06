class ApiEndpoints {
  static const String baseUrl2 = 'https://smart-rabbit-api.onrender.com/api';
  static const String baseUrl = 'https://smartrabbit-api-dfb5d2a5ea35.herokuapp.com/api';

  static const String loginEndpoint = '/drivers/login';
  static const String registerEndpoint = '/drivers/signup';
  static const String getDriverOrders = '/drivers/get-orders/';
  static const String updateOrderStatus = '/drivers/updateOrder-status/';
  static const String getDriverWallet = '/drivers/driver-wallet';
  static const String getCompletedOrders = '/drivers/get-CompletedOrders';
  static const String forgetPasswordEndpoint= '/drivers/forgetpassword';
  static const String validateOtpEndpoint= '/drivers/CheckOTP';
  static const String updatePasswordEndpoint= '/drivers/resetpassword';
}
