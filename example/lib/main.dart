import 'dart:convert';

import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_dynamic_widget_plugin_svg/json_dynamic_widget_plugin_svg.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    if (record.error != null) {
      debugPrint('${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('${record.stackTrace}');
    }
  });

  final navigatorKey = GlobalKey<NavigatorState>();

  final registry = JsonWidgetRegistry.instance;
  JsonSvgPluginRegistrar.registerDefaults(registry: registry);

  registry.navigatorKey = navigatorKey;

  final data = JsonWidgetData.fromDynamic(
    json.decode(await rootBundle.loadString('assets/pages/images.json')),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SvgWidgetPage(
        data: data,
      ),
      theme: ThemeData.light(),
    ),
  );
}

class SvgWidgetPage extends StatelessWidget {
  const SvgWidgetPage({
    super.key,
    required this.data,
  });

  final JsonWidgetData data;

  @override
  Widget build(BuildContext context) => data.build(context: context);
}
