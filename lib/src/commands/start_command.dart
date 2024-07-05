import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:docker2/docker2.dart';
import 'package:dotenv/src/dotenv.dart';
import 'package:path/path.dart';
import 'package:supasync_cli/src/console_utils/console_utils.dart';

class StartCommand extends Command {
  DotEnv env;

  StartCommand(this.env);

  @override
  String get name => 'start';

  @override
  String get description => 'Starts Supabase and PowerSync services.';

  @override
  void run() async {
    // Attempt to run Supabase CLI init
    var powersyncImageName = 'journeyapps/powersync-service';
    var powersyncImage = Docker().findImageByName(powersyncImageName) ?? Docker().pull(powersyncImageName);
    var mongoImage = Docker().findImageByName('mongo') ?? Docker().pull('mongo');

    // Docker().run(mongoImage, args: [
    //   '--name mongo-db',
    //   '-d',
    //   '-p 27017:27017',
    // ]);

    // TODO: Pull port from supabase TOML file
    final port = '4322';

    final rawConfig = await File(join(Directory.current.path, 'powersync', 'config.yaml')).readAsString();
    final configBytes = utf8.encode(rawConfig);
    final configBase64 = base64.encode(configBytes);

    Docker().run(powersyncImage, args: [
      '-e POWERSYNC_CONFIG_B64=$configBase64',
      '-e PS_PG_URI=postgresql://postgres:postgres@localhost:$port/postgres',
      '-e PS_JWKS_URL=http://host.docker.internal:${env["POSTGRES_PORT"]}/api/auth/keys',
      '-e PS_MONGO_URI=mongodb://localhost:27017',
      '-e PS_PORT=8080',
      '--name powersync',
      '-d',
    ]);
  }
}
