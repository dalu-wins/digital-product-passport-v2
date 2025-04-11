import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final String url;

  const ProductScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // You can use widget.url here if you need to load something
    print("URL passed: ${widget.url}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: Center(
        child: Text(
          'URL: ${widget.url}',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
