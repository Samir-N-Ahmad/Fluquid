 import 'dart:ffi';


final class LiquidFunEngine extends Struct {

  @Int()
  external int id;

  external static  LiquidFunEngine instance();
  external void dispose();
  external void intialize(Array<Double> a);
  external void draw();

  external void addCircle( Pointer<Float> radius, Pointer<Float> xPosition, Pointer<Float>  yPosition);
  external List<List<Double>> render();
  external String toString();
  external String a();
}