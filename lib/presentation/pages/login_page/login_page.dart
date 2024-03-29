import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mybutton.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mytextfield.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserUnauthenticated) {
              if (state.message != null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              }
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                verticalSpace(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png'),
                    horizontalSpace(10),
                    const Text(
                      'tezda',
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    )
                  ],
                ),
                //verticalSpace(10),
                const Text(
                  'Your Gateway to an Immersive Shopping Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(50),
                MyTextField(
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: darkGrey,
                  ),
                ),
                verticalSpace(20),
                MyTextField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: darkGrey,
                  ),
                ),
                verticalSpace(20),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: darkGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpace(25),
                state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: MyButton(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ontap: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              if (state is AuthUserUnauthenticated) {
                                FocusScope.of(context).unfocus();
                                context.read<AuthBloc>().add(
                                    AuthLoginButtonPressed(emailController.text,
                                        passwordController.text));
                              }
                            }
                          },
                        ),
                      ),
                verticalSpace(20),
                TextButton(
                  onPressed: () => context.push('/signup'),
                  child: const Text(
                    "Didn't have any account? Register Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
