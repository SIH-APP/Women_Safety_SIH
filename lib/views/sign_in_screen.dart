import 'package:flutter/material.dart';
import 'package:saahasini/views/home_screen.dart';
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'WOMEN SAFETY',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'It was popularised in the 1960s with the release of\nLetraset sheets containing Lorem Ipsum.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Handle Facebook sign-up
                      },
                      icon: Icon(Icons.facebook, color: Colors.blue),
                      label: Text('Facebook'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Handle Google sign-up
                      },
                      icon: Icon(Icons.g_translate, color: Colors.red),
                      label: Text('Google'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Or',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: 'Name',
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                CustomTextField(
                  label: 'Email/Phone Number',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  suffixIcon: Icon(Icons.visibility_off, color: Colors.white54),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Colors.deepOrange,
                    ),
                    Text('Terms and conditions', style: TextStyle(color: Colors.white54)),
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'SignUp',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    // Handle sign-up logic
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'I already have an account',
                      style: TextStyle(color: Colors.white54),
                    ),
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
