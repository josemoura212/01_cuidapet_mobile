part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  final controller = Modular.get<LoginController>();
  _LoginRegisterButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: [
        RoundedButtonWithIcon(
          onTap: () {},
          width: .42.sw,
          color: const Color(0xff4267b3),
          icon: CuidapetIcons.facebook,
          label: "Facebook",
        ),
        RoundedButtonWithIcon(
          onTap: () {
            controller.socialLogin(SocialLoginType.google);
          },
          width: .42.sw,
          color: const Color(0xffe15031),
          icon: CuidapetIcons.google,
          label: "Google",
        ),
        RoundedButtonWithIcon(
          onTap: () {
            Navigator.pushNamed(context, "/auth/register");
          },
          width: .42.sw,
          color: context.primaryColorDark,
          icon: Icons.email,
          label: "Cadastre-se",
        ),
      ],
    );
  }
}
