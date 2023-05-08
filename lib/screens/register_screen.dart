import 'package:flutter/material.dart';
import 'package:login/providers/login_form_provider.dart';
import 'package:login/services/services.dart';
import 'package:login/ui/input_decorations.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Crear una cuenta',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                    create: (context) => LoginFormProvider(),
                    child: const _LoginForm())
              ],
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: const MaterialStatePropertyAll(StadiumBorder())),
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: const Text('¿Ya tienes una cuenta?',
                  style: TextStyle(fontSize: 18, color: Colors.black87))),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoratons.authInputDecorations(
                    hintText: 'xxx@xx.xxx',
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginFormProvider.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Formato incorrecto';
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoratons.authInputDecorations(
                    hintText: '*****',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginFormProvider.password = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña debe ser mayor a 6 caracteres';
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: loginFormProvider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginFormProvider.isValidForm()) return;

                        loginFormProvider.isLoading = true;

                        // validar si el login es correcto

                        final String? respAuthService =
                            await authService.createUser(
                                loginFormProvider.email,
                                loginFormProvider.password);

                        if (respAuthService == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          print(respAuthService);
                          loginFormProvider.isLoading = false;
                        }
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                color: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Container(
                    child: Text(
                  loginFormProvider.isLoading ? 'Espere' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                )),
              )
            ],
          )),
    );
  }
}
