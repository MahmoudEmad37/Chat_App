import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _username = "";

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
          _email.trim(), _password.trim(), _username.trim(), _isLogin, context);
      // print(_email);
      // print(_password);
      // print(_username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email Address"),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 7) {
                      return "Password must be at least 7 characters";
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val!,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 12.0),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    onPressed: _submit,
                  ),
                if (!widget.isLoading)
                  TextButton(
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
