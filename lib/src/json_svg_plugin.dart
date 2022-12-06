import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_dynamic_widget_plugin_svg/json_dynamic_widget_plugin_svg.dart';
import 'package:json_theme/json_theme_schemas.dart';

class JsonSvgPlugin {
  static void bind(JsonWidgetRegistry registry) {
    final schemaCache = SchemaCache();
    schemaCache.addSchema(SvgSchema.id, SvgSchema.schema);

    registry.registerCustomBuilder(
      SvgBuilder.type,
      const JsonWidgetBuilderContainer(
        builder: SvgBuilder.fromDynamic,
        schemaId: SvgSchema.id,
      ),
    );
  }
}
