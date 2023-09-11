import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/cupcakesbr_state.dart';
import '../../core/ui/widgets/cupcakesbr_appbar.dart';
import '../../core/ui/widgets/cupcakesbr_button.dart';
import '../../core/ui/widgets/cupcakesbr_textformfield.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState
    extends CupcakesbrState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupcakesbrAppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColorDark,
                    ),
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro',
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 30),
                  CupcakesbrTextformfield(
                    label: 'Nome',
                    controller: _nameEC,
                    validator: Validatorless.required('Nome obrigatório'),
                  ),
                  const SizedBox(height: 30),
                  CupcakesbrTextformfield(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail inválido')
                    ]),
                  ),
                  const SizedBox(height: 30),
                  CupcakesbrTextformfield(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'A senha deve conter ao menos 6 caracteres')
                    ]),
                  ),
                  const SizedBox(height: 30),
                  CupcakesbrTextformfield(
                    label: 'Confirmar Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma senha é obrigatório'),
                      Validatorless.compare(
                          _passwordEC, 'Senha diferente de confirma senha')
                    ]),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: CupcakesbrButton(
                      // width: context.width,
                      width: double.infinity,
                      label: 'CADASTRAR',
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          controller.register(
                            name: _nameEC.text,
                            email: _emailEC.text,
                            password: _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
