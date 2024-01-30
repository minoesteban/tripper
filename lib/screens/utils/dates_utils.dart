import 'package:intl/intl.dart';

extension Formatters on DateTime {
  String get asDate => DateFormat.yMd().format(this);
  String get asDateLong => DateFormat.yMMMd().format(this);
}
