import 'package:digital_product_passport/src/product/presentation/product_screen.dart';
import 'package:digital_product_passport/src/scan/presentation/widgets/enter_url_dialog.dart';
import 'package:flutter/material.dart';

class ImportOptions extends StatelessWidget {
  const ImportOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min, // 💡 Damit die Höhe sich anpasst
        children: [
          ListTile(
            leading: Icon(Icons.public),
            title: Text('Enter URL'),
            onTap: () => {
              Navigator.pop(context),
              showDialog(
                context: context,
                builder: (context) => EnterUrlDialog(),
              ),
            },
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
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Debugging"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    url: "https://192.168.0.67:444/api/v3.0/shells/",
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
