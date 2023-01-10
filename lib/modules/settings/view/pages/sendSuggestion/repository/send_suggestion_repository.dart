import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/model/suggestion.dart';
import 'package:control/network/firestore_path.dart';

abstract class SendSuggestionRepositoryAbs {
  Future<void> sendSuggestion(FiicoUser? user, Suggestion? suggestion);
  Future<bool> isRemoveAccountPending(FiicoUser? user);
}

class SendSuggestionRepository extends SendSuggestionRepositoryAbs {
  final suggestionCollection =
      FirebaseFirestore.instance.collection(Firestore.suggestionsPath);

  //Generic ----------------------------------------------------------
  @override
  Future<void> sendSuggestion(FiicoUser? user, Suggestion? suggestion) async {
    final reference = await suggestionCollection.add({
      'userId': user?.id,
      'text': suggestion?.text,
      'type': suggestion?.type.name,
    });
    return suggestionCollection.doc(reference.id).update({'id': reference.id});
  }

  Future<void> deleteSuggestion(FiicoUser? user, Suggestion? suggestion) async {
    final suggestions = await getSuggestions(user).first;
    return suggestionCollection.doc(suggestions?.first.id).delete();
  }

  @override
  Future<bool> isRemoveAccountPending(FiicoUser? user) async {
    final suggestions = await getSuggestions(user).first;
    return suggestions?.isNotEmpty ?? false;
  }

  Stream<List<Suggestion>?> getSuggestions(FiicoUser? user) {
    return suggestionCollection
        .where(
          Firestore.typeField,
          isEqualTo: SuggestionType.removeAccount.name,
        )
        .where(
          Firestore.userIdField,
          isEqualTo: user?.id,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Suggestion.fromJson(doc.data()))
          .toList();
    });
  }
}
