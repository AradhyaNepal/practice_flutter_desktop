import 'package:flutter/services.dart';

class KeyboardManager{
  static const platform = MethodChannel('disable_keyboard');
  static Future<void> blockInput(bool disable)async{
    try {
      final result = await platform.invokeMethod(disable?'disable':'enable');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to invoke method: ${e.message}");
    }
  }

}