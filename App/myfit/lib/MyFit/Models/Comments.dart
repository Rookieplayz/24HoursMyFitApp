import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';
class ReplyComment
{
   MyFitProfile _commenter = new MyFitProfile();
  String _commment = '';
  List<MyFitProfile> _likedComment = [new MyFitProfile()];
 

  ReplyComment(
      [this._commenter, this._commment, this._likedComment]);

  List<MyFitProfile> get likedComment => _likedComment;

  @override
  String toString() {
    return 'Comments{_commenter: $_commenter, _commment: $_commment, _likedComment: $_likedComment}';
  }

  String get commment => _commment;

  set commment(String value) {
    _commment = value;
  }

  set likedComment(List<MyFitProfile> value) {
    _likedComment = value;
  }

  MyFitProfile get commenter => _commenter;

  set commenter(MyFitProfile value) {
    _commenter = value;
  }
}
class Comments {
  MyFitProfile _commenter = new MyFitProfile();
  String _commment = '';
  List<MyFitProfile> _likedComment = [new MyFitProfile()];
  List<ReplyComment> _replies = new List<ReplyComment>();
  DateTime _duration = new DateTime.now();

  Comments(
      [this._commenter, this._commment, this._likedComment, this._replies]);

  List<MyFitProfile> get likedComment => _likedComment;

  List<ReplyComment> get replies => _replies;

  set replies( List<ReplyComment> value) {
    _replies = value;
  }

  int getDuration(DateTime currentTime) {
    return _duration.difference(currentTime).inSeconds;
  }

  @override
  String toString() {
    return 'Comments{_commenter: $_commenter, _commment: $_commment, _likedComment: $_likedComment, _duration: $_duration}';
  }

  String get commment => _commment;

  set commment(String value) {
    _commment = value;
  }

  set likedComment(List<MyFitProfile> value) {
    _likedComment = value;
  }

  MyFitProfile get commenter => _commenter;

  set commenter(MyFitProfile value) {
    _commenter = value;
  }
}
