import 'package:flutter/material.dart';
import 'package:plugin_test/src/service/render_service.dart';
import 'package:plugin_test/src/view/widgets/render_widget.dart';

void main() async {
  await RenderService.instance().init();
  RenderService.instance().addCircle(1, 2, 4);
  RenderService.instance().addCircle(100, 200, 40);
  RenderService.instance().addCircle(1000, 2000, 40);
  RenderService.instance().start();
  runApp(MaterialApp(
    builder: (context, _) => SizedBox(
        width: 200,
        height: 400,
        child: StreamBuilder<List<List<double>>>(
            stream: RenderService.instance().circlesStream,
            builder: (context, snapshot) {
              return RenderWidget(
                paths: snapshot.data ?? [],
              );
            })),
  ));
}
