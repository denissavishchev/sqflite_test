class Model{
  int? id;
  String title;
  String description;
  DateTime createdAt;

  Model({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }
}