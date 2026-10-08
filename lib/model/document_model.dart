enum DocumentStatus { ready, processing, failed }

class DocumentModel {
  const DocumentModel({
    required this.name,
    this.status = DocumentStatus.ready,
  });

  final String name;
  final DocumentStatus status;
}
