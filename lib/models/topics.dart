
enum TopicEnum {
  MULTIPLICATION_TABLES,
  SQUARES,
  CUBES
}

Map<TopicEnum, String> _topicEnumAsString = {
  TopicEnum.MULTIPLICATION_TABLES: "Multiplication",
  TopicEnum.SQUARES: "Square",
  TopicEnum.CUBES: "Cube"
};

extension ParseToString on TopicEnum {
  String get toDisplayedString {
    return _topicEnumAsString[this];
  }
}