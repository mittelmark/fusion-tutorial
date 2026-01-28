import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart'; // Import for allocation functions
// Define the C function signature
typedef HelloFunc = Pointer<Utf8> Function();
//typedef Hello = Pointer<Utf8> Function();

void main() {
  print("Greetings from Dart2!");
  // Load the shared library
  final DynamicLibrary lib = Platform.isWindows
      ? DynamicLibrary.open('hello.dll')
      : Platform.isLinux
          ? DynamicLibrary.open('libhello.so')
          : DynamicLibrary.open('libhello.dylib');

  // Look up the function
  final HelloFunc helloPtr = lib
      .lookup<NativeFunction<HelloFunc>>('Hello_GetMessage')
      .asFunction();

  // Call the function and get the result
  final Pointer<Utf8> result = helloPtr();
  print(result.toDartString());
}
