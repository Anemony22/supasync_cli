import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:supasync_cli/src/commands/start_command.dart';
import 'package:supasync_cli/src/commands/stop_command.dart';

import 'package:supasync_cli/supasync_cli.dart';

void main(List<String> args) {
  var runner = CommandRunner('supasync', 'A CLI tool to streamline local development with Supabase and PowerSync.')
    ..addCommand(TestCommand())
    ..addCommand(InitCommand())
    ..addCommand(StartCommand())
    ..addCommand(StopCommand());

  runner.argParser.addFlag('verbose', abbr: 'v', negatable: false, help: 'Displays extra logging information for a command.');

  runner.run(args).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  });
}
