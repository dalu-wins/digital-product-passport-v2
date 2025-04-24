import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDialog extends StatelessWidget {
  final String url;
  const QrDialog({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    Color qrColor = Colors.black;
    Color qrBgColor = Colors.white;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      title: Text('QR Code'),
      content: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: qrBgColor, // Background color
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                child: QrImageView(
                  eyeStyle: QrEyeStyle(
                    color: qrColor,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    color: qrColor,
                  ),
                  data: url,
                  version: QrVersions.auto,
                  size: 150.0,
                ),
              ),
            ),
          ),
          Text(Uri.parse(url).authority),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
