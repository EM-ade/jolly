import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/common_widgets/loading_indicator.dart';
import '../../../core/animations/animation_widgets.dart';
import 'providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _fullPhoneNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_fullPhoneNumber.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter phone number and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ref
        .read(authProvider.notifier)
        .login(_fullPhoneNumber, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          context.go('/home');
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Logo with Bounce Animation
                  Center(
                    child: ScaleBounceAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: Image.asset(
                        'assets/images/onboarding_illustration.png',
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text with Staggered Animation
                  Center(
                    child: StaggeredAnimation(
                      index: 1,
                      child: const Text(
                        'WELCOME BACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Futura PT',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: StaggeredAnimation(
                      index: 2,
                      child: const Text(
                        'SIGN IN TO CONTINUE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Futura PT',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Phone Input
                  StaggeredAnimation(
                    index: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFA3CB43),
                          width: 2,
                        ),
                      ),
                      child: IntlPhoneField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Enter phone number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          counterText: '',
                        ),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          _fullPhoneNumber = phone.completeNumber;
                        },
                        disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.trailing,
                        flagsButtonPadding: const EdgeInsets.only(left: 16),
                        showCountryFlag: true,
                        dropdownTextStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Input
                  StaggeredAnimation(
                    index: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFA3CB43),
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign In Button
                  StaggeredAnimation(
                    index: 5,
                    child: authState.maybeWhen(
                      loading: () => const Center(child: LoadingIndicator()),
                      orElse: () => CustomButton(
                        text: 'Sign In',
                        onPressed: _handleLogin,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign Up Link
                  StaggeredAnimation(
                    index: 6,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => context.go('/onboarding/phone'),
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(
                            color: Color(0xFFA3CB43),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Become a Creator
                  StaggeredAnimation(
                    index: 7,
                    child: const Center(
                      child: Text(
                        'BECOME A PODCAST CREATOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
