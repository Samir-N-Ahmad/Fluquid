
import 'dart:ffi' as flutter_ffi;
import 'liquid_fun_engine.dart';



typedef LiquidInitializer = flutter_ffi.Pointer<LiquidFunEngine> Function();
typedef HCheck = flutter_ffi.Int32 Function();
typedef Render = flutter_ffi.Pointer<flutter_ffi.Pointer<flutter_ffi.Float>> Function(flutter_ffi.Pointer<LiquidFunEngine>);
typedef ToString = flutter_ffi.Pointer<flutter_ffi.Char> Function(flutter_ffi.Pointer<LiquidFunEngine>);
typedef Dispose = flutter_ffi.Pointer<flutter_ffi.Void> Function(flutter_ffi.Pointer<LiquidFunEngine>);
typedef AddCircle = flutter_ffi.Pointer<flutter_ffi.Void> Function(flutter_ffi.Pointer<LiquidFunEngine>);

void main() {
  flutter_ffi.DynamicLibrary lib = flutter_ffi.DynamicLibrary.open("./build/external_libs/libFLiquidFun.0.dylib");
  flutter_ffi.Pointer<LiquidFunEngine> liquidPointer ;

  // initialize
  flutter_ffi.Pointer<flutter_ffi.NativeFunction<flutter_ffi.Pointer<LiquidFunEngine> Function()>> f = lib.lookup("LiquidEngine_Initialize");
  flutter_ffi.Pointer<LiquidFunEngine> Function() intialize = f.asFunction();
  liquidPointer = intialize.call();

  // tostring
  flutter_ffi.Pointer<flutter_ffi.NativeFunction<ToString>> toString = lib.lookup("to_string");
  ToString toStringF = toString.asFunction();

  //dispose
  flutter_ffi.Pointer<flutter_ffi.NativeFunction<Dispose>> dispose = lib.lookup("LiquidEngine_Dispose");

  

 // render
  flutter_ffi.Pointer<flutter_ffi.NativeFunction<flutter_ffi.Pointer<flutter_ffi.Pointer<flutter_ffi.Float>> Function(flutter_ffi.Pointer<LiquidFunEngine>)>> render = lib.lookup("Liquid_Render");
  flutter_ffi.Pointer<flutter_ffi.Pointer<flutter_ffi.Float>> Function(flutter_ffi.Pointer<LiquidFunEngine>) renderFunction = render.asFunction();
  flutter_ffi.Pointer<flutter_ffi.Pointer<flutter_ffi.Float>> renderResult = renderFunction.call(liquidPointer);

  flutter_ffi.Pointer<flutter_ffi.Char> aaa = toStringF.call(liquidPointer);

}


