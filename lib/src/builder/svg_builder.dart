import 'dart:convert';

import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';
import 'package:websafe_svg/websafe_svg.dart';

/// Creates a SVG via the [WebsafeSvg] widget based on the JSON structure.
class SvgBuilder extends JsonWidgetBuilder {
  SvgBuilder({
    required this.alignment,
    required this.asset,
    required this.color,
    required this.fit,
    required this.headers,
    required this.height,
    required this.image,
    required this.package,
    required this.semanticsLabel,
    required this.url,
    required this.width,
  })  : assert((asset == null && url == null) ||
            (asset == null && image == null) ||
            (image == null && url == null)),
        assert(asset != null || image != null || url != null),
        super(numSupportedChildren: kNumSupportedChildren);

  static const kNumSupportedChildren = 0;
  static const type = 'svg';

  final Alignment? alignment;
  final String? asset;
  final Color? color;
  final BoxFit? fit;
  final Map<String, String>? headers;
  final double? height;
  final String? image;
  final String? package;
  final String? semanticsLabel;
  final String? url;
  final double? width;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "alignment": <AlignmentGeometry>,
  ///   "asset": <String>,
  ///   "color": <Color>,
  ///   "fit": <BoxFit>,
  ///   "headers": <Map<String, String>>,
  ///   "height": <double>,
  ///   "image": <String>,
  ///   "package": <String>,
  ///   "semanticsLabel": <String>,
  ///   "url": <String>,
  ///   "width": <double>
  /// }
  /// ```
  ///
  /// See also:
  ///  * [ThemeDecoder.decodeAlignment]
  ///  * [ThemeDecoder.decodeBoxFit]
  ///  * [ThemeDecoder.decodeColor]
  static SvgBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) {
    if (map == null) {
      throw Exception('[SvgBuilder]: map is null');
    }

    return SvgBuilder(
      alignment: ThemeDecoder.decodeAlignment(
        map['alignment'],
        validate: false,
      ),
      asset: map['asset'],
      color: ThemeDecoder.decodeColor(
        map['color'],
        validate: false,
      ),
      fit: ThemeDecoder.decodeBoxFit(
        map['fit'],
        validate: false,
      ),
      headers: map['headers'] == null
          ? null
          : Map<String, String>.from(map['headers']),
      height: JsonClass.parseDouble(map['height']),
      image: map['image'],
      package: map['package'],
      semanticsLabel: map['sementicsLabel'],
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
            color: color,
            fit: fit ?? BoxFit.contain,
            height: height,
            package: package,
            semanticsLabel: semanticsLabel,
            width: width,
          )
        : image != null
            ? WebsafeSvg.memory(
                base64.decode(
                  image!,
                ),
                alignment: alignment ?? Alignment.center,
                color: color,
                fit: fit ?? BoxFit.contain,
                height: height,
                semanticsLabel: semanticsLabel,
                width: width,
              )
            : WebsafeSvg.network(
                url!,
                alignment: alignment ?? Alignment.center,
                color: color,
                fit: fit ?? BoxFit.contain,
                headers: headers,
                height: height,
                semanticsLabel: semanticsLabel,
                width: width,
              );
  }
}
