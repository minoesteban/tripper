import 'package:flutter/material.dart';
import 'package:tripper/l10n/generated/l10n.dart';

export 'package:tripper/l10n/generated/l10n.dart';

const defaultLocale = Locale('en');

extension L10nExtension on BuildContext {
  L10n get l10n => L10n.of(this);
}
