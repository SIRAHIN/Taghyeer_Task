part of 'internet_status_cubit.dart';

@freezed
class InternetStatusState with _$InternetStatusState {
  const factory InternetStatusState.initial() = _Initial;
  const factory InternetStatusState.connected() = _Connected;
  const factory InternetStatusState.disconnected() = _Disconnected;
}
