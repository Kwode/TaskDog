class ServiceRequest {
  final String? category;
  final String? description;
  final DateTime? preferredDate;
  final String? urgency;

  ServiceRequest({
    this.category,
    this.description,
    this.preferredDate,
    this.urgency,
  });

  ServiceRequest copyWith({
    String? category,
    String? description,
    DateTime? preferredDate,
    String? urgency,
  }) {
    return ServiceRequest(
      category: category ?? this.category,
      description: description ?? this.description,
      preferredDate: preferredDate ?? this.preferredDate,
      urgency: urgency ?? this.urgency,
    );
  }
}