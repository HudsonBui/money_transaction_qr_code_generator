import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_transaction_qr_code/components/text_box.dart';
import 'package:money_transaction_qr_code/data/bank_data.dart';
import 'package:money_transaction_qr_code/data/model/bank_model.dart';
import 'package:money_transaction_qr_code/service/custom_vietqr_generator.dart';
import 'package:vietqr_flutter/vietqr_flutter.dart';

class MoneyTransactionScreen extends StatefulWidget {
  const MoneyTransactionScreen({super.key});

  @override
  State<MoneyTransactionScreen> createState() => _MoneyTransactionScreenState();
}

class _MoneyTransactionScreenState extends State<MoneyTransactionScreen> {
  final TextEditingController bankInfor = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  // final FocusNode bankAccountFocusNode = FocusNode();
  // final FocusNode amountFocusNode = FocusNode();
  bool isUserShow = false;
  late List<SelectedListItem<BankModel>> listBank;
  String? qrCode;
  late BankModel selectedBank;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    listBank = bankList
        .map((item) => SelectedListItem<BankModel>(data: item))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    bankInfor.dispose();
    accountController.dispose();
    amountController.dispose();
    contentController.dispose();
    // bankAccountFocusNode.dispose();
    // amountFocusNode.dispose();
    super.dispose();
  }

  void onHandleBankInforTextFieldTap() {
    DropDownState<BankModel>(
      dropDown: DropDown<BankModel>(
        isDismissible: true,
        bottomSheetTitle: const Center(
          child: Text(
            "BENEFICIARY BANK",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        data: listBank,
        enableMultipleSelection: false,
        listItemBuilder: (index, itemData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(itemData.data.imageURL),
              ),
              const SizedBox(width: 10),
              Text(itemData.data.name),
            ],
          );
        },
        onSelected: (selectedItem) {
          bankInfor.text = selectedItem.first.data.name;
          selectedBank = selectedItem.first.data;
        },
        searchDelegate: (query, itemData) {
          return itemData
              .where((item) =>
                  item.data.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
      ),
    ).showModal(context);
  }

  //Format Input Amount
  String _formatNumber(String s) =>
      NumberFormat.decimalPatternDigits(locale: 'en_US').format(int.parse(s));
  // Multiple Currency
  // String get _currency => NumberFormat.simpleCurrency(locale: locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            title: const Text(
              "Money Transaction QR Code Generator",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  qrCode = CustomVietqrGenerator.generate(
                    accountNumber: accountController.text.trim(),
                    bankCode: selectedBank.bankCode,
                    amount: amountController.text.replaceAll(',', ''),
                    content: contentController.text,
                  );
                  Widget QR = generatorQR(
                      vietQr: qrCode!,
                      image: AssetImage(selectedBank.imageURL),
                      sizeQr: 250,
                      sizeEmbeddingImage: 50);
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
                              child: Center(child: QR),
                            )
                          ],
                        ),
                      );
                    },
                  );
                  // QrCodeToJsonService.qrCodeToJson(
                  //     '00020101021238540010A00000072701240006970436011010377526270208QRIBFTTA53037045405220005802VN6204080063040D1C');
                }
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.5),
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
          body: Column(
            children: [
              const SizedBox(height: 15),
              CustomedTextBox(
                  labelText: 'Choose Benificiary Bank',
                  controller: bankInfor,
                  readOnly: true,
                  onEditingTap: onHandleBankInforTextFieldTap,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please choose Benificiary Bank!";
                    }
                    return null;
                  }),
              CustomedTextBox(
                labelText: 'Back Account',
                controller: accountController,
                keyboardType: TextInputType.text,
                // focusNode: bankAccountFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the Bank Account Number!";
                  }
                  return null;
                },
              ),
              isUserShow
                  ? const Text(
                      "User's Name",
                    )
                  : const SizedBox(),
              CustomedTextBox(
                labelText: 'Amount',
                hintText: '25,000',
                isAmountInput: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the Amount!";
                  }
                  return null;
                },
                onChanged: (String s) {
                  if (s.isNotEmpty) {
                    s = _formatNumber(s.replaceAll(',', ''));
                    amountController.value = TextEditingValue(
                      text: s,
                      selection: TextSelection.collapsed(offset: s.length),
                    );
                  }
                },
                controller: amountController,
                keyboardType: TextInputType.number,
                // focusNode: amountFocusNode,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
              CustomedTextBox(
                labelText: 'Content',
                controller: contentController,
                isFormatterNeeded: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
