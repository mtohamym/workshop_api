import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import '../middleware/middleware.dart';
import '../routes/faq_route.dart';
import '../routes/final_route.dart';
import '../routes/lecture_route.dart';
import '../routes/midterm_route.dart';
import '../routes/news_route.dart';
import '../routes/section_route.dart';
import '../routes/terms_route.dart';
import '../routes/ticket_route.dart';

const _hostname = 'localhost';

void main(List<String> args) async {
  var port = 8080;
  if (port == null) {
    stdout.writeln('Could not parse port value "8080" into a number.');
    exitCode = 64;
    return;
  }
  final app = Router();
  app.post("/login", (Request request) {
    return Response.ok("done");
  });

  app.post("/register", (Request request) {
    return Response.ok("done");
  });

  app.mount('/news', NewsRoute().router);
  app.mount('/lectures', LecturesRoute().router);
  app.mount('/sections', SectionsRoute().router);
  app.mount('/finals', FinalRoute().router);
  app.mount('/midterms', MidtermsRoute().router);
  app.mount('/ticket', TicketRoute().router);
  app.mount('/events', TicketRoute().router);
  app.mount('/terms', TermsRoute().router);
  app.mount('/faq', FaqRoute().router);



  Middleware auth = createMiddleware(requestHandler: AuthProvider.handle);
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(auth)
      .addHandler(app);
  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) =>
    shelf.Response.ok('Request for "${request.url}"');
