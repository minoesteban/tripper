import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/chat/trip.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _HomeStateInit;

  const factory HomeState.result(Trip trip) = _HomeStateResult;

  const factory HomeState.error(String message) = _HomeStateError;
}
