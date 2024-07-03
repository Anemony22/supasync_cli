import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:supasync_cli/supasync_cli.dart';

void printUsage(CommandRunner argParser) {
  print('Usage: dart supasync_cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> args) {
  var runner = CommandRunner('supasync', 'A CLI tool to streamline local development with Supabase and PowerSync.')..addCommand(TestCommand());

  runner.argParser.addFlag('verbose', abbr: 'v', help: 'Displays extra logging information for a command.');

  runner.run(args).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    print('');
    printUsage(runner);
    exit(64); // Exit code 64 indicates a usage error.
  });
}
