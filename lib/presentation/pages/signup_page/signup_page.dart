import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/constants.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mybutton.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mytextfield.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(); // Added

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose(); // Added
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message!)),
                );
              }
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                verticalSpace(40),
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
                // verticalSpace(5),
                const Text(
                  'Your Gateway to an Immersive Shopping Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(40),
                MyTextField(
                  labelText: 'Name',
                  textInputType: TextInputType.name,
                  controller: nameController,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: darkGrey,
                  ),
                ),
                verticalSpace(20),
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
                verticalSpace(30),
                state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: MyButton(
                    child: const Text('REGISTER',
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    ontap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        if (state is AuthUserUnauthenticated) {
                          FocusScope.of(context).unfocus();
                          context.read<AuthBloc>().add(
                            AuthSignupButtonPressed(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                verticalSpace(20),
                TextButton(
                  onPressed: () => context.push('/login'),
                  child: const Text(
                    "Already have an account? Login Here",
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
