import 'package:flutter/material.dart';
import 'package:money_transaction_qr_code/components/text_box.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StringQRGenerateScreen extends StatefulWidget {
  const StringQRGenerateScreen({super.key});

  @override
  State<StringQRGenerateScreen> createState() => _StringQRGenerateScreenState();
}

class _StringQRGenerateScreenState extends State<StringQRGenerateScreen> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          title: const Text(
            "Text QR Code Generator",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            widthFactor: double.infinity,
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.close, size: 25),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Center(
                              child: QrImageView(
                                data: controller.text,
                                version: QrVersions.auto,
                                size: 250,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Create QR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: CustomedTextBox(
          labelText: "Enter Text",
          controller: controller,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter text";
            }
            return null;
          },
          isFormatterNeeded: false,
        ),
      ),
    );
  }
}
