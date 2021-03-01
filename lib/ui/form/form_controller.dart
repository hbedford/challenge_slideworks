import 'package:challenge_slideworks/domain/entities/helpers/http_error.dart';
import 'package:challenge_slideworks/infra/http/http_adapter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:http/http.dart';

class FormController {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = MaskedTextController(mask: '(00)9 0000-0000');
  final doc = MaskedTextController(mask: '000.000.000-00');
  final birth = MaskedTextController(mask: '00/00/0000');
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final keyEditting = TextEditingController();
  final tokenEditting = TextEditingController();
  final ValueNotifier<bool> editKeyAndToken;
  final String url = 'https://api.trello.com/1/cards';
  final ValueNotifier<String> key;
  final ValueNotifier<String> token;
  final String idList = '&idList=603d492c5ca4f95ef283e63c';
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  FormController({@required String key, @required String token})
      : this.key = ValueNotifier<String>(key),
        this.token = ValueNotifier<String>(token),
        this.editKeyAndToken = ValueNotifier<bool>(key != null &&
                key != 'SUA_KEY' &&
                token != null &&
                key != 'SEU_TOKEN'
            ? false
            : true);
  changeLoading() => isLoading.value = !isLoading.value;

  String get nameString => '- Nome ${name.text}';
  String get emailString => '\n- Email ${email.text}';
  String get phoneString => '\n- Telefone ${phone.text}';
  String get docString => '\n- CPF ${doc.text}';
  String get birthString => '\n- Data de Nascimento ${birth.text}';
  String get cityString => '\n- Cidade ${city.text}';
  String get stateString => '\n- State ${state.text}';
  String get countryString => '\n- Country ${country.text}';

  String get description =>
      "&desc=" +
      nameString +
      emailString +
      phoneString +
      docString +
      birthString +
      cityString +
      stateString +
      countryString;

  String nameValidator(String value) =>
      value.isNotEmpty && value.length > 2 ? null : 'Digite um nome';
  String emailValidator(String value) =>
      value.isNotEmpty && value.contains('@') ? null : 'Digite um email valido';
  String phoneValidator(String value) => value.isNotEmpty && value.length == 15
      ? null
      : 'Digite seu telefone corretamente';
  String docValidator(String value) =>
      value.isNotEmpty && value.length == 14 ? null : 'Digite um CPF valido';
  String birthValidator(String value) =>
      value.isNotEmpty ? null : 'Digite uma data valida';

  String get nameCard => '&name=${name.text}';
  String get uri =>
      url +
      '?key=' +
      key.value +
      '&token=' +
      token.value +
      idList +
      nameCard +
      description;
  clear() {
    name.clear();
    email.clear();
    phone.clear();
    doc.clear();
    birth.clear();
    city.clear();
    state.clear();
    country.clear();
  }

  showEditorKeyAndToken() => editKeyAndToken.value = !editKeyAndToken.value;
  changeKeyAndToken() {
    key.value = keyEditting.text;
    token.value = tokenEditting.text;
    showEditorKeyAndToken();
  }

  request(BuildContext context) async {
    changeLoading();
    Client client = Client();

    HttpAdapter adapter = HttpAdapter(client);
    await adapter
        .request(
      url: uri,
      method: 'post',
    )
        .then((value) {
      changeLoading();
      clear();
      Flushbar(
        backgroundColor: Colors.blue,
        title: 'Card criado com Succeo',
        message: 'Seu Card agora esta registrado com sucesso no Trello',
        duration: Duration(seconds: 2),
      ).show(context);
    }).catchError((error) {
      isLoading.value = false;
      String message = getError(error);
      Flushbar(
        backgroundColor: Colors.red,
        title: 'Ops, ocorreu algum problema',
        message: message,
        duration: Duration(seconds: 4),
      ).show(context);
    });
  }

  String getError(error) {
    switch (error) {
      case HttpError.unauthorized:
        return 'Key ou Token incorreto';
      case HttpError.serverError:
        return 'Erro no servidor, tente mais tarde';
      case HttpError.badRequest:
        return 'Requisição invalida';
      case HttpError.invalidData:
        return 'Dados invalidos';
      default:
        return 'Algo occoreu de errado';
    }
  }
}
