import 'package:money_transaction_qr_code/data/image_url.dart';
import 'package:money_transaction_qr_code/data/model/bank_model.dart';

List<BankModel> bankList = [
  BankModel(
    name: 'Vietcombank',
    imageURL: ImageUrl.vietcombank,
    bankCode: '0006970436',
  ),
  BankModel(name: 'MbBank', imageURL: ImageUrl.mbbank, bankCode: '0006970422'),
  BankModel(
    name: 'Techcombank',
    imageURL: ImageUrl.techcombank,
    bankCode: '0006970407',
  ),
  BankModel(name: 'VIB', imageURL: ImageUrl.vib, bankCode: '0006970441'),
];
