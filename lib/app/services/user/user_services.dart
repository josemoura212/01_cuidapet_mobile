import 'package:cuidapet_mobile/app/models/social_login_type_enum.dart';

abstract class UserServices {
  Future<void> register({required String email, required String password});
  Future<void> login({required String email, required String password});
  Future<void> socialLogin(SocialLoginType socialLoginType);
}
