import 'package:dart_console/dart_console.dart';

class ConsoleUtils {
  static final Console con = Console();

  static void write(String text) {
    con.write(text);
  }

  static void writeLine(String text) {
    con.writeLine(text);
  }

  static void writeColored(String text, ConsoleColor color) {
    con.setForegroundColor(color);
    con.write(text);
    con.resetColorAttributes();
  }

  static void writeError(String text) {
    con.writeErrorLine(text);
  }
}
