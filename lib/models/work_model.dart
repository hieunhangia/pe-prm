class WorkModel {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;

  WorkModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isCompleted: map['isCompleted'] == 1 || map['isCompleted'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  WorkModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return WorkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
