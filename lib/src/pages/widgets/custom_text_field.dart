import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSrecet;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final GlobalKey<FormFieldState>? formFieldKey;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isSrecet = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.textInputType,
    this.onSaved,
    this.formFieldKey,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    isObscure = widget.isSrecet;
  }

  //classe tem estado agr, da pra mudar valor
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly, //campo apenas de leitura
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        keyboardType:
            widget.textInputType, //muda o tipo de dado apresentado no teclado
        decoration: InputDecoration(
            suffixIcon: widget.isSrecet
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure =
                            !isObscure; //a classe inicialmente n tem estado, entao pra modificar valor pra ser apresentado na tela
                      });
                      //se campo de texto oculto, n apresenta valor
                    },
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            prefixIcon: Icon(widget.icon),
            labelText: widget.label,
            //baixar o campo de texto
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        //
      ),
    );
  }
}
