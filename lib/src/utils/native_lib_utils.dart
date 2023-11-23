import 'dart:ffi';

import 'package:plugin_test/src/common/custom_types.dart';

class NativeLibUtils {
  static const String libName = "libFLiquidFun.0.dylib";

  // native functions names
  static const String _nativeFunctionRender = "Liquid_Render";
  static const String _nativeFunctionToString = "to_string";
  static const String _nativeFunctionStart = "LiquidEngine_Start";
  static const String _nativeFunctionAddCircle = "LiquidEngine_Add_Circle";
  static const String _nativeFunctionDispose = "LiquidEngine_Dispose";
  static const String _nativeFunctionInit = "LiquidEngine_Initialize";

  DynamicLibrary? liquidFunLib;

  ToString? tostringFunction;
  LiquidInitializer? initalizerFunction;
  Render? renderFunction;
  Dispose? disposeFunction;
  Start? startFunction;
  AddCircle? addCircleFunction;

  Future<void> init() async {
    try {
      liquidFunLib = DynamicLibrary.open(libName);
    } catch (_) {
      throw "Error loading Liquidfun library";
    }

    // loading native functions
    // tostring
    Pointer<NativeFunction<ToString>> toString =
        liquidFunLib!.lookup(_nativeFunctionToString);
    tostringFunction = toString.asFunction();

    // initalizer
    Pointer<NativeFunction<LiquidInitializer>> liquidInitalizer =
        liquidFunLib!.lookup(_nativeFunctionInit);
    initalizerFunction = liquidInitalizer.asFunction();

    // renderer
    Pointer<NativeFunction<Render>> liquidRenderer =
        liquidFunLib!.lookup(_nativeFunctionRender);
    renderFunction = liquidRenderer.asFunction();

    // start
    Pointer<NativeFunction<Start>> liquidStart =
        liquidFunLib!.lookup(_nativeFunctionStart);
    startFunction = liquidStart.asFunction();
    // Disposed
    Pointer<NativeFunction<Dispose>> liquidDispose =
        liquidFunLib!.lookup(_nativeFunctionDispose);
    disposeFunction = liquidDispose.asFunction();
    // Add circle
    Pointer<NativeFunction<AddCircle>> liquidAddCricle =
        liquidFunLib!.lookup(_nativeFunctionAddCircle);
    addCircleFunction = liquidAddCricle.asFunction();
  }
}
