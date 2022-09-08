import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../database/database_helper.dart';
import '../model/news_model.dart';

class NewsRoute {
  Router get router {
    final router = Router();
    router.get('/', (Request request) async {
      List listMysql = [];
      await DatabaseHelper().getNews().then((value) => listMysql.addAll(value));
      return Response.ok(json.encode(NewsModel().toJson(listMysql)),
          headers: {'Content-Type': 'application/json'});
    });
   return router;
  }
}