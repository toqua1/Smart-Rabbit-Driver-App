class ApiEndpoints {
  static const String baseUrl = 'https://smart-rabbit-api.onrender.com/api';
  //static const String baseUrl = 'https://10.0.2.2:8000/api';

  static const String loginEndpoint = '/customers/login';
  static const String registerEndpoint = '/customers/signup';
  static const String forgetPasswordEndpoint = '/customers/forgetpassword';
  static const String validateOtpEndpoint = '/customers/CheckOTP';
  static const String editProfileEndpoint = '/customers/editprofile';
  static const String createOrderEndpoint = '/orders/createorder';
  static const String getUserOrderEndpoint = '/orders/userOrders';

  static const String updateEndpoint = '/auth/user/update';
  static const String otpEndpoint = '/auth/otp';
  static const String profileEndpoint = '/auth/profile';
  static const String jobsEndpoint = '/jobs';
  static const String applyEndpoint = '/apply';
  static const String favoritesEndpoint = '/favorites';
  static const String experienceEndpoint = '/experince';
  static const String portfolioEndpoint = '/user/profile/portofolios';
  static const String updatePasswordEndpoint = '/auth/user/update';

  // New endpoint for fetching order reports
  static String getOrderReportsEndpoint(String userId) {
    return '/orders/ordersreports/$userId';
  }
}
