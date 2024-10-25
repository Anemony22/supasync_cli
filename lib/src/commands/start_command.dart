import 'package:args/command_runner.dart';
import 'package:collection/collection.dart';
import 'package:dart_console/dart_console.dart';
import 'package:dcli/dcli.dart';
import 'package:docker2/docker2.dart';
import 'package:supasync_cli/src/console_utils/console_utils.dart';

class StartCommand extends Command {
  StartCommand();

  @override
  String get name => 'start';

  @override
  String get description => 'Starts Supabase and PowerSync services.';

  @override
  Future<void> run() async {
    'supabase start'.start(terminal: true);

    ConsoleUtils.writeLine('');

    'docker compose -f powersync/powersync_compose.yaml --env-file .env up -d '.start(progress: Progress.capture(), terminal: true);

    ConsoleUtils.writeLine('');

    // Clean up exited containers
    var mongoSetup = Docker().containers().firstWhereOrNull((container) => container.name.contains('mongo-rs-init'));

    if (mongoSetup != null) {
      int maxWaitTime = 5;
      int waitTime = 0;

      while (mongoSetup.isRunning && waitTime < maxWaitTime) {
        await Future.delayed(Duration(seconds: 1));
        waitTime++;
      }

      if (!mongoSetup.isRunning) {
        mongoSetup.delete();
      }
    }

    ConsoleUtils.writeLineColored('Supabase & PowerSync started successfully.', ConsoleColor.green);
  }
}
