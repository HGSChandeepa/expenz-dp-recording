import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //methode to store the user name and user email in shared pref
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //check weather the user entered password and the confirm password are the same
      if (password != confirmPassword) {
        //show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm password do not match"),
          ),
        );

        return;
      }

      // if the users password and conf password are same then store the users name and email
      //create an instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email as key value pairs
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Details stored successfully"),
        ),
      );
    } catch (err) {
      err.toString();
    }
  }

  //methode to check weather the username is saved in the shared pref
  static Future<bool> checkUsername() async {
    //create an instance foe shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }

  //get the username and the email
  static Future<Map<String, String>> getUserData() async {
    //create an instance for shared pref
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userName = pref.getString("username");
    String? email = pref.getString("email");

    return {"username": userName!, "email": email!};
  }

  //remove the username and email from shared preferences
  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('username');
    await pref.remove('email');
  }
}
