import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class FaqRoute {
  Router get router {
    final router = Router();
    router.get('/', (Request request) async {
      var response = {
        "code": "success",
        "data": [
          {
            "question": "<h4>Q1 : How many countries Orange Digital center is in ?</h4>",
            "answer": "<h4>16 Country</h4>"
          }
        ]
      };
      return Response.ok(json.encode(response),
          headers: {'Content-Type': 'application/json'});
    });
    return router;
  }
}
