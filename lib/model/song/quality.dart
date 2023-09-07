class Quality {
  final int _size;
  final int _fid;
  final int _vd;
  final int _br;
  final int _sr;

  Quality._internal({
    required int size,
    required int fid,
    required int vd,
    required int br,
    required int sr,
  })  : _size = size,
        _fid = fid,
        _vd = vd,
        _br = br,
        _sr = sr;

  int get size => _size;

  int get fid => _fid;

  int get vd => _vd;

  int get br => _br;

  int get sr => _sr;

  factory Quality.fromJson(Map<String, dynamic> json) {
    return Quality._internal(
      size: json['size'],
      fid: json['fid'],
      vd: json['vd'],
      br: json['br'],
      sr: json['sr'],
    );
  }
}
