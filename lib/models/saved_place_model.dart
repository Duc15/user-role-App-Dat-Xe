class SavedPlaceModel {
  String placeName;
  String placeAddress;

  SavedPlaceModel({required this.placeName, required this.placeAddress});

  // Convert SavedPlaceModel to Map (for saving to storage)
  Map<String, dynamic> toMap() {
    return {
      'placeName': placeName,
      'placeAddress': placeAddress,
    };
  }

  // Convert Map to SavedPlaceModel (for loading from storage)
  factory SavedPlaceModel.fromMap(Map<String, dynamic> map) {
    return SavedPlaceModel(
      placeName: map['placeName'],
      placeAddress: map['placeAddress'],
    );
  }
}
