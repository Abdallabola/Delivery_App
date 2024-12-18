import 'package:flutter/material.dart';
import 'package:test1/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedGender;
  double age = 18; // Default age
  bool receiveNotifications = false;
  bool agreeToTerms = false;

  void handleSignUp() {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must agree to the terms and conditions')),
      );
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty || selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    // Add user to the user list
    final newUser = User(
      email: email,
      password: password,
      gender: selectedGender!,
      age: age.toInt(),
      receiveNotifications: receiveNotifications,
      notes: notesController.text,
    );

    userList.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign up successful! You can now sign in.')),
    );

    // Navigate back to Sign In screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email and Password Fields
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // Gender Selection
              Text('Gender'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Male'),
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Female'),
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Age Slider
              Text('Age: ${age.toInt()}'),
              Slider(
                value: age,
                min: 10,
                max: 100,
                divisions: 90,
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
              ),
              // Receive Notifications Checkbox
              Row(
                children: [
                  Checkbox(
                    value: receiveNotifications,
                    onChanged: (value) {
                      setState(() {
                        receiveNotifications = value!;
                      });
                    },
                  ),
                  Text('Receive Notifications'),
                ],
              ),
              // Terms and Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  Expanded(child: Text('I agree to the terms and conditions')),
                ],
              ),
              // Notes Field
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Additional information (optional)',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              // Submit Button
              ElevatedButton(
                onPressed: handleSignUp,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
