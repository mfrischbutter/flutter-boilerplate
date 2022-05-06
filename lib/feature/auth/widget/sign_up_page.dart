// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';

class SignUpPage extends ConsumerWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (value, prev) {
      if (value is AuthState) {
        value.maybeWhen(loggedIn: () {
          context.router.popUntilRoot();
        }, orElse: () {
          {}
        });
      }
    });

    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  Text(
                    'sign up',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'name hint'),
                          controller: _nameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'email hint'),
                          controller: _emailController,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'password hint'),
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 30),
                              _widgetSignUpButton(context, ref),
                              const SizedBox(height: 30),
                              Text(
                                'already user',
                                textAlign: TextAlign.center,
                              ),
                              _widgetSignInButton(context, ref),
                            ]),
                      ],
                    ),
                  )
                ])));
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.router.pop();
          },
          child: Text('sign in'),
        ));
  }

  Widget _widgetSignUpButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).signUp(_nameController.text,
                _emailController.text, _passwordController.text);
          },
          child: Text('sign up'),
        ));
  }
}
