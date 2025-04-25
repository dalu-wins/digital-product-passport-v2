import 'dart:developer';
import 'dart:io';
import 'package:digital_product_passport/src/product/presentation/product_screen.dart';
import 'package:digital_product_passport/src/scan/presentation/overlay/custom_scan_overlay.dart';
import 'package:digital_product_passport/src/scan/presentation/widgets/import_options.dart';
// import 'package:digital_product_passport/src/scan/presentation/widgets/scan_label.dart';
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
    if (controller != null) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'flash_button',
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {}); // Damit der FutureBuilder neu gebaut wird
            },
            child: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.hasData && snapshot.data == false) {
                  return Icon(Icons.flash_on);
                } else {
                  return Icon(Icons.flash_off);
                }
              },
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 'import_button',
            label: Text("Import"),
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (BuildContext context) {
                  return ImportOptions();
                },
              );
            },
          ),
        ],
      ),
      body: Stack(alignment: Alignment.center, children: [
        _buildQrView(context),
        //ScanLabel(),
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
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
        borderColor: Theme.of(context).colorScheme.tertiary,
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
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Kamera pausieren, damit nicht doppelt gescannt wird
      await controller.pauseCamera();

      // Weiter zur Produktansicht
      await openProduct(scanData.code!);

      // Nach dem Zurückkehren Kamera wieder aktivieren
      await controller.resumeCamera();
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

  Future<void> openProduct(String prouctUrl) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(url: prouctUrl),
      ),
    );
  }
}
