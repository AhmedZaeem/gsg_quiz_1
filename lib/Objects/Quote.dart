class Quote {
  String? content;
  String? author;
  List<String>? tags;

  Quote({this.content, this.author, this.tags});

  Quote.fromJson(List<dynamic> json) {
    content = json[0]['content'];
    author = json[0]['author'];
    tags = json[0]['tags'].cast<String>();
  }
}
