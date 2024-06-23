import 'dart:convert';
import 'dart:io';
import 'package:aplicacao/model/funcionario_model.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacao/model/setor_model.dart';

String host = "http://localhost/api/index.php";

todosOsFuncionarios({required List<FuncionarioModel> funcionarios}) {
  limparPrint();
  for (int i = 0; i < funcionarios.length; i++) {
    printO(
        "${funcionarios[i].matricula} - ${funcionarios[i].nome} - ${funcionarios[i].setor?.setor}");
  }
}

todosOsSetores({required List<SetorModel> setor}) {
  limparPrint();
  for (SetorModel item in setor) {
    printO("${item.id} - ${item.setor}");
  }
}

cadastrarFuncionario() async {
  try {
    limparPrint();
    FuncionarioModel funcionarios = FuncionarioModel();
    funcionarios.setor = SetorModel();
    printO("...::: Cadastrar funcionario :::...");
    printO("Nome do novo funcionario:");
    funcionarios.nome = stdin.readLineSync()!;
    printO("Codigo do setor");
    funcionarios.setor?.id = int.parse(stdin.readLineSync()!);

    var response = await http.post(
      Uri.parse(host),
      body: {
        'acao': 'cadastro_funcionario',
        'nome': '${funcionarios.nome}',
        'id_setor': '${funcionarios.setor?.id}',
      },
    );

    if (response.statusCode == 200) {
      printW("Funcionario Cadastrado com sucesso, matricula: ${response.body}");
    } else {
      printW("Erro ao fazer o cadastro:\n ${response.body}");
    }
  } catch (e) {
    printE("Erro CadastrarFuncionario: $e");
  }
}

cadastrarSetor() async {
  try {
    limparPrint();
    SetorModel setor = SetorModel();

    printO("...::: Cadastrar setor :::...");
    printO("Nome do novo setor:");
    setor.setor = stdin.readLineSync()!;

    var response = await http.post(
      Uri.parse(host),
      body: {
        'acao': 'cadastro_setor',
        'setor': '${setor.setor}',
      },
    );

    if (response.statusCode == 200) {
      printW("Setor Cadastrado com sucesso, id: ${response.body}");
    } else {
      printW("Erro ao fazer o cadastro:\n ${response.body}");
    }
  } catch (e) {
    printE("Erro CadastrarSetor: $e");
  }
}

atualizarFuncionario() async {
  try {
    limparPrint();
    FuncionarioModel funcionarios = FuncionarioModel();
    funcionarios.setor = SetorModel();
    printO("...::: Atualizar funcionario :::...");
    printO("Qual a matricula do funcionario?");
    funcionarios.matricula = stdin.readLineSync()!;
    printO("Qual o novo nome do funcionario?");
    funcionarios.nome = stdin.readLineSync()!;
    printO("Usuário bloqueado (S ou N)?");
    funcionarios.bloqueado = stdin.readLineSync()!;
    printO("Qual o código do setor?");
    funcionarios.setor?.id = int.parse(stdin.readLineSync()!);
    var response = await http.post(
      Uri.parse(host),
      body: {
        'acao': 'atualizar_funcionario',
        'matricula': '${funcionarios.matricula}',
        'nome': '${funcionarios.nome}',
        'bloqueado': '${funcionarios.bloqueado}',
        'id_setor': '${funcionarios.setor?.id}',
      },
    );

    if (response.statusCode == 200) {
      printW("Funcionario Atualizado com sucesso, matricula: ${response.body}");
    } else {
      printW("Erro ao fazer a atualização:\n ${response.body}");
    }
  } catch (e) {
    printE("Erro AtualizarFuncionario: $e");
  }
}

atualizarSetor() async {
  try {
    limparPrint();
    SetorModel setor = SetorModel();
    printO("...::: Atualizar setor :::...");
    printO("Qual o id do Setor?");
    setor.id = int.parse(stdin.readLineSync()!);
    printO("Qual o novo nome do setor?");
    setor.setor = stdin.readLineSync();
    var response = await http.post(
      Uri.parse(host),
      body: {
        'acao': 'atualizar_setor',
        'id': '${setor.id}',
        'setor': '${setor.setor}',
      },
    );

    if (response.statusCode == 200) {
      printW("Setor Atualizado com sucesso, id: ${response.body}");
    } else {
      printW("Erro ao fazer a atualização:\n ${response.body}");
    }
  } catch (e) {
    printE("Erro AtualizarSetor: $e");
  }
}

relatorio() {
  limparPrint();
  printE('Implementar relatorio');
}

Future<List<FuncionarioModel>> getFuncionarios() async {
  try {
    final res = await http.get(Uri.parse("$host?acao=funcionario"));
    List retono = jsonDecode(res.body);

    return retono.map((item) => FuncionarioModel.fromJson(item)).toList();
  } catch (e) {
    printE("Erro ao carregar funcionarios: $e");
    return [];
  }
}

Future<List<SetorModel>> getSetor() async {
  try {
    final res = await http.get(Uri.parse("$host?acao=setor"));
    List retono = jsonDecode(res.body);

    return retono.map((item) => SetorModel.fromJson(item)).toList();
  } catch (e) {
    printE("Erro ao carregar setor: $e");
    return [];
  }
}

void printW(text) {
  print('\x1B[33m$text\x1B[0m');
}

void printE(text) {
  print('\x1B[31m$text\x1B[0m');
}

void printO(text) {
  print('\x1b[32m$text\x1B[0m');
}

void limparPrint() {
  print("\x1B[2J\x1B[0;0H");
}
