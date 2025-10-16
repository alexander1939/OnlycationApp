class AppConstants {
  static const String baseUrl = 'https://serum-instructor-sensor-registry.trycloudflare.com/api/';
  
  // App Constants
  static const String appName = 'Onlycation';
  
  // Shared Preferences Keys
  static const String authTokenKey = 'auth_token';
  
  // API Endpoints
  static const String loginEndpoint = '/auth/login';

  // OAuth (LinkedIn) Mobile Deep Link
  // Callback scheme must match AndroidManifest intent-filter and iOS URL Types
  static const String oauthCallbackScheme = 'onlycation';
  static const String oauthCallbackHost = 'auth';
  // Backend start URL that initiates LinkedIn OAuth (should redirect to LinkedIn, then back to scheme)
  // Example expected full start URL constructed elsewhere:
  //   http://<server>/api/auth/linkedin/mobile/start?redirect_uri=onlycation://auth
  static const String linkedinMobileStartPath = 'auth/linkedin/mobile/start';
}
