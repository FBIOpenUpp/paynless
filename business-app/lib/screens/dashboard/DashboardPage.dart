import 'package:flutter/material.dart';
import 'package:paynless/res/routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? name;
  String? accountName;
  String? accountNumber;
  String? upiId;
  String? totalAmount;
  String? paymentsCount;

  @override
  void initState() {
    name = "Ram Baba";
    accountName = "SBI";
    accountNumber = "1234567890";
    upiId = "upiId@upi";
    totalAmount = "0";
    paymentsCount = "0";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFA100),
                    Color(0xFFFFBE06),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, MyRoute.welcome, (route) => false);
                    },
                    icon: const Icon(Icons.menu_rounded),
                    color: Colors.black,
                    iconSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            Text(name!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.account_balance,
                  color: Colors.grey,
                  size: 26,
                ),
                Text(
                  " A/C $accountNumber ",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {},
                    child: Text(
                      upiId!,
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ))
              ],
            ),
            const SizedBox(height: 40),
            Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          totalAmount!,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentsCount!,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "View More",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
