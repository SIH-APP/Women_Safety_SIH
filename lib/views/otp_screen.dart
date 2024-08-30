
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  final AuthViewModel viewModel;

  OtpScreen({required this.viewModel});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the OTP code we just sent to your registered Email/Phone number', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            CustomTextField(label: 'OTP', controller: otpController),
            SizedBox(height: 32),
            CustomButton(
              text: 'Reset Password',
              onPressed: () {
                viewModel.verifyOtp(otpController.text);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ResetPasswordScreen(viewModel: viewModel)),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
