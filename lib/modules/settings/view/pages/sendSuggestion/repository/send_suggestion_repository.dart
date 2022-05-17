import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SendSuggestionRepositoryAbs {
  Future<void> sendSuggestion(FiicoUser? user, String? suggestion);
}

class SendSuggestionRepository extends SendSuggestionRepositoryAbs {
  final suggestionCollection =
      FirebaseFirestore.instance.collection(Firestore.suggestionsPath);

  //Generic ----------------------------------------------------------
  @override
  Future<void> sendSuggestion(FiicoUser? user, String? suggestion) {
    return suggestionCollection.add({
      "user_id": user?.id,
      "suggestion": suggestion,
    });
  }
}
