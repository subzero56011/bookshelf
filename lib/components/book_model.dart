class Book {
  String id;
  String name;
  String author;
  String? description;
  bool isRead;

  Book({
    required this.id,
    required this.name,
    required this.author,
    this.description,
    this.isRead = false,
  });

  // Converts a Book object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'isRead': isRead,
    };
  }

  // Create a Book object from a map
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      isRead: json['isRead'],
    );
  }
}
