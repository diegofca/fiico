// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:control/modules/login/repository/providers/login_social_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GlAuthProvider {
  Future<SocialCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return SocialCredential(
        userCredential: credential,
        email: googleUser?.email,
      );
    } catch (error) {
      return null;
    }
  }
}
