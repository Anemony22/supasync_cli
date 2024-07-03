import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:supasync_cli/src/console_utils/spinner.dart';

import '../console_utils/console_utils.dart';

class TestCommand extends Command {
  @override
  String get name => 'test';

  @override
  String get description => 'Test command';

  @override
  void run() async {
    ConsoleUtils.writeLine('Starting test...');
    ConsoleUtils.writeLine('''Running at '${Directory.current.path}' ''');

    var spinner = Spinner(loadingMessage: 'Loading...', completeMessage: 'Complete');
    await Future.delayed(Duration(seconds: 3));
    await spinner.stop();

    ConsoleUtils.writeLine('Test complete!');
  }
}
