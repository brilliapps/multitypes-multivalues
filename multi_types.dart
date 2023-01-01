/// Yeah, yeah , the name looks catchy, but... This library solves the simplest way the problem of not having union types in dart like in TypeScript for example
/// Below all you need to have an object which carries one of two generically hinted types. If there is any type mismatching you editor should inform you about error.
/// Examples show how to use it. At your disposal there is [Types] and [Types3] abstract classess, but the object itself you create using [TypesV], [TypesW] for two types [Types] object.
/// There is .v property (value) which you can change but according to it's type (you can change the behaviour by changing class content)
/// You have an example types_example_test_method(Types<int, String> string_or_int) method, if you pass as an argument in this example which is not exactly int or String you have compilation time or in-editor error. The value you get from the .v property.

abstract class Types<V, W> {}

class TypesV<V, W> extends Types<V, W> {
  V v;
  TypesV(this.v);
}

class TypesW<V, W> extends Types<V, W> {
  W v;
  TypesW(this.v);
}

// -----------------------------------

abstract class MTypes<V, W> {}

class MTypesV<V, W> extends MTypes<V, W> {
  dynamic _v;
  final Type type;
  MTypesV(V this._v)
      : this.type = _v is MTypesV
            ? _v.v.runtimeType
            : _v is MTypesW
                ? _v.v.runtimeType
                : V;

  set v(value) {
    if (type is! MTypesV && type is! MTypesW) {
      _v = value;
    } else {
      _v.v = value;
    }
  }

  dynamic get v {
    return type is! MTypesV && type is! MTypesW ? _v : _v.v;
  }
}

class MTypesW<V, W> extends MTypes<V, W> {
  dynamic _v;
  final Type type;
  MTypesW(W this._v)
      : this.type = _v is MTypesV
            ? _v.v.runtimeType
            : _v is MTypesW
                ? _v.v.runtimeType
                : W;

  set v(value) {
    if (type is! MTypesV && type is! MTypesW) {
      _v = value;
    } else {
      _v.v = value;
    }
  }

  dynamic get v {
    return type is! MTypesV && type is! MTypesW ? _v : _v.v;
  }
}

// ----------------------------------

abstract class Types3<V, W, U> {}

class Types3V<V, W, U> extends Types3<V, W, U> {
  V v;
  Types3V(this.v);
}

class Types3W<V, W, U> extends Types3<V, W, U> {
  W v;
  Types3W(this.v);
}

class Types3U<V, W, U> extends Types3<V, W, U> {
  U v;
  Types3U(this.v);
}

void types_example_test_method(Types<int, String> string_or_int) {
  //return 'abc';
}

/// Stub, not a solution but a convention/pattern of doing something: this is interface, not detecting compile time errors like [Types] class, but just hinting you create object with the list of values acceptable but one can be used and stored also in .v property like in TypesV or TypesW for example
/// However this time it is a static property of an extending class which must contain the values acceptable.
/// Additionally This should contain testing capability before an object is created and throwing exception if there is a try to assign a wrong value. Or possibly some other way to avoid runtime errors/exceptions so that you can code with this in mind that the app will work after compilation.
abstract class Values {}

// Stub : and this is implementation
class ValuesFancyValues extends Values {}

void values_example_test_method(ValuesFancyValues string_or_int) {}

// examples
Types<int, String> abctyabctyabctyabcty = TypesV<int, String>(10);
Types<int, String> abcdeabcdeabcdeabcde = TypesW<int, String>('qwe');
var abcdekabcdekabcdekabcdek = TypesW<int, String>('qwe');
//ok:
var abcdekuucccccccc = TypesW<int, String>('qwe');
var rtetuucccccccccc = types_example_test_method(abcdekuucccccccc);
//error:
//Types<int, String> abc = TypesV<int, String>(10.4);
//error:
//Types<int, String> abcaabca = TypesV<double, String>(10.4);
//error:
//Types abcdekuu = TypesW<int, String>('qwe');
//var rtetuu = types_example_test_method(abcdekuu);
//error:
//var abcdekkkkkkkkkk = TypesW('qwe');
//var rtetuuqqqqqqqqq = types_example_test_method(abcdekkkkkkkkkk);

/// Such an example idea that seems to work but not tested. If the classess were enhanced to accommodate to such a syntax you could do something like this.
var abcdekabcdekabcdekabcdek4 =
    TypesV<Types<int, String>, Types<num, List>>(abctyabctyabctyabcty);

var rtetdefprtetdefp = types_example_test_method(abcdeabcdeabcdeabcde);
var rtetdefprtetdefp2 = types_example_test_method(abctyabctyabctyabcty);
var rtetdefprtetdefp3 = types_example_test_method(abcdekabcdekabcdekabcdek);

void types_example_test_method2(MTypes<int, String> string_or_int) {
  //return 'abc';
}

// examples
MTypes<int, String> abctyabctyabctyabcty2 = MTypesV<int, String>(10);
MTypes<int, String> abcdeabcdeabcdeabcde2 = MTypesW<int, String>('qwe');
var abcdekabcdekabcdekabcdek2 = MTypesW<int, String>('qwe');
//ok:
var abcdekuucccccccc2 = MTypesW<int, String>('qwe');
var rtetuucccccccccc2 = types_example_test_method2(abcdekuucccccccc2);
//error:
//MTypes<int, String> abc2 = MTypesV<int, String>(10.4);
//error:
//MTypes<int, String> abcaabca2 = MTypesV<double, String>(10.4);
//error:
//MTypes abcdekuu2 = MTypesW<int, String>('qwe');
//var rtetuu2 = types_example_test_method2(abcdekuu2);
//error:
//var abcdekkkkkkkkkk2 = MTypesW('qwe');
//var rtetuuqqqqqqqqq2 = types_example_test_method2(abcdekkkkkkkkkk2);

/// Such an example idea that seems to work but not tested. If the classess were enhanced to accommodate to such a syntax you could do something like this.
var abcdekabcdekabcdekabcdek42 =
    MTypesV<MTypes<int, String>, MTypes<num, List>>(abctyabctyabctyabcty2);

var rtetdefprtetdefp222 = types_example_test_method2(abcdeabcdeabcdeabcde2);
var rtetdefprtetdefp22 = types_example_test_method2(abctyabctyabctyabcty2);
var rtetdefprtetdefp32 = types_example_test_method2(abcdekabcdekabcdekabcdek2);

void types_example_test_method3(
    MTypes<MTypes<int, String>, MTypes<Future, List>> string_or_int) {
  //return 'abc';
}

void types_example_test_method4(
    MTypes<MTypes<int, String>, Future> string_or_int) {
  //return 'abc';
}

void types_example_test_method5(
    MTypes<Future, MTypes<int, String>> string_or_int) {
  //return 'abc';
}

MTypes<MTypes<int, String>, MTypes<Future, List>> abcdekuu2vvbbvvv1 =
    MTypesV<MTypes<int, String>, MTypes<Future, List>>(
        MTypesV<int, String>(15));
var rtetdefprtetdefp32rrr1 = types_example_test_method3(abcdekuu2vvbbvvv1);
MTypesV<MTypes<int, String>, MTypes<Future, List>> abcdekuu2vvbbvvv2 =
    MTypesV<MTypes<int, String>, MTypes<Future, List>>(
        MTypesW<int, String>('ergrdherh'));
var rtetdefprtetdefp32rrr2 = types_example_test_method3(abcdekuu2vvbbvvv2);


// I DON'T WANT TO TEST IT ANYMORE :) BUT IT SHOULD WORK AS EXPECTED. YOU CAN NEST IT IF YOU WANT




