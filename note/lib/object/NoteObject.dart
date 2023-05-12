class NoteObject {
  final int? id;
  final String? nameNote;
  final String contentNote;
   final bool check;

  NoteObject(
      {required this.contentNote, this.nameNote, this.id,    required this.check});

  factory NoteObject.fromJson(Map<String, dynamic> json) => NoteObject(
      id: json['id'],
      nameNote: json['nameNote'],
      contentNote: json['contentNote'],
      check: json['check']== 1 ? true : false,);

  Map<String, dynamic> toJson() =>
      {'id': id, 'nameNote': nameNote, 'contentNote': contentNote, 'check': check?1 : 0,};
}
