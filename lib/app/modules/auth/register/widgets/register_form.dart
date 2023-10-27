part of '../register_page.dart';

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CuidapetTextFormField(label: "Login"),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Confirmar Senha",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            onPressed: () {},
            label: "Cadastrar",
          ),
        ],
      ),
    );
  }
}
