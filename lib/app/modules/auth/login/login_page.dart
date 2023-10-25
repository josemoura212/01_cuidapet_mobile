import 'package:cuidapet_mobile/app/core/ui/icons/cuidapet_icons.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_textform_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 12),
              CuidapetTextFormField(
                label: "Login",
                obscureText: false,
                controller: _nameEC,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Valor obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Text(_nameEC.text),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: const Text("Validar"),
              ),
              const SizedBox(height: 12),
              CuidapetDefaultButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Clicou")));
                },
                label: "Entrar",
              ),
              const SizedBox(height: 12),
              RoundedButtonWithIcon(
                onTap: () {},
                width: 200,
                color: Colors.blue,
                icon: CuidapetIcons.facebook,
                label: "Facebook",
              ),
              const SizedBox(height: 12),
              RoundedButtonWithIcon(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Clicou no google")));
                },
                width: 200,
                color: Colors.orange,
                icon: CuidapetIcons.google,
                label: "Google",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
