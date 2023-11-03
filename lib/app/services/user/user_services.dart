abstract class UserServices {
  Future<void> register({required String email, required String password});
  Future<void> login({required String email, required String password});
}
