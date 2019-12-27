class Album{
  int albumId,id;
  String title,url,thumbNailUrl;
  Album(this.albumId,this.id,this.title,this.url,this.thumbNailUrl);
  factory Album.fromJson(Map<String,dynamic> json){
    return Album(
      json['albumId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['url'] as String,
      json['thumbNailUrl'] as String,
    );
  }
}