import 'dart:async';

import 'package:login/models/user.dart';
import 'package:login/data/CtrQuery/user_ctr.dart';

class UserRequest {
  UserCtr con = new UserCtr();

 Future<int> createUser(User user) {
    var result = con.saveUser(user);
    return result;
  }

  Future<List<User>> getUser() {
    var result = con.getAllUser();
    return result;
  }

  Future<int> deleteUser(int user) {
    var result = con.deleteUser(user);
    return result;
  }
}