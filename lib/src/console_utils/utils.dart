import 'package:dart_console/dart_console.dart';

class ConsoleUtils {
  static void write(String text) {
    Console().write(text);
  }

  static void writeLine(String text) {
    Console().writeLine(text);
  }

  static void writeColored(String text, ConsoleColor color) {
    Console().setForegroundColor(color);
    Console().write(text);
    Console().resetColorAttributes();
  }
}
