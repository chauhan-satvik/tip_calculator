// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  String result = '';

  final amountController = TextEditingController();
  final tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(14),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(96, 125, 139, 1),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //amount text field
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Bill Amount (₹)',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 118, 154, 172),
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
            ),
            //tip textfield
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                controller: tipController,
                decoration: InputDecoration(
                  hintText: 'Enter The Tip (%)',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 118, 154, 172),
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
              child: ElevatedButton(
                onPressed: () {
                  final amountText = amountController.text;
                  final tipText = tipController.text;

                  // Safety check: Are both fields filled?
                  if (amountText.isEmpty || tipText.isEmpty) {
                    setState(() {
                      result = 'Please enter both fields!';
                    });
                    return;
                  }

                  final amount = double.tryParse(amountText);
                  final tipPercent = int.tryParse(tipText);

                  // Check if parsing worked
                  if (amount == null || tipPercent == null) {
                    setState(() {
                      result = 'Invalid input!';
                    });
                    return;
                  }

                  final tipAmount = amount * (tipPercent / 100);
                  final totalAmount = amount + tipAmount;

                  setState(() {
                    result = 'Total: ₹${totalAmount.toStringAsFixed(2)}';
                  });
                  Future.delayed(Duration(seconds: 5), () {
                    amountController.clear();
                    tipController.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 15,
                  textStyle: TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
