import 'package:emvqrcode/emvqrcode.dart';
import 'package:flutter/material.dart';

class QrCodeToJsonService {
  static void qrCodeToJson(String code) {
    final emvdecode = EMVMPM.decode(code);
    debugPrint(emvdecode.toJson().toString(), wrapWidth: 2024);
  }
}
