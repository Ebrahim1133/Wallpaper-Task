class Favourite {

  String? imageUrl;

  Favourite({   this.imageUrl});

  factory Favourite.fromMap(Map<String, dynamic> parsedJson) {
    return Favourite(
      imageUrl: parsedJson["portrait"],

       );
  }
  Map<String, dynamic> toJson() {
    return {

      "portrait": imageUrl,

    };
  }
}