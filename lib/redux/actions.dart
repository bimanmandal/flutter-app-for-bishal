class FontSize {
  final double payload;
  FontSize(this.payload);
}

class Bold {
  final bool payload;
  Bold(this.payload);
}

class Italic {
  final bool payload;
  Italic(this.payload);
}

class TopicSelection {
  TopicSelection(this.minNumber, this.maxNumber);
  final int minNumber;
  final int maxNumber;
}

class SubmitAnswer {
  SubmitAnswer(this.payload);
  final bool payload;
}