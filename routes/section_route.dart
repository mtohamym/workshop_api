import 'dart:convert';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../database/database_helper.dart';
import '../model/section_model.dart';

class SectionsRoute {
  Router get router {
    final router = Router();
    router.get('/', (Request request) async {
      String sharedSecret = "0c4Ib9U";
      try {
        String token =
            request.headers['Authorization']!.replaceAll('Bearer ', '');
        final decClaimSet = verifyJwtHS256Signature(token, sharedSecret);
        List userdate = [];
        await DatabaseHelper()
            .getUserData(decClaimSet.subject.toString())
            .then((value) => userdate.addAll(value));
        List listMysql = [];
        await DatabaseHelper()
            .getSections(userdate[0]['grade'].toString(),
                userdate[0]['universityId'].toString())
            .then((value) => listMysql.addAll(value));
        var response = {
          "message": "success",
          "data": SectionModel().toJson(listMysql)
        };
        return Response.ok(json.encode(response),
            headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.forbidden('Authorization rejected $e');
      }
    });
    return router;
  }
}
