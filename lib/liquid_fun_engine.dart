 import 'dart:ffi' as ffi;


final class LiquidFunEngine extends ffi.Struct {

  @ffi.Int()
  external int id;

  external void draw();
  external void intialize();
  external void dispose();
  external void render();
}