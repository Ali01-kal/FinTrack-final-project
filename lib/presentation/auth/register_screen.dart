import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _phoneControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameControl.dispose();
    _emailControl.dispose();
    _phoneControl.dispose();
    _passwordControl.dispose();
    _confirmPasswordControl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              color: Colors.amber,
              child: SafeArea(
                child: Center(
                  child: Text(
                    'Create Acount',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )),
            )),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     _buildInputField('Full Name', 'example@example.com', _nameControl),
                     _buildInputField('Email', 'example@example.com', _emailControl),
                     _buildInputField('Mobile Number', '+ 123 456 789', _phoneControl),

                     const Text('Password',style: TextStyle(fontWeight: FontWeight.bold),),
                     const SizedBox(height: 8,),
                     _buildPasswordField(_passwordControl),

                     const SizedBox(height: 15,),

                     const Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold),),
                     const SizedBox(height: 8,),
                     _buildPasswordField(_confirmPasswordControl),

                     const SizedBox(height: 25,),

                     SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                     ),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?',style: TextStyle(color: Colors.white),),
                        TextButton(onPressed: () => context.pop(), 
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ))
                      ],
                     )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
  Widget _buildInputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: const Color(0xFFE0F5EB),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: '••••••••',
        fillColor: const Color(0xFFE0F5EB),
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined, color: Colors.black45),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}