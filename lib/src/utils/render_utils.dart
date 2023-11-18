
import 'dart:ffi';

class RenderUtils{

      static List<double> dynamicArrayToList(Pointer<Float> array){
        List<double> list = [];

        int arraySize = array.elementAt(0).value.toInt();
        for(int i = 1; i <= arraySize; i++){
          list.add(array.elementAt(i).value);
         
        }
        return list;
      }

      static List<List<double>> dynamicArray2DToList(Pointer<Pointer<Float>> array){
        int rowsCount = array.elementAt(0).value.elementAt(0).value.toInt();
        
        List<List<double>> list = [];
        for(int i = 1; i <= rowsCount; i++){
          list.add(dynamicArrayToList(array.elementAt(i).value));
        }
        return list;
      }

}