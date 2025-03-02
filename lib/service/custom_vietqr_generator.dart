import 'package:vietqr_flutter/vietqr_flutter.dart';
import 'package:vietqr_flutter/src/crc16_calculator.dart';

class CustomVietqrGenerator extends VietQRGenerator {
  static String generate({
    required String accountNumber,
    String content = '',
    required String bankCode,
    String guid = '0010A000000727', // Định danh toàn cầu
    String serviceCode =
        '0208QRIBFTTA', // Service code cho NAPAS247 || thẻ thay bằng : QRIBFTTC
    String currencyCode = '5303704', //  VND code
    String countryCode = '5802VN', // 5802VN: VietNam
    bool isDynamicQR = false,
    required String amount,
  }) {
    String formatTLV(String tag, String value) {
      final length = value.length.toString().padLeft(2, '0');
      return '$tag$length$value';
    }

    print('Content: $content');

    // Build TLV formatted data
    String accountNum = formatTLV('01', accountNumber);
    String bankInfo = formatTLV('01', bankCode + accountNum);
    String consumerInfo = formatTLV('38', guid + bankInfo + serviceCode);

    // Generate QR code data
    String qrData =
        '000201${isDynamicQR ? '010212' : '010211'}$consumerInfo${formatTLV('53', currencyCode)}${formatTLV('58', countryCode)}${formatTLV('62', content)}${formatTLV('54', amount)}';

    // Append CRC16 checksum
    qrData += formatTLV('63', CRC16Calculator.calculate('${qrData}6304'));

    return qrData;
  }
}
