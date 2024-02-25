import 'package:flutter_bloc_fakestoreapi/data/models/auth.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';

abstract class UserDataSource {
  Future<AuthModel> userLogin(String email, String password);
  Future<UserModel> userDetail(int id);
  Future<AuthModel> userSignup(String name, String email, String password);
}
