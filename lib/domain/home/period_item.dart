import 'package:tripper/domain/home/period_type.dart';

class PeriodItem {
  const PeriodItem({
    required this.value,
    required this.type,
  });

  final int value;
  final PeriodType type;

  @override
  bool operator ==(covariant PeriodItem other) {
    if (identical(this, other)) return true;

    return other.value == value && other.type == type;
  }

  @override
  int get hashCode => value.hashCode ^ type.hashCode;
}
