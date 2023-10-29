part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
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
    final controller = Modular.get<RegisterController>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            label: "Login",
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("Login obrigatorio"),
              Validatorless.email("Login deve ser um e-mail valido"),
            ]),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required("Senha obrigatoria"),
              Validatorless.min(6, "Senha deve contem no minomo 6 caracteres"),
            ]),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Confirmar Senha",
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("Confirma senha obrigatorio"),
              Validatorless.min(
                  6, "Confirma senha deve contem no minomo 6 caracteres"),
              Validatorless.compare(_passwordEC, "Senhas nao conferem"),
            ]),
            textInputAction: TextInputAction.send,
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            onPressed: () {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                controller.register(
                    email: _loginEC.text, password: _passwordEC.text);
              }
            },
            label: "Cadastrar",
          ),
        ],
      ),
    );
  }
}
