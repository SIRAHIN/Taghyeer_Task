import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/internet_service/internet_service.dart';

part 'internet_status_state.dart';
part 'internet_status_cubit.freezed.dart';

@injectable
class InternetStatusCubit extends Cubit<InternetStatusState> {
  final InternetService _internetService;
  StreamSubscription? _subscription;

  InternetStatusCubit(this._internetService)
      : super(const InternetStatusState.initial()) {
    _checkInitialConnection();
    _subscription = _internetService.isConnectedStream.listen((isConnected) {
      if (isConnected) {
        emit(const InternetStatusState.connected());
      } else {
        emit(const InternetStatusState.disconnected());
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    final isConnected = await _internetService.checkConnection();
    if (isConnected) {
      emit(const InternetStatusState.connected());
    } else {
      emit(const InternetStatusState.disconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
