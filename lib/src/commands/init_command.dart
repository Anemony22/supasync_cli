import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:dcli/dcli.dart';
import 'package:dotenv/dotenv.dart';
import 'package:path/path.dart';
import 'package:process_run/shell_run.dart';

import '../console_utils/console_utils.dart';

/// Init leaf command.
/// Sets up supabase and powersync directories
class InitCommand extends Command {
  DotEnv env;

  InitCommand(this.env);

  @override
  String get name => 'init';

  @override
  String get description => 'Initialises Supabase and PowerSync within the directory.'
      "Runs 'supabase init' as well as custom PowerSync setup."
      "If used after running 'supabase init', will only set up PowerSync in directory.";

  @override
  void run() async {
    // Attempt to run Supabase CLI init
    try {
      'supabase init --with-vscode-settings'.start();
    } catch (e) {
      ConsoleUtils.writeError("Supabase CLI not accessible. Ensure you've followed the Supabase CLI setup instructions.");
    }

    // Create directories
    String currentDir = Directory.current.path;
    String envPath = join(currentDir, '.env');

    String powersyncDir = join(currentDir, 'powersync');
    String configPath = join(powersyncDir, 'config.yaml');
    String syncRulesPath = join(powersyncDir, 'sync_rules.yaml');

    await File(envPath).create();

    await Directory(powersyncDir).create();
    await File(configPath).create();
    await File(syncRulesPath).create();

    ConsoleUtils.write('Finished ');
    ConsoleUtils.writeColored('supasync init', ConsoleColor.cyan);
    ConsoleUtils.write('.');
  }
}
