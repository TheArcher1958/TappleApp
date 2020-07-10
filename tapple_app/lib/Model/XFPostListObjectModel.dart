import 'XFThreadListObjectModel.dart';


class ThreadPosts {
  final List<Post> posts;
  final Pagination pagination;
  ThreadPosts(this.posts, this.pagination);

  factory ThreadPosts.fromJson(dynamic json) {
    var tagObjsJson = json['posts'] as List;
    List<Post> _tags = tagObjsJson.map((tagJson) => Post.fromJson(tagJson))
        .toList();
    return ThreadPosts(
      _tags,
      Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int current_page;
  final int last_page;
  final int total;

  Pagination(this.current_page,this.last_page,this.total);
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      json['current_page'] as int,
      json['last_page'] as int,
      json['total'] as int,
    );
  }
}


class Post {
  final String username;
  final bool can_edit;
  final Thread thread;
  final int post_id;
  final int thread_id;
  final int user_id;
  final int post_date;
  final String message;
  final String message_state;
  final int position;
  final int last_edit_date;
  final User user;

  Post(this.username,this.user_id,this.user,this.thread_id,this.post_date,this.can_edit,this.position,this.last_edit_date,
      this.message,this.message_state,this.post_id,this.thread);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['username'] as String,
      json['user_id'] as int,
      User.fromJson(json["User"]),
      json['thread_id'] as int,
      json['post_date'] as int,
      json['can_edit'] as bool,
      json['position'] as int,
      json['last_edit_date'] as int,
      json['message'] as String,
      json['message_state'] as String,
      json['post_id'] as int,
      json['thread'] as Thread,
    );
  }
}