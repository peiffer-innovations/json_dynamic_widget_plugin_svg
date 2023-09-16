import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_class/json_class.dart';
import 'package:json_theme/json_theme.dart';

class SvgThemeDecoder {
  static SvgTheme? decode(dynamic map) {
    SvgTheme? result;

    if (map is SvgTheme) {
      result = map;
    } else if (map != null) {
      result = SvgTheme(
        currentColor: ThemeDecoder.decodeColor(map['currentColor']) ??
            const Color(0xFF000000),
        fontSize: JsonClass.maybeParseDouble(map['fontSize']) ?? 14.0,
        xHeight: JsonClass.maybeParseDouble(map['xHeight']),
      );
    }

    return result;
  }
}
