import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/features/read_qr/manager/read_qr_cubit/read_qr_cubit.dart';

class FlashButton extends StatefulWidget {
  const FlashButton({super.key});

  @override
  State<FlashButton> createState() => _FlashButtonState();
}

class _FlashButtonState extends State<FlashButton> {
  late final ReadQrCubit cubit;

  bool isFlashOn = false;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ReadQrCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await cubit.controller?.toggleFlash();
        isFlashOn = !isFlashOn;
        setState(() {});
      },
      icon: Icon(
        isFlashOn ? Icons.flash_on_outlined : Icons.flash_off_outlined,
      ),
    );
  }
}
