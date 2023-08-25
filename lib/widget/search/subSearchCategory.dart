import 'package:flutter/material.dart';
import 'package:cloud_music/resource/dim.dart';

class SubSearchCategory extends StatelessWidget {
  const SubSearchCategory(
      {Key? key,
      required String title,
      required IconData icon,
      required Color iconColor,
      required VoidCallback? onTap})
      : _title = title,
        _icon = icon,
        _iconColor = iconColor,
        _onTap = onTap,
        super(key: key);

  final String _title;
  final IconData _icon;
  final Color _iconColor;
  final VoidCallback? _onTap;

  String get title => _title;

  IconData get icon => _icon;

  Color get iconColor => _iconColor;

  final int _margin = 10;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Row(
        children: [
          Icon(_icon, color: _iconColor),
          SizedBox(width: Dim.screenUtilOnHorizontal(_margin)),
          Text(_title,
              style: TextStyle(
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                  color: Colors.black)),
        ],
      ),
    );
  }
}
