// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _nameControl = TextEditingController();
//   final _emailControl = TextEditingController();
//   final _phoneControl = TextEditingController();
//   final _passwordControl = TextEditingController();
//   final _confirmPasswordControl = TextEditingController();

//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _nameControl.dispose();
//     _emailControl.dispose();
//     _phoneControl.dispose();
//     _passwordControl.dispose();
//     _confirmPasswordControl.dispose();
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
//             height: MediaQuery.of(context).size.height * 0.3,
//             child: Container(
//               color: Colors.amber,
//               child: SafeArea(
//                 child: Center(
//                   child: Text(
//                     'Create Acount',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )),
//             )),

//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.22,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      _buildInputField('Full Name', 'example@example.com', _nameControl),
//                      _buildInputField('Email', 'example@example.com', _emailControl),
//                      _buildInputField('Mobile Number', '+ 123 456 789', _phoneControl),

//                      const Text('Password',style: TextStyle(fontWeight: FontWeight.bold),),
//                      const SizedBox(height: 8,),
//                      _buildPasswordField(_passwordControl),

//                      const SizedBox(height: 15,),

//                      const Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold),),
//                      const SizedBox(height: 8,),
//                      _buildPasswordField(_confirmPasswordControl),

//                      const SizedBox(height: 25,),

//                      SizedBox(
//                       width: double.infinity,
//                       height: 55,
//                       child: ElevatedButton(
//                         onPressed: (){
//                           context.go('/home');
//                         }, 
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.amber,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           )
//                         ),
//                         child: Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )),
//                      ),

//                      Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Already have an account ?',style: TextStyle(color: Colors.white),),
//                         TextButton(onPressed: () => context.pop(), 
//                         child: Text(
//                           'Log In',
//                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                         ))
//                       ],
//                      )
//                     ],
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
//   Widget _buildInputField(String label, String hint, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             fillColor: const Color(0xFFE0F5EB),
//             filled: true,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//           ),
//         ),
//         const SizedBox(height: 15),
//       ],
//     );
//   }

//   Widget _buildPasswordField(TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       obscureText: !_isPasswordVisible,
//       decoration: InputDecoration(
//         hintText: '••••••••',
//         fillColor: const Color(0xFFE0F5EB),
//         filled: true,
//         suffixIcon: IconButton(
//           icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined, color: Colors.black45),
//           onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
//         ),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
// Өз жолыңмен Bloc-ты импортта:
// import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Валидация үшін
  final _nameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _phoneControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameControl.dispose();
    _emailControl.dispose();
    _phoneControl.dispose();
    _passwordControl.dispose();
    _confirmPasswordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
            );
          }
        },
        child: Stack(
          children: [
            // Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                color: Colors.amber,
                child: const SafeArea(
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

            // Form
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
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField('Full Name', 'John Doe', _nameControl),
                        _buildInputField('Email', 'example@example.com', _emailControl, isEmail: true),
                        _buildInputField('Mobile Number', '+ 123 456 789', _phoneControl),

                        const Text('Password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        _buildPasswordField(_passwordControl),

                        const SizedBox(height: 15),

                        const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        _buildPasswordField(_confirmPasswordControl, isConfirm: true),

                        const SizedBox(height: 25),

                        // LOADING немесе BUTTON
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(child: CircularProgressIndicator(color: Colors.amber));
                            }
                            return _buildSignUpButton();
                          },
                        ),

                        _buildLoginRedirect(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Тіркелу Event-ін жібереміз
            context.read<AuthBloc>().add(
                  AuthSignUpRequested(
                    _emailControl.text.trim(),
                    _passwordControl.text.trim(),
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, {bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Бұл жерді толтыру міндетті';
            if (isEmail && !value.contains('@')) return 'Дұрыс email жазыңыз';
            return null;
          },
          decoration: _inputDecoration(hint),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPasswordField(TextEditingController controller, {bool isConfirm = false}) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.length < 6) return 'Кемі 6 таңба қажет';
        if (isConfirm && value != _passwordControl.text) return 'Парольдер сәйкес келмейді';
        return null;
      },
      decoration: _inputDecoration('••••••••').copyWith(
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined, color: Colors.black45),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      fillColor: const Color(0xFFE0F5EB),
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account ?', style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Log In', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
