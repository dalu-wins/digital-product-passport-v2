import 'dart:developer';
import 'dart:io';
import 'package:digital_product_passport/src/screens/product/product_screen.dart';
import 'package:digital_product_passport/src/screens/scan/custom_scan_overlay.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {}); // Damit der FutureBuilder neu gebaut wird
            },
            child: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Icon(Icons.flash_on);
                } else {
                  return Icon(Icons.flash_off);
                }
              },
            ),
          ),
        ],
      ),
      body: Stack(alignment: Alignment.center, children: [
        _buildQrView(context),
        // Text pill below the scan box
        Positioned(
          bottom: MediaQuery.of(context).size.height / 2 -
              250, // Adjusts based on cutOut position
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Text(
              'Scan a QR code',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // Prevents frozen image on returning to scanner
    controller?.resumeCamera();
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 600 ||
            MediaQuery.of(context).size.height < 600)
        ? 250.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: CustomQrScannerOverlayShape(
        borderColor: Theme.of(context).colorScheme.primary,
        borderRadius: 20,
        borderLength: 45,
        borderWidth: 12,
        cutOutSize: scanArea,
      ),
      formatsAllowed: [BarcodeFormat.qrcode],
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var url = result?.code;
        if (url != null) {
          // Prevent multiscan, dont forget to start camera again!
          controller.pauseCamera();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(url: url),
            ),
          );
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
