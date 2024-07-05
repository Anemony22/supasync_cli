import 'dart:async';
import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:supasync_cli/src/console_utils/console_utils.dart';

class Spinner {
  final List<String> _frames = [
    '⠁',
    '⠂',
    '⠄',
    '⡀',
    '⡈',
    '⡐',
    '⡠',
    '⣀',
    '⣁',
    '⣂',
    '⣄',
    '⣌',
    '⣔',
    '⣤',
    '⣥',
    '⣦',
    '⣮',
    '⣶',
    '⣷',
    '⣿',
    '⡿',
    '⠿',
    '⢟',
    '⠟',
    '⡛',
    '⠛',
    '⠫',
    '⢋',
    '⠋',
    '⠍',
    '⡉',
    '⠉',
    '⠑',
    '⠡',
    '⢁'
  ];

  int _currentFrame = 0;
  bool _running = true;
  final Completer _updateCompleter = Completer();

  String loadingMessage;
  String? completeMessage;

  Spinner({this.loadingMessage = 'Loading...', this.completeMessage}) {
    completeMessage ??= loadingMessage;
    scheduleMicrotask(_update);
  }

  Future<void> stop() async {
    _running = false;

    // Wait for update cycle to finish
    await _updateCompleter.future;

    Console().showCursor();
  }

  void _update() async {
    Console().hideCursor(); // Stops the annoying flickering that comes from rewrite

    while (_running) {
      await Future.delayed(Duration(milliseconds: 80));
      _render();
    }

    _updateCompleter.complete();
  }

  void _render() {
    stdout.write('\r');

    if (_running) {
      ConsoleUtils.writeColored(_frames[_currentFrame++ % _frames.length], ConsoleColor.cyan);
      ConsoleUtils.write(' $loadingMessage');
    } else {
      ConsoleUtils.writeColored('✓', ConsoleColor.green);
      ConsoleUtils.writeLine(' $completeMessage');
    }
  }
}
