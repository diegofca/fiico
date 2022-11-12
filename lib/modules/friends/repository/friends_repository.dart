import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class FriendsRepositoryAbs {
  Stream<List<InviteFriend>> getInvitations(String? userID);
  Stream<List<FiicoUser>> getFriends(String? userID);
  Future<void> acceptedFriend(InviteFriend? invite);
  Future<void> rejectFriend(InviteFriend? invite);
  Future<void> sendRequestFriend(FiicoUser? invitedUser);
}

class FriendsRepository extends FriendsRepositoryAbs {
  final usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<InviteFriend>> getInvitations(String? userID) {
    return usersCollections
        .doc(userID)
        .collection(Firestore.inviteFriendsPath)
        .where(Firestore.statusField, isEqualTo: 'Pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => InviteFriend.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> acceptedFriend(InviteFriend? invite) async {
    //Acepto invitacion
    await usersCollections
        .doc(invite?.receivedUserId)
        .collection(Firestore.inviteFriendsPath)
        .doc(invite?.id)
        .update({Firestore.statusField: "Accepted"});

    // Los agrego como amigos (a1 con a2, a2 con a1)
    final senderUser = await _getUser(invite?.sendUserId);
    final receivedUser = await _getUser(invite?.receivedUserId);

    usersCollections
        .doc(senderUser.id)
        .collection(Firestore.friendsPath)
        .add(receivedUser.toJson());

    await usersCollections
        .doc(receivedUser.id)
        .collection(Firestore.friendsPath)
        .add(senderUser.toJson());

    //Finalizo peticion de invitacion
    return usersCollections
        .doc(invite?.sendUserId)
        .collection(Firestore.inviteRequestFriendsPath)
        .doc(invite?.requestInviteId)
        .update({'status': 'Complete'});
  }

  @override
  Future<void> rejectFriend(InviteFriend? invite) async {
    //Acepto invitacion
    await usersCollections
        .doc(invite?.receivedUserId)
        .collection(Firestore.inviteFriendsPath)
        .doc(invite?.id)
        .update({Firestore.statusField: "Rejected"});

    //Finalizo peticion de invitacion
    return usersCollections
        .doc(invite?.sendUserId)
        .collection(Firestore.inviteRequestFriendsPath)
        .doc(invite?.requestInviteId)
        .update({'status': 'Complete'});
  }

  @override
  Future<void> sendRequestFriend(FiicoUser? invitedUser) async {
    var user = await Preferences.get.getUser();
    final invite = InviteFriend(
      sendUserId: user?.id,
      sendUserName: user?.userName,
      receivedUserId: invitedUser?.id,
      createdAt: Timestamp.now(),
      status: 'Pending',
    );

    final docInvite = await usersCollections
        .doc(invite.receivedUserId)
        .collection(Firestore.inviteFriendsPath)
        .add(invite.toJson());

    final docReqInvite = await usersCollections
        .doc(invite.sendUserId)
        .collection(Firestore.inviteRequestFriendsPath)
        .add(invite.toJson());

    usersCollections
        .doc(invite.receivedUserId)
        .collection(Firestore.inviteFriendsPath)
        .doc(docInvite.id)
        .update({'id': docInvite.id, 'requestInviteId': docReqInvite.id});

    usersCollections
        .doc(invite.sendUserId)
        .collection(Firestore.inviteRequestFriendsPath)
        .doc(docReqInvite.id)
        .update({'id': docReqInvite.id});
  }

  @override
  Stream<List<FiicoUser>> getFriends(String? userID) {
    return usersCollections
        .doc(userID)
        .collection(Firestore.friendsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FiicoUser.fromJson(doc.data()))
          .toList();
    });
  }

  //Generic ----------------------------------------------------------
  Future<FiicoUser> _getUser(String? userID) async {
    return usersCollections.doc(userID).snapshots().map((snapshot) {
      return FiicoUser.fromJson(snapshot.data());
    }).first;
  }
}
