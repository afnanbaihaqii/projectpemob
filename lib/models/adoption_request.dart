class AdoptionRequest {
  final String id;
  final String petId;
  final String petName;
  final String userName;
  final String status;

  AdoptionRequest({
    required this.id,
    required this.petId,
    required this.petName,
    required this.userName,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'petId': petId,
        'petName': petName,
        'userName': userName,
        'status': status,
      };

  factory AdoptionRequest.fromJson(Map<String, dynamic> json) {
    return AdoptionRequest(
      id: json['id'],
      petId: json['petId'],
      petName: json['petName'],
      userName: json['userName'],
      status: json['status'],
    );
  }
}
