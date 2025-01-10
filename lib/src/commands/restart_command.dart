import 'package:args/command_runner.dart';
import 'package:supasync_cli/src/commands/start_command.dart';
import 'package:supasync_cli/src/commands/stop_command.dart';

class RestartCommand extends Command {
  @override
  String get name => 'restart';

  @override
  String get description => 'Restarts all Supabase anb Powersync services .';

  @override
  Future<void> run() async {
    await StopCommand().run();
    await StartCommand().run();
  }
}
