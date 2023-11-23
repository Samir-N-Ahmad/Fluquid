import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:plugin_test/src/common/custom_types.dart';
import 'package:plugin_test/src/model/liquid_fun_engine.dart';
import 'package:plugin_test/src/utils/native_lib_utils.dart';
import 'package:plugin_test/src/utils/render_utils.dart';

class RenderService {
  static final RenderService _instance = RenderService._internal();
  RenderService._internal();
  bool isInialized = false;
  factory RenderService.instance() => _instance;

  late NativeLibUtils _nativeLibUtils;
  late Pointer<LiquidFunEngine> _liquidFunEngine;
  late NativeCallable<RenderCallBaclk> _renderNativeCallback;

  final StreamController<List<List<double>>> _circlesStreamController =
      StreamController();

  Stream<List<List<double>>> get circlesStream =>
      _circlesStreamController.stream;

  void addCircle(double x, double y, double r) {
    Pointer<Float> xCoordinate = calloc.allocate(4);
    Pointer<Float> yCoordinate = calloc.allocate(4);
    Pointer<Float> radius = calloc.allocate(4);
    xCoordinate.value = x;
    yCoordinate.value = y;
    radius.value = r;

    _nativeLibUtils.addCircleFunction!
        .call(_liquidFunEngine, xCoordinate, yCoordinate, radius);

    calloc.free(xCoordinate);
    calloc.free(yCoordinate);
    calloc.free(radius);
  }

  void start() async {
    _nativeLibUtils.startFunction!.call(_liquidFunEngine);
  }

  Future<void> init() async {
    _nativeLibUtils = NativeLibUtils();

    // ini library
    await _nativeLibUtils.init();

    // create a native callback for rendering
    _renderNativeCallback = NativeCallable<RenderCallBaclk>.listener(_onRender);

    // init the LiquidEngine native class
    _liquidFunEngine = _nativeLibUtils.initalizerFunction!
        .call(_renderNativeCallback.nativeFunction);

    // init circles stream
  }

  static void _onRender(Pointer<Pointer<Float>> data) {
    List<List<double>> list = RenderUtils.dynamicArray2DToList(data);
    _instance._circlesStreamController.sink.add(list);
  }

  dispose() {
    calloc.free(_liquidFunEngine);
  }
}
