import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Electricity Bill Calculator',
    home: BillCalculatorScreen(),
  ));
}

class Customer {
  String name;
  double unitsConsumed;

  Customer({required this.name, required this.unitsConsumed});
}

class BillCalculator {
  static const double basicUnitCost = 7.5; // Example tariff rate in ₹ per unit
  static const double fixedCharge = 30.0; // Example fixed charge in ₹

  static double calculateBill(double unitsConsumed) {
    double totalBill = 0.0;

    // Apply slab rates based on TN norms (hypothetical example)
    if (unitsConsumed <= 100) {
      totalBill = unitsConsumed * basicUnitCost;
    } else if (unitsConsumed <= 200) {
      totalBill = 100 * basicUnitCost + (unitsConsumed - 100) * (basicUnitCost * 1.5);
    } else {
      totalBill = 100 * basicUnitCost + 100 * (basicUnitCost * 1.5) + (unitsConsumed - 200) * (basicUnitCost * 2);
    }

    // Add fixed charges
    totalBill += fixedCharge;

    return totalBill;
  }
}

class BillCalculatorScreen extends StatefulWidget {
  const BillCalculatorScreen({Key? key}) : super(key: key);

  @override
  _BillCalculatorScreenState createState() => _BillCalculatorScreenState();
}

class _BillCalculatorScreenState extends State<BillCalculatorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();
  double _totalBill = 0.0;

  void _calculateBill() {
    double unitsConsumed = double.tryParse(_unitsController.text) ?? 0.0;
    setState(() {
      _totalBill = BillCalculator.calculateBill(unitsConsumed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity Bill Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Customer Name',
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Units Consumed',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter units consumed';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _calculateBill,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Total Bill Amount: ₹ $_totalBill',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitsController.dispose();
    super.dispose();
  }
}
