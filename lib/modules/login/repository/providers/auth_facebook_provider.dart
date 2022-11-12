// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:control/modules/login/repository/providers/login_social_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FbAuthProvider {
  final facebookGraphUrl =
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=';
  Future<SocialCredential?> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();

    final facebookAuth =
        await facebookLogin.logIn(['email', 'public_profile', 'user_friends']);

    if (facebookAuth.status == FacebookLoginStatus.loggedIn) {
      final user = await _getFbUser(facebookAuth);
      final credential =
          FacebookAuthProvider.credential(facebookAuth.accessToken.token);

      return SocialCredential(
        userCredential: credential,
        email: user.email,
      );
    } else {
      return null;
    }
  }

  Future<FacebookGraphResponse> _getFbUser(FacebookLoginResult result) async {
    final response = await http.get(Uri.parse(
      '$facebookGraphUrl${result.accessToken.token}',
    ));

    if (response.statusCode == 200) {
      FacebookGraphResponse responseUser =
          FacebookGraphResponse.fromJson(jsonDecode(response.body));
      return responseUser;
    } else {
      throw Exception('API ERROR: FacebookGraphResponse');
    }
  }
}

class FacebookGraphResponse {
  final String name;
  final String lastName;
  final String userName;
  final String email;

  FacebookGraphResponse({
    required this.name,
    required this.lastName,
    required this.userName,
    required this.email,
  });

  factory FacebookGraphResponse.fromJson(Map<String, dynamic> json) {
    return FacebookGraphResponse(
      name: json['first_name'],
      lastName: json['last_name'] ?? '',
      userName: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
