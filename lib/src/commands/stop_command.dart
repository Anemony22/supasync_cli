import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:dcli/dcli.dart';
import 'package:supasync_cli/src/console_utils/console_utils.dart';

class StopCommand extends Command {
  StopCommand();

  @override
  String get name => 'stop';

  @override
  String get description => 'Stops Supabase and PowerSync services.';

  @override
  void run() async {
    final powersyncCmd = 'docker compose -f powersync/powersync-compose.yaml down'.start();

    final supabaseCmd = 'supabase stop'.start(terminal: true);

    ConsoleUtils.writeLineColored('Supabase & PowerSync stopped successfully.', ConsoleColor.green);
  }
}
