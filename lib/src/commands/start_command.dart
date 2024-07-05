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
  void run() async {
    'supabase start'.start(terminal: true);

    'docker compose -f powersync/powersync_compose.yaml up -d'.start();

    // Clean up exited containers
    'docker container prune -f'.start();

    var mongoSetup = Docker().containers().firstWhereOrNull((container) => container.name == 'mongo-rs-init');

    if (mongoSetup != null) {
      int maxWaitTime = 5;
      int waitTime = 0;

      while (mongoSetup.isRunning && waitTime < maxWaitTime) {
        await Future.delayed(Duration(seconds: 1));
      }

      if (!mongoSetup.isRunning) {
        mongoSetup.stop();
      }
    }

    ConsoleUtils.writeLineColored('Supabase & PowerSync started successfully.', ConsoleColor.green);
  }
}
