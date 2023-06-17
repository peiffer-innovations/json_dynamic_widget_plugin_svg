import 'dart:convert';

import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_dynamic_widget_plugin_svg/json_dynamic_widget_plugin_svg.dart';
import 'package:json_theme/json_theme.dart';
import 'package:websafe_svg/websafe_svg.dart';

/// Creates a SVG via the [WebsafeSvg] widget based on the JSON structure.
class SvgBuilder extends JsonWidgetBuilder {
  SvgBuilder({
    required this.alignment,
    required this.allowDrawingOutsideViewBox,
    required this.asset,
    required this.clipBehavior,
    required this.colorFilter,
    required this.excludeFromSemantics,
    required this.fit,
    required this.headers,
    required this.height,
    required this.image,
    required this.matchTextDirection,
    required this.package,
    required this.semanticsLabel,
    required this.theme,
    required this.url,
    required this.width,
  })  : assert((asset == null && url == null) ||
            (asset == null && image == null) ||
            (image == null && url == null)),
        assert(asset != null || image != null || url != null),
        super(numSupportedChildren: kNumSupportedChildren);

  static const kNumSupportedChildren = 0;
  static const kType = 'svg';

  final Alignment? alignment;
  final bool allowDrawingOutsideViewBox;
  final String? asset;
  final Clip clipBehavior;
  final ColorFilter? colorFilter;
  final bool excludeFromSemantics;
  final BoxFit? fit;
  final Map<String, String>? headers;
  final double? height;
  final String? image;
  final bool matchTextDirection;
  final String? package;
  final String? semanticsLabel;
  final SvgTheme? theme;
  final String? url;
  final double? width;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "alignment": "<AlignmentGeometry>",
  ///   "allowDrawingOutsideViewBox": "<bool>",
  ///   "asset": "<String>",
  ///   "clipBehavior": "<Clip>",
  ///   "color": "<Color>"
  ///   "colorFilter": "<ColorFilter>",
  ///   "excludeFromSemantics": "<bool>",
  ///   "fit": "<BoxFit>",
  ///   "headers": "<Map<String, String>>",
  ///   "height": "<double>",
  ///   "image": "<String>",
  ///   "matchTextDirection": "<bool>",
  ///   "package": "<String>",
  ///   "semanticsLabel": "<String>",
  ///   "theme": "<SvgTheme>",
  ///   "url": "<String>",
  ///   "width": "<double>"
  /// }
  /// ```
  ///
  /// See also:
  ///  * [ThemeDecoder.decodeAlignment]
  ///  * [ThemeDecoder.decodeBoxFit]
  ///  * [ThemeDecoder.decodeClip]
  static SvgBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) {
    if (map == null) {
      throw Exception('[SvgBuilder]: map is null');
    }

    final color = ThemeDecoder.decodeColor(
      map['color'],
      validate: false,
    );

    return SvgBuilder(
      alignment: ThemeDecoder.decodeAlignment(
        map['alignment'],
        validate: false,
      ),
      allowDrawingOutsideViewBox:
          JsonClass.parseBool(map['allowDrawingOutsideViewBox']),
      asset: map['asset'],
      clipBehavior:
          ThemeDecoder.decodeClip(map['clipBehabor']) ?? Clip.hardEdge,
      colorFilter: color == null
          ? ThemeDecoder.decodeColorFilter(
              map['colorFilter'],
              validate: false,
            )
          : ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
      excludeFromSemantics: JsonClass.parseBool(map['excludeFromSemantics']),
      fit: ThemeDecoder.decodeBoxFit(
        map['fit'],
        validate: false,
      ),
      headers: map['headers'] == null
          ? null
          : Map<String, String>.from(map['headers']),
      height: JsonClass.parseDouble(map['height']),
      image: map['image'],
      matchTextDirection: JsonClass.parseBool(map['matchTextDirection']),
      package: map['package'],
      semanticsLabel: map['sementicsLabel'],
      theme: SvgThemeDecoder.decode(map['theme']),
      url: map['url'],
      width: JsonClass.parseDouble(map['width']),
    );
  }

  /// Builds the widget from the give [data].
  @override
  Widget buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    assert(
      data.children?.isNotEmpty != true,
      '[SvgBuilder] does not support children.',
    );

    return asset != null
        ? WebsafeSvg.asset(
            asset!,
            alignment: alignment ?? Alignment.center,
            allowDrawingOutsideViewBox: false,
            clipBehavior: clipBehavior,
            colorFilter: colorFilter,
            excludeFromSemantics: excludeFromSemantics,
            fit: fit ?? BoxFit.contain,
            height: height,
            matchTextDirection: matchTextDirection,
            package: package,
            semanticsLabel: semanticsLabel,
            theme: theme ?? const SvgTheme(),
            width: width,
          )
        : image != null
            ? WebsafeSvg.memory(
                base64.decode(
                  image!,
                ),
                alignment: alignment ?? Alignment.center,
                allowDrawingOutsideViewBox: false,
                clipBehavior: clipBehavior,
                colorFilter: colorFilter,
                excludeFromSemantics: excludeFromSemantics,
                fit: fit ?? BoxFit.contain,
                height: height,
                matchTextDirection: matchTextDirection,
                semanticsLabel: semanticsLabel,
                theme: theme ?? const SvgTheme(),
                width: width,
              )
            : WebsafeSvg.network(
                url!,
                alignment: alignment ?? Alignment.center,
                allowDrawingOutsideViewBox: false,
                fit: fit ?? BoxFit.contain,
                headers: headers,
                height: height,
                semanticsLabel: semanticsLabel,
                width: width,
              );
  }
}
