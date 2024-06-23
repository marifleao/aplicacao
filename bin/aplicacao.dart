import 'dart:io';
import 'package:aplicacao/funcoes.dart';
import 'package:aplicacao/model/funcionario_model.dart';
import 'package:aplicacao/model/setor_model.dart';

void main() async {
  List<FuncionarioModel> funcionarios = [];
  List<SetorModel> setor = [];

  funcionarios = await getFuncionarios();
  setor = await getSetor();

  String? opc;
  do {
    printW("""
    ...::: MENU :::... "
    1. Todos dos funcionario."
    2. Todos dos setor.
    3. Cadastro de funcionario.
    4. Cadastro de setor.
    5. Atualizar funcionario.
    6. Atualizar setor.
    7. Relatorio (Implementar).
    8. Sair.
  """);

    opc = stdin.readLineSync();
    switch (opc) {
      case '1':
        todosOsFuncionarios(funcionarios: funcionarios);
        break;
      case '2':
        todosOsSetores(setor: setor);
        break;
      case '3':
        await cadastrarFuncionario();
        funcionarios = await getFuncionarios();
        break;
      case '4':
        await cadastrarSetor();
        setor = await getSetor();
        break;
      case '5':
        await atualizarFuncionario();
        funcionarios = await getFuncionarios();
        break;
      case '6':
        await atualizarSetor();
        setor = await getSetor();
        break;
      case '7':
        relatorio();
        break;
      case '8':
        printE("Saindo");
        break;
      default:
        printE("Opção Invalida");
    }
  } while (opc != '8');
}
