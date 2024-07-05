import 'package:embed_annotation/embed_annotation.dart';

part 'templates.g.dart';

@EmbedBinary("../../templates/powersync_config.yaml")
const templateConfig = _$templateConfig;

@EmbedBinary("../../templates/powersync_compose.yaml")
const templateCompose = _$templateCompose;

@EmbedBinary("../../templates/sync_rules.yaml")
const templateSyncRules = _$templateSyncRules;

@EmbedBinary("../../templates/template.env")
const templateEnv = _$templateEnv;
