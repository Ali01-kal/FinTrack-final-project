// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: MediaQuery.of(context).size.height * 0.35,
//             child: Container(
//               color: Colors.amber,
//               child: const Padding(
//                 padding: EdgeInsets.only(top: 80),
//                 child:  Text(
//                   'Welcome',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 42,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             )),

//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.25,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(50),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsetsGeometry.symmetric(horizontal: 40,vertical: 50),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Username Or Email',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),

//                         const SizedBox(height: 10,),

//                         TextFormField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             hintText: 'example@example.com',
//                             hintStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             fillColor: Colors.black,
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                           ),
//                         ),

//                         const SizedBox(height: 20,),

//                         const Text(
//                           'Password',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),

//                         const SizedBox(height: 10,),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: _isPasswordVisible,
//                           decoration: InputDecoration(
//                             hintText: '**********',
//                             hintStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             fillColor: Colors.black,
//                             filled: true,
//                             suffixIcon: IconButton(
//                               onPressed: (){
//                                 setState(() {
//                                   _isPasswordVisible =! _isPasswordVisible;
//                                 });
//                               }, 
//                               icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                           ),
//                         ),

//                         const SizedBox(height: 40,),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: (){
//                               context.go('/home');
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               elevation: 0,
//                             ), 
//                             child: const Text(
//                               'Log In',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             )),
//                         ),

//                         const SizedBox(height: 10,),

//                         Center(
//                           child: TextButton(
//                             onPressed: (){}, child: const Text(
//                               'Forgot Password ?',
//                               style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                             )),
//                         ),

//                         const SizedBox(height: 10,),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               context.go('/register');
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey[300],
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ), 
//                             child: const Text(
//                               'Sign Up',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             )),
//                         ),

//                         const SizedBox(height: 30,),

//                         const Center(
//                           child: Text(
//                             'or sign up with',style: TextStyle(color: Colors.white),
//                           ),
//                         ),

//                         const SizedBox(height: 20,),

//                         Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.facebook, size: 35),
//                             color: Colors.white,
//                             onPressed: () {},
//                           ),
//                           const SizedBox(width: 20),
//                           IconButton(
//                             icon: const Icon(Icons.chrome_reader_mode, size: 35),
//                             color: Colors.white,
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ),
//         ],
//       ),
//     );
//   }
// }




import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_event.dart';
import 'package:fintrack/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Блок файлдарын импорттауды ұмытпа:
// import 'package:your_project/presentation/blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // BlocListener - тек бір реттік әрекеттер үшін (навигация, SnackBar)
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/home'); // Жүйеге сәтті кірсе, басты бетке өту
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Жоғарғы сары дизайн бөлігі
            _buildHeader(),

            // Форма бөлігі
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Email"),
                          const SizedBox(height: 10),
                          _buildEmailField(),
                          const SizedBox(height: 20),
                          _buildLabel("Password"),
                          const SizedBox(height: 10),
                          _buildPasswordField(),
                          const SizedBox(height: 40),

                          // BlocBuilder - күйге байланысты UI-ды өзгерту (Loading indicator)
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Colors.amber),
                                );
                              }
                              return _buildLoginButton(context);
                            },
                          ),

                          const SizedBox(height: 10),
                          _buildForgotPassword(),
                          const SizedBox(height: 10),
                          _buildSignUpButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        color: Colors.amber,
        child: const Padding(
          padding: EdgeInsets.only(top: 80),
          child: Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      validator: (value) => (value == null || !value.contains('@')) ? 'Дұрыс email енгізіңіз' : null,
      decoration: _inputDecoration('example@example.com'),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      validator: (value) => (value == null || value.length < 6) ? 'Пароль кемі 6 таңба болуы керек' : null,
      decoration: _inputDecoration('**********').copyWith(
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // МІНЕ, ОСЫ ЖЕРДЕ СЕНІҢ EVENT-ІҢ ШАҚЫРЫЛАДЫ
            context.read<AuthBloc>().add(
                  AuthSignInRequested(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[500]),
      fillColor: const Color(0xFF1A1A1A),
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white));
  Widget _buildForgotPassword() => Center(child: TextButton(onPressed: () {}, child: const Text('Forgot Password ?', style: TextStyle(color: Colors.white70))));
  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () => context.go('/register'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
