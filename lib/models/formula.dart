class Formula {
  String title;
  String body;

  Formula(this.title, this.body);

  factory Formula.fromJson(dynamic json) {
    return Formula(json['title'] as String?? "", json['body'] as String?? "");
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