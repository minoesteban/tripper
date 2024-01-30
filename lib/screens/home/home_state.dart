import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _HomeStateInit;

  const factory HomeState.result(String result) = _HomeStateResult;

  const factory HomeState.error(String message) = _HomeStateError;
}
