import 'dart:convert';
import 'package:http/http.dart' as http;
import 'album.dart';

class Services{
  static const String url = 'https://jsonplaceholder.typicode.com/photos';

  static Future<List<Album>> getPhotos() async{
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        List<Album> list = parsePhotos(response.body);
        
              }
            }catch(e){
              throw Exception(e.toString());
            }
          }
        
          static List<Album> parsePhotos(String body) {
            final parsed = json.decode(body).cast<Map<String, dynamic>>();
            return parsed.map<Album>((json)=>Album.fromJson(json)).toList();
          }
}

