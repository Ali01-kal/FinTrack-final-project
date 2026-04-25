import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              color: Colors.amber,
              child: const Padding(
                padding: EdgeInsets.only(top: 80),
                child:  Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 40,vertical: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username Or Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10,),

                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'example@example.com',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: Colors.black,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: '**********',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: Colors.black,
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _isPasswordVisible =! _isPasswordVisible;
                                });
                              }, 
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),

                        const SizedBox(height: 40,),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: (){
                              context.go('/home');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ), 
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                        ),

                        const SizedBox(height: 10,),

                        Center(
                          child: TextButton(
                            onPressed: (){}, child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            )),
                        ),

                        const SizedBox(height: 10,),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ), 
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                        ),

                        const SizedBox(height: 30,),

                        const Center(
                          child: Text(
                            'or sign up with',style: TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 35),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.chrome_reader_mode, size: 35),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      ],
                    ),
                  ),
                ),
              )
            ),
        ],
      ),
    );
  }
}