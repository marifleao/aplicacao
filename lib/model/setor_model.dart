class SetorModel {
  int? id;
  String? setor;

  SetorModel({
    this.id,
    this.setor,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'setor': setor,
    };
  }

  factory SetorModel.fromJson(Map<String, dynamic> json) {
    return SetorModel(
      id: json['id'],
      setor: json['setor'].toString(),
    );
  }
}
