import 'package:digital_product_passport/src/product/presentation/product_screen.dart';
import 'package:flutter/material.dart';

class EnterUrlDialog extends StatefulWidget {
  const EnterUrlDialog({super.key});

  @override
  State<EnterUrlDialog> createState() => _EnterUrlDialogState();
}

class _EnterUrlDialogState extends State<EnterUrlDialog> {
  final TextEditingController _urlController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Schedule focus request after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) Navigator.pop(context);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(url: url),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter URL"),
      content: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: "https://example.com",
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 12),
          RawMaterialButton(
            onPressed: _handleSubmit,
            elevation: 2.0,
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            shape: const CircleBorder(),
            constraints: BoxConstraints.tight(Size(42, 42)),
            child: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
