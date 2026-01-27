class Student {
  final String id;
  final String name;
  final int progress;
  final bool hasAccess;

  Student({
    required this.id,
    required this.name,
    required this.progress,
    required this.hasAccess,
  });

  Student copyWith({
    int? progress,
    bool? hasAccess,
  }) {
    return Student(
      id: id,
      name: name,
      progress: progress ?? this.progress,
      hasAccess: hasAccess ?? this.hasAccess,
    );
  }
}
