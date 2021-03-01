import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'form_controller.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final controller = GetIt.I.get<FormController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Novo Card'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                    controller: controller.name,
                    title: 'Nome ',
                    hint: 'Ex: Erick',
                    validator: controller.nameValidator
                    // (value) => value.isNotEmpty && value.length > 2
                    //     ? null
                    //     : 'Digite um nome'
                    ),
                TextFieldWidget(
                  controller: controller.email,
                  title: 'E-mail',
                  hint: 'slideworks@slideworks.com.br',
                  validator: controller.emailValidator,
                  keyboard: TextInputType.emailAddress,
                ),
                TextFieldWidget(
                  controller: controller.phone,
                  title: 'Telefone',
                  hint: 'Ex:(00)90000-0000',
                  keyboard: TextInputType.number,
                  validator: controller.phoneValidator,
                ),
                TextFieldWidget(
                  controller: controller.doc,
                  title: 'CPF',
                  hint: '000.000.000-00',
                  keyboard: TextInputType.number,
                  validator: controller.docValidator,
                ),
                TextFieldWidget(
                    controller: controller.birth,
                    keyboard: TextInputType.number,
                    title: 'Data de Nascimento',
                    hint: '01/02/1990',
                    validator: controller.birthValidator),
                TextFieldWidget(
                  controller: controller.city,
                  title: 'Cidade',
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Digite uma cidade',
                ),
                TextFieldWidget(
                  controller: controller.state,
                  title: 'Estado',
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Digite um Estado',
                ),
                TextFieldWidget(
                  controller: controller.country,
                  title: 'País',
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Digite um País',
                ),
                ValueListenableBuilder(
                  valueListenable: controller.isLoading,
                  builder: (_, value, child) => RaisedButton(
                    onPressed: value
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              controller.request(context);
                            }
                          },
                    color: Colors.blue,
                    child: Text(
                      value ? 'Enviando...' : 'Adicionar',
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final String Function(String) validator;
  final TextInputType keyboard;
  TextFieldWidget(
      {@required this.controller,
      @required this.title,
      this.hint,
      this.keyboard,
      @required this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          alignLabelWithHint: true, labelText: title, hintText: hint),
    );
  }
}
