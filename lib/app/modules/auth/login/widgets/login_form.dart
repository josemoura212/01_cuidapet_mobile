part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            label: "Login",
            controller: _loginEC,
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
            controller: _passwordEC,
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            onPressed: () {},
            label: "Entrar",
          ),
        ],
      ),
    );
  }
}
