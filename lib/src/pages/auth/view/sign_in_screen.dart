import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:quitanda/src/pages/widgets/app_name_widget.dart';
import 'package:quitanda/src/pages/widgets/custom_text_field.dart';

import 'package:quitanda/src/config/custom_colors.dart';

import 'package:quitanda/src/pages_routes/app_pages.dart';
import 'package:quitanda/src/services/utils_services.dart';
import 'package:quitanda/src/services/validator.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  //controlador de campo
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; //pega size da tela (largura e altura)

    return Scaffold(
        backgroundColor: newCustomColors.customContrastColor,
        body: SizedBox(
          height: size.height, //altura vai ter EXATA altura da tela
          width: size.width,
          child: Column(
            children: [
              //recebe lista de widgets
              Expanded(
                  child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, //centralizado os textos

                children: [
                  //NOME DO APP
                  const AppNameWidget(
                    greenTitleColor: Colors.white,
                    textSize: 40,
                  ),
                  //CATEGORIAS

                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      //aplica pra trodos q tem com filho
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      child: AnimatedTextKit(
                          //pausa q da entre uma categoria e outra
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            //categorias param entao usa repeat forever
                            FadeAnimatedText('Fruits'),
                            FadeAnimatedText('Vegetables'),
                            FadeAnimatedText('Meat'),
                            FadeAnimatedText('Cereals'),
                          ]),
                    ),
                  )
                ],
              )),
              Container(
                //FORMULARIO
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ), //espaçamento no eixo simetrico
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    //aplica circunferencia no quadrante superior ou inferior
                    top: Radius.circular(60),
                  ),
                ),

                //EMAILE  SENHA
                child: SingleChildScrollView(
                  child: Form(
                    //controlador de validacao
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, //esticar filhos no eixo horizontal
                      children: [
                        CustomTextField(
                            controller: emailController,
                            icon: Icons.email,
                            label: 'Email',
                            validator: emailValidator),
                        CustomTextField(
                          controller: passwordController, //recuperar valores
                          icon: Icons.lock,
                          label: 'Password',
                          isSrecet: true,
                          validator: passwordValidator,
                        ),

                        //botao de entrar
                        SizedBox(
                          //definir altura ou largura
                          height: 50,
                          width: 120,
                          child: GetX<AuthController>(
                            builder: (authController) {
                              return ElevatedButton(
                                //wrap cm getX
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        //fechar teckadi
                                        FocusScope.of(context)
                                            .unfocus(); //tira focus do campo de texto
                                        if (_formKey.currentState!.validate()) {
                                          String email = emailController.text;
                                          String password =
                                              passwordController.text;
                                          authController.signIn(
                                              email: email, password: password);
                                        } else {
                                          print('campo n valido');
                                        }
                                        ; //aciona metodo de validacao e se passar em tudo
                                        //Get.offNamed(PagesRoutes   .baseRoute); //tira a tela de sigin da pilha e dxa só a tela base
                                      },
                                child: authController.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: newCustomColors.customContrastColor,
                                      )
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),

                        //ESQUECEU A SENHA
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              final bool? result = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ForgotPasswordDialog(
                                        email: emailController.text);
                                  });

                              if (result ?? false) {
                                utilsServices.showToast(
                                  message:
                                      'Link de recuperacao enviado para email',
                                );
                              }
                            },
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: newCustomColors.forgetPassword,
                              ),
                            ),
                          ),
                        ),

                        //DIVISOR

                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Color.fromARGB(255, 190, 190, 190),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('Ou'),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Color.fromARGB(255, 190, 190, 190),
                                  thickness: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                )),
                            onPressed: () {
                              //ADD NA PILHA DE SCREENS MAIS UMA TELA (CADASTRO)
                              Get.toNamed(PagesRoutes.signupRoute);
                            },
                            child: const Text(
                              'Cadastrar-se',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
