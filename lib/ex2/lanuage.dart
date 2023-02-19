class Language {
  String? name;
  int? likes;

  Language({this.name, this.likes});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    return {
    "name": name,
    "likes": likes
};
  }
  
}
