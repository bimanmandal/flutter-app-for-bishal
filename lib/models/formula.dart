class Formula {
  String title;
  List<String> body;

  Formula(this.title, this.body);

  factory Formula.fromJson(dynamic json) {
    String title = json['title'] as String?? "";
    List<String> body = List<String>.from(json['body'] as List<dynamic>?? List.empty());
    return Formula(title, body);
  }

  @override
  String toString() {
    return 'Formula{title: $title, body: $body}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Formula &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body;

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}