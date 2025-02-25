import 'package:flutter/widgets.dart';
import 'package:zombie_conga_flame/l10n/app_localizations.dart';
export 'package:zombie_conga_flame/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
