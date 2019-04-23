import 'package:twenty_four_hours/MyFit/Models/Comments.dart';
import 'package:twenty_four_hours/MyFit/Models/Muscle%20Group.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';

class Videos {
  String _title = '';
  MyFitProfile uploader = new MyFitProfile();
  String _decription = '';
  String _streamlink = '';
  String _youtubeLink = '';
  DateTime _dateCreated = DateTime.now();
  String _thumbnail = '';
  int _rating = 0;
  List<String> _tags = new List<String>();
  List<MyFitProfile> _upVotes = new List<MyFitProfile>();
  List<Comments> _comments = new List<Comments>();
  List<MyFitProfile> _viewedBy = new List<MyFitProfile>();
  List<MuscleGroup> _muscleTargets = new List<MuscleGroup>();

  Videos(
      [this.uploader,
      this._title,
      this._decription,
      this._streamlink,
      this._youtubeLink,
      this._thumbnail,
      this._dateCreated,
      this._tags,
      this._upVotes,
      this._comments,
      this._viewedBy,
      this._rating,
      this._muscleTargets]);

  String get youtubeLink => _youtubeLink;

  set youtubeLink(String value) {
    _youtubeLink = value;
  }

  int get rating => _rating;

  set rating(int value) {
    _rating = value;
  }

  List<MuscleGroup> get muscleTargets => _muscleTargets;

  set muscleTargets(List<MuscleGroup> value) {
    _muscleTargets = value;
  }

  List<MyFitProfile> get viewedBy => _viewedBy;

  set viewedBy(List<MyFitProfile> value) {
    _viewedBy = value;
  }

  List<Comments> get comments => _comments;

  set comments(List<Comments> value) {
    _comments = value;
  }

  List<MyFitProfile> get upVotes => _upVotes;

  set upVotes(List<MyFitProfile> value) {
    _upVotes = value;
  }

  List<String> get tags => _tags;

  set tags(List<String> value) {
    _tags = value;
  }

  DateTime get dateCreated => _dateCreated;

  set dateCreated(DateTime value) {
    _dateCreated = value;
  }

  String get streamlink => _streamlink;

  set streamlink(String value) {
    _streamlink = value;
  }

  String get decription => _decription;

  set decription(String value) {
    _decription = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String value) {
    _thumbnail = value;
  }

  @override
  String toString() {
    return 'Videos{_title: $_title, _decription: $_decription, _streamlink: $_streamlink, _youtubeLink: $_youtubeLink, _dateCreated: $_dateCreated, _thumbnail: $_thumbnail, _rating: $_rating, _tags: $_tags, _upVotes: $_upVotes, _comments: $_comments, _viewedBy: $_viewedBy, _muscleTargets: $_muscleTargets}';
  }
}
