import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/local_storage/app_storage.dart';
import '../providers/main_providers.dart';

class MainView extends HookConsumerWidget {
  /// TODO add your comment here
  const MainView({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStorage = ref.read(appStorageProvider);
    final payeeVpaController = useTextEditingController(text: appStorage.getUpiId());
    final payeeNameController = useTextEditingController(text: appStorage.getName());
    final amountController = useTextEditingController(text: appStorage.getAmount());
    final descriptionController = useTextEditingController(text: appStorage.getDescription());

    final formKeyRef = useRef(GlobalKey<FormState>());

    ref.listen<MainState>(
      mainStateProvider,
      (previous, next) {
        switch (next) {
          case MainState.initial:
          case MainState.loading:
            break;
          case MainState.success:
            final model = ref.read(mainStateProvider.notifier).transactionDetailModel;
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 54,
                ),
                content: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Txn Id:'),
                        ),
                        Text('  ${model?.transactionId}  '),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Response Code:'),
                        ),
                        Text('  ${model?.responseCode}  '),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Ref No:'),
                        ),
                        Text('  ${model?.approvalRefNo}  '),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Txn Ref Id:'),
                        ),
                        Text('  ${model?.transactionRefId}  '),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Amount :'),
                        ),
                        Text('  ${model?.amount}  '),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Okay'),
                  ),
                ],
              ),
            );
            break;
          case MainState.error:
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 54,
                ),
                content: const Text(
                  'Transaction Failed :(',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Okay'),
                  ),
                ],
              ),
            );
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Upi Payment'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(mainStateProvider);
          return AbsorbPointer(
            absorbing: state == MainState.loading,
            child: child,
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: formKeyRef.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 36),
                TextFormField(
                  controller: payeeNameController,
                  decoration: const InputDecoration(
                    labelText: 'Payee Name',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: payeeVpaController,
                  decoration: const InputDecoration(
                    labelText: 'Payee Vpa Id',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter valid Vpa Id';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final doubleValue = double.tryParse(value ?? '');
                    if (value == null || value.isEmpty || doubleValue == null) {
                      return 'Please enter valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.name,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 36),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(mainStateProvider);
                    switch (state) {
                      case MainState.initial:
                      case MainState.success:
                      case MainState.error:
                        return child!;
                      case MainState.loading:
                        return const Center(child: CircularProgressIndicator());
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKeyRef.value.currentState!.validate()) {
                        ref.read(mainStateProvider.notifier).startPayment(
                              EasyUpiPaymentModel(
                                payeeVpa: payeeVpaController.text,
                                payeeName: payeeNameController.text,
                                amount: double.parse(amountController.text),
                                description: descriptionController.text,
                              ),
                            );
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size.fromHeight(42)),
                    ),
                    child: const Text('Pay Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
