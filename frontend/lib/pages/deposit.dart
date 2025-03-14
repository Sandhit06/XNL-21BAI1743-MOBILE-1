import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class DepositPage extends StatefulWidget {
  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  String selectedSource = "";
  String selectedAccount = "Savings";
  double depositAmount = 0.0;
  bool scheduleDeposit = false;
  DateTime? selectedDate;
  String frequency = "One-Time";

  final TextEditingController amountController = TextEditingController();
  final List<String> sources = ["Visa **** 1234", "Mastercard **** 5678", "PayPal", "Google Pay"];
  final List<String> accounts = ["Savings", "Checking", "Investment"];
  final List<String> frequencies = ["One-Time", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deposit"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deposit From", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Column(
              children: sources.map((source) {
                return ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: Icon(Icons.account_balance_wallet, color: Color.fromARGB(255, 16, 80, 98)),
                  title: Text(source),
                  trailing: Radio(
                    value: source,
                    groupValue: selectedSource,
                    onChanged: (value) {
                      setState(() {
                        selectedSource = value.toString();
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text("Deposit To", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            DropdownButtonFormField(
              value: selectedAccount,
              items: accounts.map((account) {
                return DropdownMenuItem(
                  value: account,
                  child: Text(account),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAccount = value.toString();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Text("Enter Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CustomTextField(
              controller: amountController,
              obscureText: false,
              hintText: "Enter Amount",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Schedule Deposit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Switch(
                  value: scheduleDeposit,
                  onChanged: (value) {
                    setState(() {
                      scheduleDeposit = value;
                    });
                  },
                ),
              ],
            ),
            if (scheduleDeposit) ...[
              SizedBox(height: 8),
              DropdownButtonFormField(
                value: frequency,
                items: frequencies.map((freq) {
                  return DropdownMenuItem(
                    value: freq,
                    child: Text(freq),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    frequency = value.toString();
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(selectedDate == null
                    ? "Pick Date"
                    : "Scheduled: ${DateFormat.yMMMd().format(selectedDate!)}"),
              ),
            ],
            SizedBox(height: 24),
            CustomButton(
              text: "Confirm Deposit",
              onPressed: () {
                if (selectedSource.isEmpty || depositAmount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a source and enter a valid amount")),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deposit Successful")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
