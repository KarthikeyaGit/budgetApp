class Category {
  int categoryId;
  int userId;
  String categoryName;
  int defaultType;

  Category({
    required this.categoryId,
    required this.userId,
    required this.categoryName,
    this.defaultType = 1,
  });

  // Convert a Category object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'user_id': userId,
      'category_name': categoryName,
      'default_type': defaultType,
    };
  }

  // Convert a Map object into a Category object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['category_id'],
      userId: map['user_id'],
      categoryName: map['category_name'],
      defaultType: map['default_type'] ?? 1,
    );
  }

  // Override the toString method to print the content of the object
  @override
  String toString() {
    return 'Category(id: $categoryId, userId: $userId, name: $categoryName, defaultType: $defaultType)';
  }
}
