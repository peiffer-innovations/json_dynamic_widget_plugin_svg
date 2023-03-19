import 'package:json_theme/json_theme_schemas.dart';

class SvgSchema {
  static const id =
      'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/json_dynamic_widget_plugin_svg/svg.json';

  static final schema = {
    r'$schema': 'http://json-schema.org/draft-06/schema#',
    r'$id': '$id',
    r'$children': 0,
    'title': 'Svg',
    'type': 'object',
    'additionalProperties': false,
    'properties': {
      'alignment': SchemaHelper.objectSchema(AlignmentSchema.id),
      'asset': SchemaHelper.stringSchema,
      'color': SchemaHelper.objectSchema(ColorSchema.id),
      'colorBlendMode': SchemaHelper.objectSchema(BlendModeSchema.id),
      'colorFilter': SchemaHelper.stringSchema,
      'fit': SchemaHelper.objectSchema(BoxFitSchema.id),
      'headers': SchemaHelper.anySchema,
      'height': SchemaHelper.numberSchema,
      'image': SchemaHelper.stringSchema,
      'package': SchemaHelper.stringSchema,
      'semanticsLabel': SchemaHelper.stringSchema,
      'url': SchemaHelper.stringSchema,
      'width': SchemaHelper.numberSchema
    },
  };
}
