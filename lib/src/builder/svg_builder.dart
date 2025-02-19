import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_dynamic_widget_plugin_svg/json_dynamic_widget_plugin_svg.dart';
import 'package:websafe_svg/websafe_svg.dart';

part 'svg_builder.g.dart';

/// Creates a SVG via the [WebsafeSvg] widget based on the JSON structure.
@jsonWidget
abstract class _SvgBuilder extends JsonWidgetBuilder {
  const _SvgBuilder({super.args});

  @JsonArgEncoder('theme')
  static Map<String, dynamic> _encodeSvgTheme(SvgTheme value) => {
    'currentColor': ThemeEncoder.encodeColor(value.currentColor),
    'fontSize': value.fontSize,
    'xHeight': value.xHeight,
  };

  @JsonArgDecoder('theme')
  SvgTheme _decodeSvgTheme({required dynamic value}) =>
      SvgThemeDecoder.decode(value) ?? const SvgTheme();

  @JsonDefaultParam('theme', 'const SvgTheme()')
  @override
  _Svg buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}

class _Svg extends StatelessWidget {
  _Svg({
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    required this.asset,
    this.clipBehavior = Clip.hardEdge,
    Color? color,
    ColorFilter? colorFilter,
    this.excludeFromSemantics = false,
    this.fit = BoxFit.contain,
    required this.headers,
    required this.height,
    required this.image,
    required this.matchTextDirection,
    required this.package,
    required this.semanticsLabel,
    this.theme = const SvgTheme(),
    required this.url,
    required this.width,
  }) : assert(
         (asset == null && url == null) ||
             (asset == null && image == null) ||
             (image == null && url == null),
       ),
       assert(asset != null || image != null || url != null),
       colorFilter =
           color == null
               ? colorFilter
               : ColorFilter.mode(color, BlendMode.srcIn);

  final Alignment alignment;
  final bool allowDrawingOutsideViewBox;
  final String? asset;
  final Clip clipBehavior;
  final ColorFilter? colorFilter;
  final bool excludeFromSemantics;
  final BoxFit fit;
  final Map<String, String>? headers;
  final double? height;
  final String? image;
  final bool matchTextDirection;
  final String? package;
  final String? semanticsLabel;
  final SvgTheme theme;
  final String? url;
  final double? width;

  /// Builds the widget from the give [data].
  @override
  Widget build(BuildContext context) {
    return asset != null
        ? WebsafeSvg.asset(
          asset!,
          alignment: alignment,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          clipBehavior: clipBehavior,
          colorFilter: colorFilter,
          excludeFromSemantics: excludeFromSemantics,
          fit: fit,
          height: height,
          matchTextDirection: matchTextDirection,
          package: package,
          semanticsLabel: semanticsLabel,
          theme: theme,
          width: width,
        )
        : image != null
        ? WebsafeSvg.memory(
          base64.decode(image!),
          alignment: alignment,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          clipBehavior: clipBehavior,
          colorFilter: colorFilter,
          excludeFromSemantics: excludeFromSemantics,
          fit: fit,
          height: height,
          matchTextDirection: matchTextDirection,
          semanticsLabel: semanticsLabel,
          theme: theme,
          width: width,
        )
        : WebsafeSvg.network(
          url!,
          alignment: alignment,
          allowDrawingOutsideViewBox: false,
          fit: fit,
          headers: headers,
          height: height,
          semanticsLabel: semanticsLabel,
          width: width,
        );
  }
}
