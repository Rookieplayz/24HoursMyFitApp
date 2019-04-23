import 'package:twenty_four_hours/Authentication/Model/Register.dart';

import 'package:twenty_four_hours/MyFit/Models/Follows.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';
import 'package:twenty_four_hours/MyFit/Models/Comments.dart';

class Picture {
  String _pictureUrl = '';
  String _title = '';
  String _description = '';
  int _Likes = 0;
  int _picComments = 0;
  List<MyFitProfile> _likedBy = new List<MyFitProfile>();
  List<MyFitProfile> _tag = new List<MyFitProfile>();
  List<MyFitProfile> _viewedBy = new List<MyFitProfile>();
  List<Comments> _comments = new List<Comments>();
  int _views;
  final DateTime dateAdded = DateTime.now();

  Picture([
    this._pictureUrl,
    this._title,
    this._description,
    this._comments,
    this._tag,
    this._likedBy,
    this._viewedBy,
  ]);

  List<MyFitProfile> get likedBy => _likedBy;

  List<MyFitProfile> get tag => _tag;

  List<MyFitProfile> myFriends(List<MyFitProfile> myFriend) {
    List<MyFitProfile> friends = new List<MyFitProfile>();
    for (MyFitProfile pr in likedBy) {
      print("LikedBy : " + pr.user.username);
      for (MyFitProfile p in myFriend) {
        print("MyFriend: " + p.user.username);

        if (p.UID == pr.UID) {
          friends.add(p);
        }
      }
    }
    print("MyFriendLiked: $friends");
    return friends;
  }

  int get picComments => _picComments;

  set picComments(int value) {
    _picComments = value;
  }

  set tag(List<MyFitProfile> value) {
    _tag = value;
  }

  set likedBy(List<MyFitProfile> value) {
    _likedBy = value;
  }

  List<Comments> get comments => _comments;

  set comments(List<Comments> value) {
    _comments = value;
  }

  int get Likes => _Likes;

  set Likes(int value) {
    _Likes = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get pictureUrl => _pictureUrl;

  set pictureUrl(String value) {
    _pictureUrl = value;
  }

  List<MyFitProfile> get viewedBy => _viewedBy;

  set viewedBy(List<MyFitProfile> value) {
    _viewedBy = value;
  }

  int get views => _viewedBy.length;

  set views(int value) {
    _views = value;
  }

  @override
  String toString() {
    return 'Picture{_pictureUrl: $_pictureUrl, _title: $_title, _description: $_description, _Likes: $_Likes, _Comments: $picComments, _likedBy: $_likedBy, _tag: $_tag, _viewedBy: $_viewedBy, _comments: $_comments, _views: $_views, dateAdded: $dateAdded}';
  }
}
