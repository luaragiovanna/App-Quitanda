import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/widgets/custom_text_field.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/services/validator.dart';

import '../../../config/app_data.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  //formatar valores CPF
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')}, //caracter default
  );

//TELEFONE
  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: newCustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      //texto vem pro meio da tela
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  //FORMULARIO
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    child: Form(
                      //FORMULARIO DE CADASTRO
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .stretch, //ESTICAR COLUNA NO EIXO CRUZADO
                        children: [
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            onSaved: (value) {
                              //recuperar objeto 9(authcontroller)
                              authController.user.name = value;
                            },
                            validator: nameValidator,
                          ),
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                            textInputType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            inputFormatters: [cpfFormatter],
                            textInputType: TextInputType.number,
                            validator: cpfValidator,
                          ),

                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            inputFormatters: [phoneFormatter],
                            textInputType: TextInputType.phone,
                            validator: phoneValidator,
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                            isSrecet: true,
                            validator: passwordValidator,
                          ),

                          //BOTAO
                          SizedBox(
                              height: 50,
                              child: Obx(() {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          newCustomColors.customSwatchColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!
                                                .save(); //aciona o onsaved de cada campo

                                            //retira teclado da tela
                                            authController.signUp();
                                          }
                                        },
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Cadastrar usuario',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                //posicionar em qualquer lugar da tela
                left: 10,
                top: 10,
                child: SafeArea(
                  //traz botao pra area segura (n dxa na area de notificacao)
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); //tira a tela q esta mais acima e volta pra home
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
