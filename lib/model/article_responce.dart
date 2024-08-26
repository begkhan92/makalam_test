class ArticleResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Article> results;

  ArticleResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List).map((i) => Article.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((i) => i.toJson()).toList(),
    };
  }
}

class Article {
  final int id;
  final String slug;
  final String url;
  final Author author;
  final String title;
  final String banner;
  final String content;

  Article({
    required this.id,
    required this.slug,
    required this.url,
    required this.author,
    required this.title,
    required this.banner,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      slug: json['slug'],
      url: json['url'],
      author: Author.fromJson(json['author']),
      title: json['title'],
      banner: json['banner'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'url': url,
      'author': author.toJson(),
      'title': title,
      'banner': banner,
      'content': content,
    };
  }
}

class Author {
  final String username;
  final String avatar;
  final String firstName;
  final String lastName;

  Author({
    required this.username,
    required this.avatar,
    required this.firstName,
    required this.lastName,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'],
      avatar: json['avatar'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'avatar': avatar,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
