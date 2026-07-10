import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {

  final MobileScannerController controller = MobileScannerController(
    cameraResolution: Size(1080,1920),
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 1000,
    formats: [BarcodeFormat.qrCode],
    returnImage: false,
    torchEnabled: true,
    invertImage: false,
    autoZoom: true,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("QR CODE"),
        ),
        body: MobileScanner(
          controller: controller,
          onDetect: (result) {
            debugPrint(result.barcodes.first.rawValue);
          },
        ),
      ),
    );
  }
}