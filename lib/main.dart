
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:plugin_test/src/utils/render_utils.dart';
import 'package:plugin_test/src/view/widgets/render_widget.dart';

import 'liquid_fun_engine.dart';



typedef LiquidInitializer = Pointer<LiquidFunEngine> Function();
typedef HCheck = Int32 Function();
typedef Render = Pointer<Pointer<Float>> Function(Pointer<LiquidFunEngine>);
typedef ToString = Pointer<Char> Function(Pointer<LiquidFunEngine>);
typedef Dispose = Pointer<Void> Function(Pointer<LiquidFunEngine>);
typedef AddCircle = Pointer<Void> Function(Pointer<LiquidFunEngine>, Pointer<Float> x, Pointer<Float> y, Pointer<Float> r);

void main() {
  DynamicLibrary lib = DynamicLibrary.open("libFLiquidFun.0.dylib");
  Pointer<LiquidFunEngine> liquidPointer ;

  // initialize
  Pointer<NativeFunction<Pointer<LiquidFunEngine> Function()>> f = lib.lookup("LiquidEngine_Initialize");
  Pointer<LiquidFunEngine> Function() intialize = f.asFunction();
  liquidPointer = intialize.call();

  // tostring
  Pointer<NativeFunction<ToString>> toString = lib.lookup("to_string");
  ToString toStringF = toString.asFunction();

  //dispose
  Pointer<NativeFunction<Dispose>> dispose = lib.lookup("LiquidEngine_Dispose");

    //add circle
  Pointer<NativeFunction<AddCircle>> addCircle = lib.lookup("LiquidEngine_Add_Circle");
  Pointer<Void> Function(Pointer<LiquidFunEngine>, Pointer<Float> x, Pointer<Float> y, Pointer<Float> r) addCircleFunction = addCircle.asFunction();

  Pointer<Float> x = calloc.allocate(4);
  Pointer<Float> y = calloc.allocate(4);
  Pointer<Float> r = calloc.allocate(4);
  x.value  = 1;
  y.value  = 1;
  r.value  = 1;
  addCircleFunction.call(liquidPointer, x,y,r);
  addCircleFunction.call(liquidPointer, x..value = 3, y..value = 3, r..value= 3);

 // render
  Pointer<NativeFunction<Pointer<Pointer<Float>> Function(Pointer<LiquidFunEngine>)>> render = lib.lookup("Liquid_Render");
  Pointer<Pointer<Float>> Function(Pointer<LiquidFunEngine>) renderFunction = render.asFunction();
  Pointer<Pointer<Float>> renderResult = renderFunction.call(liquidPointer);


  for(int i = 0; i<= 2;i++) {
    for(int j = 1; j<= 2;j++) {
      print("DART === ${renderResult.elementAt(i).value.asTypedList(4)}");
    }
  }
       List<List<double>> paths =   RenderUtils.dynamicArray2DToList(renderResult);
  // renderResult..value.asTypedList(2);
  runApp(MaterialApp(builder: (context, _) =>  SizedBox(
    width: 200,
    height: 400,
    
    child: RenderWidget(paths: paths)),));

}


