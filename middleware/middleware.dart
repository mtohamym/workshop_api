import 'dart:async';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';

import '../database/database_helper.dart';

abstract class AuthProvider {
  static JsonDecoder _decoder = const JsonDecoder();

  static FutureOr<Response?> handle(Request request) async {
    if (request.url.toString() == 'login') {
      return AuthProvider.auth(request);
    } else if (request.url.toString() == 'register') {
      return AuthProvider.register(request);
    } else {
      return AuthProvider.verify(request);
    }
  }

  static FutureOr<Response> auth(Request request) async {
    final payload = await request.readAsString();
    var list = json.decode(payload);
    bool isLog = false;
    await DatabaseHelper()
        .login(list['email'], list['password'])
        .then((value) => isLog = value);
    if (isLog == true) {
      print("here");
      String sharedSecret = "0c4Ib9U";
      final claimSet = JwtClaim(
        issuer: 'odco',
        subject: list['email'],
        jwtId: "0c4Ib9UXZahVzmrxJaNexoIXirRyyQOB",
        otherClaims: <String, dynamic>{
          'typ': 'authnresponse',
          'pld': {'k': 'v'}
        },
        maxAge: const Duration(days: 1),
      );
      final token = issueJwtHS256(claimSet, sharedSecret);
      var response = {"Access Token": token};
      return Response.ok(json.encode(response),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.forbidden("Login Error password or email incorrect",
          headers: {'Content-Type': 'application/json'});
    }
  }

  static Future<Response?> verify(Request request) async {
    String sharedSecret = "0c4Ib9U";
    try {
      String token =
          request.headers['Authorization']!.replaceAll('Bearer ', '');
      final decClaimSet = verifyJwtHS256Signature(token, sharedSecret);
      print('Subject: "${decClaimSet.subject}"');
      return null;
    } catch (e) {
      return Response.forbidden('Authorization rejected',
          headers: {'Content-Type': 'application/json'});
    }
  }

  static FutureOr<Response?> register(Request request) async {
    final payload = await request.readAsString();
    Map list = json.decode(payload);
    if (list.containsKey('email') &&
        list.containsKey('password') &&
        list.containsKey('gender') &&
        list.containsKey('phoneNumber') &&
        list.containsKey('universityId') &&
        list.containsKey('grade') &&
        list.containsKey('role') &&
        list.containsKey('name')) {
      try {
        await DatabaseHelper().register(
          list['email'],
          list['password'],
          list['gender'],
          list['phoneNumber'],
          list['universityId'],
          list['grade'],
          list['role'],
          list['name'],
        );
        String sharedSecret = "0c4Ib9U";
        final claimSet = JwtClaim(
          issuer: 'odco',
          subject: list['email'],
          jwtId: "0c4Ib9UXZahVzmrxJaNexoIXirRyyQOB",
          otherClaims: <String, dynamic>{
            'typ': 'authnresponse',
            'pld': {'k': 'v'}
          },
          maxAge: const Duration(days: 1),
        );
        final token = issueJwtHS256(claimSet, sharedSecret);
        var response = {"Access Token": token};
        return Response.ok(response,
            headers: {'Content-Type': 'application/json'});
      } catch (ex) {
        return Response.forbidden("$ex",
            headers: {'Content-Type': 'application/json'});
      }
    } else {
      return Response.forbidden(
          "Please enter all data {emial , password, gender .... etc",
          headers: {'Content-Type': 'application/json'});
    }
  }
}
