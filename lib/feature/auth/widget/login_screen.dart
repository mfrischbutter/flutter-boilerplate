// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/shared/util/validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: tr('form.label.email')),
                controller: _emailController,
                validator: (val) {
                  if (!Validator.isValidEmail(val)) {
                    return tr('form.error.email');
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: tr('form.label.password')),
                controller: _passwordController,
                obscureText: true,
                validator: (val) {
                  if (!Validator.isValidPassWord(val)) {
                    return tr('form.error.password');
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(authProvider.notifier)
                        .login(_emailController.text, _passwordController.text);
                  }
                },
                child: Text(
                  tr('btn.login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
