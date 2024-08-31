
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final AuthViewModel viewModel;

  ForgetPasswordScreen({required this.viewModel});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forget Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            SizedBox(height: 16),
            CustomTextField(label: 'Email ID/Mobile Number', controller: emailController, validator: (value) {  },),
            SizedBox(height: 32),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                viewModel.resetPassword(emailController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtpScreen(viewModel: viewModel)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
