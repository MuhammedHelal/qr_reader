part of 'read_qr_cubit.dart';

sealed class ReadQrState {}

final class ReadQrInitial extends ReadQrState {}

final class ReadQrSuccess extends ReadQrState {
  final String? data;

  ReadQrSuccess({required this.data});
}

final class ReadQrFail extends ReadQrState {
  final String message;

  ReadQrFail({required this.message});
}
