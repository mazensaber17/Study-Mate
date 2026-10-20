class StudyMaterial {
  const StudyMaterial({required this.id, required this.name});

  final int id;
  final String name;

  static const List<StudyMaterial> available = [
    StudyMaterial(id: 0, name: 'Digital Signal Processing'),
    StudyMaterial(id: 1, name: 'Operating Systems'),
    StudyMaterial(id: 2, name: 'Internet of Things'),
    StudyMaterial(id: 3, name: 'Computer Graphics'),
    StudyMaterial(id: 4, name: 'Parallel Processing'),
    StudyMaterial(id: 5, name: 'Mobile App Development'),
    StudyMaterial(id: 6, name: 'Machine Learning'),
  ];
}
