class PaginationInfo {
  final int _cursor;
  final int _size;
  final bool _more;
  final int _total;

  int get cursor => _cursor;

  int get size => _size;

  int get total => _total;

  bool get more => _more;

  PaginationInfo._internal(int cursor, int size, bool more, int total)
      : _cursor = cursor,
        _size = size,
        _more = more,
        _total = total;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo._internal(
      json['cursor'],
      json['size'],
      json['more'],
      json['total'],
    );
  }
}
