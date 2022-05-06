// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/route/router.gr.dart';

class SignInPage extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  Text(
                    'sign in',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  Form(
                    child: Column(
                      children: [
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
                            _widgetSignInButton(context, ref),
                            const SizedBox(height: 30),
                            Text(
                              'new user',
                              textAlign: TextAlign.center,
                            ),
                            _widgetSignUpButton(context),
                          ],
                        ),
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
            ref
                .read(authProvider.notifier)
                .login(_emailController.text, _passwordController.text);
          },
          child: Text('sign in'),
        ));
  }

  Widget _widgetSignUpButton(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.router.push(SignUpRoute());
            //context.navigateTo(SignUpWidget)
            //const SignUpWidget().show(context);
          },
          child: Text('sign up'),
        ));
  }
}
