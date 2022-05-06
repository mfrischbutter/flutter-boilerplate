// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  final _emailController = useTextEditingController();
  final _passwordController = useTextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'email hint'),
              controller: _emailController,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'password hint'),
              controller: _passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(authProvider)
                    .login(_emailController.text, _passwordController.text);
              },
              child: const Text('login'),
            ),
          ],
        ),
      ),
    );
  }
}
