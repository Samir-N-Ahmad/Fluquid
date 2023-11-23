import 'dart:ffi';
import 'package:plugin_test/src/model/liquid_fun_engine.dart';

typedef RenderCallBaclk = Void Function(Pointer<Pointer<Float>>);

typedef LiquidInitializer = Pointer<LiquidFunEngine> Function(
    Pointer<NativeFunction<RenderCallBaclk>>);
typedef HCheck = Int32 Function();
typedef Render = Pointer<Pointer<Float>> Function(Pointer<LiquidFunEngine>);
typedef ToString = Pointer<Char> Function(Pointer<LiquidFunEngine>);
typedef Dispose = Pointer<Void> Function(Pointer<LiquidFunEngine>);

/// Add a liquid engine body with a circular shape
///
/// [liquidFunEnginePointer] a pointer to the instance of `LiquidFunEngine`
///
/// [x] the postions on the `x` coordinates
///
/// [y] the postions on the `y` coordinates
///
/// [r] the circle radius
typedef AddCircle = Pointer<Void> Function(
    Pointer<LiquidFunEngine> liquidFunEnginePointer,
    Pointer<Float> x,
    Pointer<Float> y,
    Pointer<Float> r);

typedef Start = Pointer<Void> Function(Pointer<LiquidFunEngine>);
