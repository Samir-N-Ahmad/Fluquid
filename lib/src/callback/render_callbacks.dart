import 'dart:async';

class RenderCallbacks {
  static void onRenderStreamUpdate<T>(
      T renderData, StreamSink<T> renderStream) {
    renderStream.add(renderData);
  }
}
