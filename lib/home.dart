import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_SG8DKDs1zi5E3l',
                'amount': 100 * 1, //in the smallest currency sub-unit.
                'name': 'Qmp Global',
                // Generate order_id using Orders API
                'timeout': 180, // in seconds
                'prefill': {
                  'contact': '1234567890',
                  'email': 'hi@gmail.com',
                }
              };
              _razorpay.open(options);
            },
            child: const Text(
              'Pay Now',
            ),
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Succes=${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External');
  }
}
