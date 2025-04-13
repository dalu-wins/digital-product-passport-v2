import 'package:digital_product_passport/src/product/presentation/invalid_url_exception.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final String url;

  const ProductScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<String?> _dataFuture;
  bool _hasShownError = false;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData(widget.url);
  }

  Future<String?> _loadData(String url) async {
    if (!isValidUrl(url)) return Future.error(InvalidUrlException(url));

    // Lade Daten von Webseite hier
    await Future.delayed(Duration(seconds: 2)); // Simuliere Ladedauer

    return "server response"; // Simulierte Antwort
  }

  bool isValidUrl(String url) {
    final urlPattern = r'^(https?:\/\/)?' // http:// oder https:// (optional)
        r'((([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})|' // Domain (z.B. example.com)
        r'((\d{1,3}\.){3}\d{1,3}))' // oder IP-Adresse (z.B. 192.168.1.1)
        r'(:\d{1,5})?' // optionaler Port (z.B. :8080)
        r'(\/[^\s]*)?$'; // optionaler Pfad (z.B. /products/12)

    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: FutureBuilder<String?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            Navigator.pop(context);
            if (!_hasShownError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final messenger = ScaffoldMessenger.of(context);

                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      snapshot.error is InvalidUrlException
                          ? (snapshot.error as InvalidUrlException).toString()
                          : 'Ein unbekannter Fehler ist aufgetreten',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                  ),
                );
              });

              _hasShownError = true;
            }

            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(
              child: Text(
                'Geladene URL: ${snapshot.data}',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
