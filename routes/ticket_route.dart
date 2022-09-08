import 'dart:convert';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../database/database_helper.dart';
import '../model/final_model.dart';
import '../model/ticket_model.dart';

class TicketRoute {
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
            .getTickets(userdate[0]['id'].toString())
            .then((value) => listMysql.addAll(value));
        var response = {
          "message": "success",
          "data": TicketModel().toJson(listMysql)
        };
        return Response.ok(json.encode(response),
            headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.forbidden('Authorization rejected $e');
      }
    });

    router.post("/", (Request request) async {
      final payload = await request.readAsString();
      Map list = json.decode(payload);
      String sharedSecret = "0c4Ib9U";
      try {
        String token =
            request.headers['Authorization']!.replaceAll('Bearer ', '');
        final decClaimSet = verifyJwtHS256Signature(token, sharedSecret);
        List userdate = [];
        await DatabaseHelper()
            .getUserData(decClaimSet.subject.toString())
            .then((value) => userdate.addAll(value));
        if (list.containsKey('subject') && list.containsKey('body')) {
          print(list['subject']);
          await DatabaseHelper()
              .addTickets(userdate[0]['id'], list['subject'], list['body']);
          var response = {
            "message": "success",
          };
          return Response.ok(json.encode(response),
              headers: {'Content-Type': 'application/json'});
        } else {
          var response = {
            "message": "data required missied",
          };
          return Response.forbidden(json.encode(response),
              headers: {'Content-Type': 'application/json'});
        }
      } catch (e) {
        var response = {
          "message": "error in inserting $e",
        };
        return Response.forbidden(json.encode(response),
            headers: {'Content-Type': 'application/json'});
      }
    });
    return router;
  }
}
