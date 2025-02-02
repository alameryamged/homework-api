import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/widgets/social_login_button.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/auth/controllers/login_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Log In",
                  style: Get.textTheme.titleLarge,
                ),
                const SizedBox(height: 80),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: "Password",
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          validator: validatePassword,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Pages.forgotPassword);
                            },
                            child: Text("Forgot password?",
                                style: Get.textTheme.bodyMedium),
                          ),
                        ),
                        Obx(() {
                          return _controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    _login();
                                  },
                                  child: const Text("Log in"),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                        }),
                      ],
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Pages.signUp);
                      },
                      child: Text(
                        "Sign up",
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Or log in with",
                  // style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      icon: Icons.facebook,
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 20),
                    SocialLoginButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _controller.login(emailController.text, passwordController.text);
    }
  }
}
