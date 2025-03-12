import 'package:emvqrcode/emvqrcode.dart';
import 'package:flutter/material.dart';
import 'package:money_transaction_qr_code/screen/money_transaction_screen.dart';
import 'package:money_transaction_qr_code/screen/string_qr_generator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.greenAccent.shade400),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void moneyTransactionQRGenerate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MoneyTransactionScreen()),
    );
  }

  void stringQRGenerate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const StringQRGenerateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        title: const Text(
          "QR Code Generator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextButtonContainer(
              btnIcon: const Icon(Icons.attach_money_outlined),
              btnText: "Money Transaction",
              onPressed: moneyTransactionQRGenerate,
            ),
            const SizedBox(height: 20),
            TextButtonContainer(
              btnIcon: const Icon(Icons.abc),
              btnText: "Text or QR",
              onPressed: stringQRGenerate,
            ),
          ],
        ),
      ),
    );
  }
}

class TextButtonContainer extends StatelessWidget {
  const TextButtonContainer(
      {required this.btnIcon,
      required this.btnText,
      required this.onPressed,
      super.key});
  final Icon btnIcon;
  final String btnText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(btnIcon.icon, color: Colors.white, size: 30),
          const SizedBox(width: 10),
          Text(
            btnText,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
