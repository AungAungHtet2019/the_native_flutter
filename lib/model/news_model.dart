class WpContent {
  WpContent({
    required this.id,
    required this.date,
    required this.guid,
    required this.modified,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.embedded,
  });
  late final int id;
  late final String date;
  late final Guid guid;
  late final String modified;
  late final String link;
  late final Title title;
  late final Content content;
  late final Excerpt excerpt;
  late final Embedded embedded;

  WpContent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    guid = Guid.fromJson(json['guid']);
    modified = json['modified'];
    link = json['link'];
    title = Title.fromJson(json['title']);
    content = Content.fromJson(json['content']);
    excerpt = Excerpt.fromJson(json['excerpt']);
    embedded = Embedded.fromJson(json['_embedded']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['guid'] = guid.toJson();
    _data['modified'] = modified;
    _data['link'] = link;
    _data['title'] = title.toJson();
    _data['content'] = content.toJson();
    _data['excerpt'] = excerpt.toJson();
    _data['_embedded'] = embedded.toJson();
    return _data;
  }
}

class Guid {
  Guid({
    required this.rendered,
  });
  late final String rendered;

  Guid.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    return _data;
  }
}

class Title {
  Title({
    required this.rendered,
  });
  late final String rendered;

  Title.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    return _data;
  }
}

class Content {
  Content({
    required this.rendered,
    required this.protected,
  });
  late final String rendered;
  late final bool protected;

  Content.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    _data['protected'] = protected;
    return _data;
  }
}

class Excerpt {
  Excerpt({
    required this.rendered,
    required this.protected,
  });
  late final String rendered;
  late final bool protected;

  Excerpt.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    _data['protected'] = protected;
    return _data;
  }
}

class Embedded {
  Embedded({
    required this.featuredmedia,
  });
  late final List<Featuredmedia> featuredmedia;

  Embedded.fromJson(Map<String, dynamic> json){
    featuredmedia = List.from(json['wp:featuredmedia']).map((e)=>Featuredmedia.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wp:featuredmedia'] = featuredmedia.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Featuredmedia {
Featuredmedia({
  required this.sourceUrl,
});
late final String sourceUrl;

Featuredmedia.fromJson(Map<String, dynamic> json){
sourceUrl = json['source_url'];
}

Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['source_url'] = sourceUrl;
  return _data;
}
}


