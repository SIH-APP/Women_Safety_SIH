
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  final AuthViewModel viewModel;

  SignUpScreen({required this.viewModel});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WOMEN SAFETY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Sign Up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            SizedBox(height: 32),
            CustomTextField(label: 'Name', controller: nameController),
            CustomTextField(label: 'Email/Phone Number', controller: emailController),
            CustomTextField(label: 'Password', controller: passwordController, isPassword: true),
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text('Terms and conditions'),
              ],
            ),
            CustomButton(
              text: 'SignUp',
              onPressed: () {
                viewModel.signUp(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                );
              },
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
