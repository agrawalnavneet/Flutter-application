import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:findoc_assignment/blocs/auth/auth_bloc.dart';
import 'package:findoc_assignment/blocs/auth/auth_event.dart';
import 'package:findoc_assignment/blocs/auth/auth_state.dart';
import 'package:findoc_assignment/utils/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    context.read<AuthBloc>().stream.listen((state) {
      if (state is AuthSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0), // Reduced from 24 to 16
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360), // Reduced from 420 to 360
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Reduced from 20,28 to 16,20
                      decoration: BoxDecoration(
                        color: const Color(0xE6FFFFFF),
                        borderRadius: BorderRadius.circular(12), // Reduced from 16 to 12
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8, // Reduced from 12 to 8
                            spreadRadius: 0.5, // Reduced from 1 to 0.5
                            offset: const Offset(0, 2), // Reduced from 4 to 2
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // App Title
                            Text(
                              'Welcome Back',
                              style: GoogleFonts.montserrat(
                                fontSize: 24, // Reduced from 32 to 24
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8), // Reduced from 12 to 8
                            Text(
                              'Sign in to continue',
                              style: GoogleFonts.montserrat(
                                fontSize: 14, // Reduced from 16 to 14
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24), // Reduced from 32 to 24

                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon: const Icon(Icons.email_outlined, size: 20), // Reduced icon size
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: const BorderSide(color: Colors.blue, width: 1.5), // Reduced from 2 to 1.5
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Reduced padding
                              ),
                              validator: (value) {
                                return ValidationUtils.getEmailError(value ?? '');
                              },
                            ),
                            const SizedBox(height: 16), // Reduced from 20 to 16

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: const Icon(Icons.lock_outlined, size: 20), // Reduced icon size
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20, // Reduced icon size
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: const BorderSide(color: Colors.blue, width: 1.5), // Reduced from 2 to 1.5
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Reduced padding
                              ),
                              validator: (value) {
                                return ValidationUtils.getPasswordError(value ?? '');
                              },
                            ),
                            const SizedBox(height: 20), // Reduced from 24 to 20

                            // Submit Button
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state is AuthLoading ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12), // Reduced from 16 to 12
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                    ),
                                    elevation: 1, // Reduced from 2 to 1
                                  ),
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          height: 16, // Reduced from 20 to 16
                                          width: 16, // Reduced from 20 to 16
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5, // Reduced from 2 to 1.5
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Sign In',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14, // Reduced from 16 to 14
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                );
                              },
                            ),
                            const SizedBox(height: 12), // Reduced from 16 to 12

                            Container(
                              padding: const EdgeInsets.all(12), // Reduced from 16 to 12
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password Requirements:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12, // Reduced from 14 to 12
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6), // Reduced from 8 to 6
                                  _buildRequirement('Minimum 8 characters'),
                                  _buildRequirement('At least one uppercase letter'),
                                  _buildRequirement('At least one lowercase letter'),
                                  _buildRequirement('At least one numeric digit'),
                                  _buildRequirement('At least one symbol'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1), // Reduced from 2 to 1
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 14, // Reduced from 16 to 14
            color: Colors.grey[600],
          ),
          const SizedBox(width: 6), // Reduced from 8 to 6
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 11, // Reduced from 12 to 11
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
} 