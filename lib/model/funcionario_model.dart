import 'setor_model.dart';

class FuncionarioModel {
  String? matricula;
  String? nome;
  String? bloqueado;
  SetorModel? setor;

  FuncionarioModel({
    this.matricula,
    this.nome,
    this.bloqueado,
    this.setor,
  });

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'nome': nome,
      'status': bloqueado,
      'setor': setor!.toJson(),
    };
  }

  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      matricula: json['matricula'].toString(),
      nome: json['nome'],
      bloqueado: json['bloqueado'],
      setor: SetorModel(id: json['id'], setor: json['setor']),
    );
  }
}
