import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';

class Friends {
  List<MyFitProfile> _friends = [];
  List<MyFitProfile> _blocked = [];
  List<MyFitProfile> _bestFriends = [];
  List<MyFitProfile> _mutualFriend = [];
  List<MyFitProfile> _friendInvites = [];

  Friends(this._friends, this._blocked, this._bestFriends, this._mutualFriend,
      this._friendInvites);

  List<MyFitProfile> get friendInvites => _friendInvites;

  set friendInvites(List<MyFitProfile> value) {
    _friendInvites = value;
  }

  List<MyFitProfile> getMutualFriend(MyFitProfile p) {
    bool mutual = false;
    for (MyFitProfile profile in _friends) {
      if (p.friends.friends.contains(profile)) mutual = true;
    }
    if (mutual == true) {
      _mutualFriend.add(p);
    }
    return _mutualFriend;
  }

  set mutualFriend(List<MyFitProfile> value) {
    _mutualFriend = value;
  }

  List<MyFitProfile> get bestFriends => _bestFriends;

  set bestFriends(List<MyFitProfile> value) {
    _bestFriends = value;
  }

  List<MyFitProfile> get blocked => _blocked;

  set blocked(List<MyFitProfile> value) {
    _blocked = value;
  }

  List<MyFitProfile> get friends => _friends;

  set friends(List<MyFitProfile> value) {
    _friends = value;
  }
}
