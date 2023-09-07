class StyleTemplateTextContent {
  final String _templateContent;
  final Map<String, dynamic> _pattern;

  StyleTemplateTextContent._internal({
    required String templateContent,
    required Map<String, dynamic> pattern,
  })  : _templateContent = templateContent,
        _pattern = pattern;

  String get templateContent => _templateContent;

  Map<String, dynamic> get patterns => _pattern;

  factory StyleTemplateTextContent.fromJson(Map<String, dynamic> json) {
    return StyleTemplateTextContent._internal(
      templateContent: json['templateContent'] as String,
      pattern: json['pattern'] as Map<String, dynamic>,
    );
  }

  //parse the content like: "templateContent": "你已涉猎${tagNum}个主流曲风~\n其中你对${tagName}音乐最为钟爱，偏好高达${tagPercent}呢！"
  String parsedTemplateContent() {
    RegExp regex = RegExp(r"\${(\w+)}");
    String parsedContent = templateContent.replaceAllMapped(regex, (match) {
      String variableName = match.group(1)!;
      if (patterns.containsKey(variableName)) {
        return patterns[variableName]['text'].toString();
      } else {
        return match.group(0)!;
      }
    });
    return parsedContent;
  }
}
