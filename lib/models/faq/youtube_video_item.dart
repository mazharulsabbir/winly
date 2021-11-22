class YoutubeVideoItem {
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Statistics? statistics;

  YoutubeVideoItem({this.snippet, this.contentDetails, this.statistics});

  YoutubeVideoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    snippet = json['snippet'] != null
        ? Snippet.fromJson(
            json['snippet'],
          )
        : null;
    contentDetails = json['contentDetails'] != null
        ? ContentDetails.fromJson(json['contentDetails'])
        : null;
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  @override
  String toString() {
    return 'YoutubeVideoItem{id: $id, snippet: $snippet, contentDetails: $contentDetails, statistics: $statistics}';
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'])
        : null;
  }

  @override
  String toString() {
    return 'Snippet{publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, thumbnails: $thumbnails}';
  }
}

class Thumbnails {
  Thumbnail? default_;
  Thumbnail? medium;
  Thumbnail? high;
  Thumbnail? standard;
  Thumbnail? maxres;

  Thumbnails({this.medium, this.high, this.standard, this.maxres});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    default_ =
        json['default'] != null ? Thumbnail.fromJson(json['default']) : null;
    medium = json['medium'] != null ? Thumbnail.fromJson(json['medium']) : null;
    high = json['high'] != null ? Thumbnail.fromJson(json['high']) : null;
    standard =
        json['standard'] != null ? Thumbnail.fromJson(json['standard']) : null;
    maxres = json['maxres'] != null ? Thumbnail.fromJson(json['maxres']) : null;
  }

  @override
  String toString() {
    return 'Thumbnails{default_: $default_, medium: $medium, high: $high, standard: $standard, maxres: $maxres}';
  }
}

class Thumbnail {
  String? url;
  int? width;
  int? height;

  Thumbnail({this.url, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  @override
  String toString() {
    return 'Thumbnail{url: $url, width: $width, height: $height}';
  }
}

class ContentDetails {
  String? duration;
  String? dimension;
  String? definition;
  String? caption;
  bool? licensedContent;
  String? projection;

  ContentDetails(
      {this.duration,
      this.dimension,
      this.definition,
      this.caption,
      this.licensedContent,
      this.projection});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    dimension = json['dimension'];
    definition = json['definition'];
    caption = json['caption'];
    licensedContent = json['licensedContent'];
    projection = json['projection'];
  }

  @override
  String toString() {
    return 'ContentDetails{duration: $duration, dimension: $dimension, definition: $definition, caption: $caption, licensedContent: $licensedContent, projection: $projection}';
  }
}

class Statistics {
  String? viewCount;
  String? likeCount;
  String? dislikeCount;
  String? favoriteCount;
  String? commentCount;

  Statistics(
      {this.viewCount,
      this.likeCount,
      this.dislikeCount,
      this.favoriteCount,
      this.commentCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
    favoriteCount = json['favoriteCount'];
    commentCount = json['commentCount'];
  }

  @override
  String toString() {
    return 'Statistics{viewCount: $viewCount, likeCount: $likeCount, dislikeCount: $dislikeCount, favoriteCount: $favoriteCount, commentCount: $commentCount}';
  }
}
