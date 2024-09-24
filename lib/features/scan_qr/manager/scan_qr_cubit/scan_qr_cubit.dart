import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:qr_reader/core/functions/make_feedback.dart';
part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  ScanQrCubit() : super(ReadQrInitial());
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  void scanBycamera() async {
    if (state is ReadQrSuccess || state is ReadQrFail) {
      emit(ReadQrInitial());

      await controller?.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code == null) return;
      emit(ReadQrSuccess(data: scanData.code!));
      await makeFeedback();
      await controller.pauseCamera();
    });
  }

  Future<void> scanImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      try {
        final qrResult = await QrCodeToolsPlugin.decodeFrom(pickedFile.path);
        emit(ReadQrSuccess(data: qrResult));

        if (qrResult == null) {
          emit(ReadQrFail(message: 'No QR code found'));
          return;
        }
      } on PlatformException catch (e) {
        emit(ReadQrFail(message: e.code));
      } catch (e) {
        emit(ReadQrFail(message: e.toString()));
      }
    } else {
      emit(ReadQrFail(message: 'No image selected'));
    }
  }
}
