import 'package:flutter/material.dart';



class TopUpBottomSheet extends StatefulWidget {
  final String selectedProvider;
  final String account;
  final String image;

  const TopUpBottomSheet({
    super.key,
    required this.selectedProvider,
    required this.account,
    required this.image,
  });

  @override
  State<TopUpBottomSheet> createState() => _TopUpBottomSheetState();
}

class _TopUpBottomSheetState extends State<TopUpBottomSheet> {
  double amount = 100.0;
  bool showTextField = false; // Flag to toggle input mode

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.7), // Prevents overflow
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.03,
      ),
      child: SingleChildScrollView( // Ensures no overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Provider Info Section (Icon + Provider Name)
            ListTile(
              leading: CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundImage: AssetImage(widget.image),
                backgroundColor: Colors.white,
              ),
              title: Text(
                widget.selectedProvider,
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              subtitle: Text(
                widget.account,
                style: TextStyle(fontSize: screenWidth * 0.035),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: screenWidth * 0.06,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.all(screenWidth * 0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                side: const BorderSide(color: Colors.black12),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ✅ Amount Label
            Text(
              "Amount",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            // ✅ Toggle between Slider & TextField
            showTextField
                ? TextField(
              decoration: InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double? enteredValue = double.tryParse(value);
                if (enteredValue != null) {
                  setState(() {
                    amount = enteredValue;
                  });
                }
              },
            )
                : Column(
              children: [
                // ✅ Amount Increment & Decrement Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (amount > 5) amount -= 5;
                        });
                      },
                      icon: const Icon(Icons.remove),
                      iconSize: screenWidth * 0.07,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                      ),
                    ),
                    Text(
                      "\$ ${amount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (amount + 5 > 500) {
                            showTextField = true; // Switch to input box if > 500
                          } else {
                            amount += 5;
                          }
                        });
                      },
                      icon: const Icon(Icons.add),
                      iconSize: screenWidth * 0.07,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),

                // ✅ Amount Slider (Only if amount ≤ 500)
                Slider(
                  value: amount.clamp(5, 500), // Ensures valid range
                  min: 5,
                  max: 500,
                  activeColor: const Color.fromARGB(255, 16, 80, 98),
                  onChanged: (value) {
                    setState(() {
                      amount = value;
                      if (amount > 500) {
                        showTextField = true; // Switch to manual input mode
                      }
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // ✅ Predefined Amount Buttons
            Center(
              child: Wrap(
                spacing: screenWidth * 0.04,
                runSpacing: screenHeight * 0.02,
                children: [5, 10, 15, 20, 50, 100, 200, 500].map((value) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (value > 500) {
                          showTextField = true; // Show input box
                        } else {
                          amount = value.toDouble();
                          showTextField = false; // Use slider for valid range
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    child: Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: amount == value
                            ? const Color.fromARGB(255, 16, 80, 98)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Text(
                        '\$$value',
                        style: TextStyle(
                          color: amount == value ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: screenHeight * 0.06),

            // ✅ Top Up Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
              ),
              child: Text(
                "Top Up",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
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

