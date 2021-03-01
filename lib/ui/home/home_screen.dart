import 'package:challenge_slideworks/ui/form/form_controller.dart';
import 'package:challenge_slideworks/ui/form/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  final controller = GetIt.I.get<FormController>();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: controller.editKeyAndToken,
                builder: (_, value, child) => Visibility(
                      visible: !value,
                      child: InkWell(
                          onTap: () => Navigator.pushNamed(context, '/form'),
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Criar novo Card',
                                style: Theme.of(context).accentTextTheme.button,
                              ),
                            ),
                          )),
                    )),
            ValueListenableBuilder(
                valueListenable: controller.editKeyAndToken,
                builder: (_, value, child) => Visibility(
                      visible: !value,
                      child: TextButton(
                        child: Text('Alterar Key e Token do Trello'),
                        onPressed: () => controller.showEditorKeyAndToken(),
                      ),
                    )),
            ValueListenableBuilder(
              valueListenable: controller.editKeyAndToken,
              builder: (_, value, child) => Visibility(
                visible: controller.editKeyAndToken.value,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: controller.keyEditting,
                          title: 'Key do Trello',
                          validator: (value) =>
                              value.isNotEmpty ? null : 'Digite a Key',
                        ),
                        TextFieldWidget(
                            controller: controller.tokenEditting,
                            title: 'Token do Trello',
                            validator: (value) =>
                                value.isNotEmpty ? null : 'Digite o Token'),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RaisedButton(
                              child: Text('Salvar',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .button),
                              color: Colors.blue,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  controller.changeKeyAndToken();
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
