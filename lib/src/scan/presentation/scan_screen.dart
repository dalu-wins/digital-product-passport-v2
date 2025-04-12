import 'dart:developer';
import 'dart:io';
import 'package:digital_product_passport/src/product/presentation/product_screen.dart';
import 'package:digital_product_passport/src/scan/presentation/custom_scan_overlay.dart';
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

  bool _hasScanned = false;

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
  void dispose() {
    controller?.dispose();
    super.dispose();
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
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
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
          FloatingActionButton.extended(
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
                  return SafeArea(
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // 💡 Damit die Höhe sich anpasst
                      children: [
                        ListTile(
                          leading: Icon(Icons.public),
                          title: Text('Import from URL'),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: Icon(Icons.photo),
                          title: Text('Import from Gallery'),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: Icon(Icons.file_upload),
                          title: Text('Upload File'),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(alignment: Alignment.center, children: [
        _buildQrView(context),
        // Text pill below the scan box
        Positioned(
          bottom: MediaQuery.of(context).size.height / 2 -
              250 -
              16, // Adjusts based on cutOut position
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(50),
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
    controller.scannedDataStream.listen((scanData) {
      if (_hasScanned) return;
      _hasScanned = true;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductScreen(url: scanData.code!),
        ),
      ).then((_) {
        _hasScanned = false;
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
