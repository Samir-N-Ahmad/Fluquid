
import 'dart:ffi' as flutter_ffi;
import 'package:ffi/ffi.dart' as ffi;
import 'liquid_fun_engine.dart';



typedef LiquidInitializer = flutter_ffi.Void Function(flutter_ffi.Pointer<LiquidFunEngine>);
typedef HCheck = flutter_ffi.Int32 Function();

void main() {
  flutter_ffi.DynamicLibrary lib = flutter_ffi.DynamicLibrary.open("libFLiquidFun.0.dylib");
  var f = lib.lookup("LiquidEngine_Initialize");
  var healthCheck = lib.lookup("Health_Check");
    final flutter_ffi.Pointer<LiquidFunEngine> physicsEngine = ffi.malloc<LiquidFunEngine>();
    void Function(flutter_ffi.Pointer<LiquidFunEngine>) a = f.cast<flutter_ffi.NativeFunction<LiquidInitializer>>().asFunction();
    int Function() h = healthCheck.cast<flutter_ffi.NativeFunction<HCheck>>().asFunction();
    print("this is the healthcheck ${h()}");
    

    a.call(physicsEngine);
}


