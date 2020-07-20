import 'XFNodeListObjectModel.dart';

class NodeResponse {
  final List<Thread> threads;
  final List<Thread> sticky;
  final Pagination pagination;
  NodeResponse(this.sticky,this.threads, this.pagination);
  factory NodeResponse.fromJson(Map<String, dynamic> json) {
    var threadsJson = json['threads'] as List;
    List<Thread> _tagsThreads = threadsJson.map((tagJson) => Thread.fromJson(tagJson))
        .toList();
    var stickyJson = json['sticky'] as List;
    List<Thread> _tagsSticky = stickyJson.map((tagJson) => Thread.fromJson(tagJson))
        .toList();
    return NodeResponse(
      _tagsSticky,
      _tagsThreads,
      Pagination.fromJson(json['pagination']),
    );
  }
}

class Thread {
  final String username;
  final bool can_edit;
  final bool can_reply;
  final int thread_id;
  final int node_id;
  final String title;
  final int reply_count;
  final int view_count;
  final int user_id;
  final int post_date;
  final User user;
  final int last_post_date;
  final int last_post_id;
  final String discussion_state;
  final bool discussion_open;
  final bool sticky;
  final Node node;
  final String prefix;
  Thread(this.discussion_open,this.last_post_date,this.title,this.last_post_id,this.node_id,this.username,this.can_edit,this.can_reply,this.discussion_state,
      this.node,this.post_date,this.prefix,this.reply_count,this.sticky,this.thread_id,this.user,this.user_id,this.view_count);
  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      json['discussion_open'] as bool,
      json['last_post_date'] as int,
      json['title'] as String,
      json['last_post_id'] as int,
      json['node_id'] as int,
      json['username'] as String,
      json['can_edit'] as bool,
      json['can_reply'] as bool,
      json['discussion_state'] as String,
      json['node'] as Node,
      json['post_date'] as int,
      json['prefix'] as String,
      json['reply_count'] as int,
      json['sticky'] as bool,
      json['thread_id'] as int,
      User.fromJson(json['User']),
      json['user_id'] as int,
      json['view_count'] as int,
    );
  }
}

class User {
  final int age;
  final Map avatar_urls;
  final String custom_title;
  final String email;
  final String signature;
  final int user_id;
  final String username;
  final bool is_staff;
  final int register_date;
  final int message_count;
  final String user_state;
  final int last_activity;
  final bool is_banned;
  final String user_title;
  User(this.user_title,this.user_id,this.username,this.message_count,this.email,this.age,this.avatar_urls,this.custom_title,this.is_banned,
      this.is_staff,this.last_activity,this.register_date,this.signature,this.user_state);
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['user_title'] as String,
      json['user_id'] as int,
      json['username'] as String,
      json['message_count'] as int,
      json['email'] as String,
      json['age'] as int,
      json['avatar_urls'] as Map<String, dynamic>,
      json['custom_title'] as String,
      json['is_banned'] as bool,
      json['is_staff'] as bool,
      json['last_activity'] as int,
      json['register_date'] as int,
      json['signature'] as String,
      json['user_state'] as String,
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