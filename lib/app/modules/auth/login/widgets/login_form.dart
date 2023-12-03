part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends PageLifeCycleState<LoginController, _LoginForm> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            label: "Login",
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("Campo obrigatório"),
              Validatorless.email("E-mail inválido"),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required("Campo obrigatório"),
              Validatorless.min(6, "Mínimo de 6 caracteres"),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            onPressed: () {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                controller.login(
                  login: _loginEC.text,
                  password: _passwordEC.text,
                );
              }
            },
            label: "Entrar",
          ),
        ],
      ),
    );
  }
}
