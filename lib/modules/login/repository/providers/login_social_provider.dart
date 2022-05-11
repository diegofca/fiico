import 'package:control/modules/login/repository/providers/auth_apple_provider.dart';
import 'package:control/modules/login/repository/providers/auth_facebook_provider.dart';
import 'package:control/modules/login/repository/providers/auth_google_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSocialProvider {
  final _appleAuth = AppleAuthProvider();
  final _fbAuth = FbAuthProvider();
  final _glAuth = GlAuthProvider();

  Future<SocialCredential?> loginWithGoogle() async {
    return await _glAuth.signInWithGoogle();
  }

  Future<SocialCredential?> loginWithFacebook() async {
    return await _fbAuth.signInWithFacebook();
  }

  Future<SocialCredential?> loginWithApple() async {
    return await _appleAuth.signInWithApple();
  }
}

class SocialCredential {
  final OAuthCredential userCredential;
  final String? email;
  SocialCredential({required this.userCredential, this.email});
}
