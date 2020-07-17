

class CategoryList {
  final List<Node> nodes;
  final Map tree_map;
  CategoryList(this.nodes,this.tree_map);

  factory CategoryList.fromJson(dynamic json) {
    var tagObjsJson = json['nodes'] as List;
    List<Node> _categoryTags = tagObjsJson.map((tagJson) => Node.fromJson(tagJson))
        .toList();

    return CategoryList(
      _categoryTags,
      json['tree_map'] as Map<String, dynamic>,
    );
  }
}

class Node {
  final bool display_in_list;
  final int display_order;
  final int node_id;
  final String node_type_id;
  final String title;
  final NodeTypeData type_data;

  Node(this.display_in_list,this.display_order,this.node_id,this.node_type_id,this.title,this.type_data);

  factory Node.fromJson(dynamic json) {
    return Node(
      json['display_in_list'] as bool,
      json['display_order'] as int,
      json['node_id'] as int,
      json['node_type_id'] as String,
      json['title'] as String,
      NodeTypeData.fromJson(json['type_data']),
    );
  }
}

class NodeTypeData {
  final bool allow_poll;
  final bool can_create_thread;
  final bool can_upload_attachment;
  final int discussion_count;
  final int last_post_date;
  final int last_post_id;
  final String last_post_username;
  final int last_thread_id;
  final String last_thread_title;
  final int message_count;
  final bool require_prefix;

  NodeTypeData(this.allow_poll,this.can_create_thread,this.can_upload_attachment,this.discussion_count,this.last_post_date,this.last_post_id,this.last_post_username,
      this.last_thread_id,this.last_thread_title,this.message_count,this.require_prefix);

  factory NodeTypeData.fromJson(Map<String, dynamic> json) {
    return NodeTypeData(
      json['allow_poll'] as bool,
      json['can_create_thread'] as bool,
      json['can_upload_attachment'] as bool,
      json['discussion_count'] as int,
      json['last_post_date'] as int,
      json['last_post_id'] as int,
      json['last_post_username'] as String,
      json['last_thread_id'] as int,
      json['last_thread_title'] as String,
      json['message_count'] as int,
      json['require_prefix'] as bool,
    );
  }
}