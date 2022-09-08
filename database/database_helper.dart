import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  var settings = new ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '123456',
      db: 'workshop_flutter');

  Future<void> register(
      String email,
      String password,
      String gender,
      String phoneNumber,
      int universityId,
      int grade,
      String role,
      String name) async {
    print(562321);
    var conn = await MySqlConnection.connect(settings);

    try {
      var results =
          await conn.query("""INSERT INTO `user` (`email`,`password`, `gender`, 
         `phoneNumber`, `universityId`, `grade`, `role`, `name`) 
    VALUES ('$email', '$password', '$gender', 
    '$phoneNumber', $universityId, $grade, '$role', '$name')""");
    } catch (ex) {
      conn.close();
      print('1214545');
      throw new Exception("not registerd");
    } finally {
      conn.close();
    }
  }

  Future<bool> login(
    String email,
    String password,
  ) async {
    var conn = await MySqlConnection.connect(settings);
    var list = [];
    var results = await conn.query("SELECT * FROM user WHERE email='$email'");
    list.addAll(results);
    print(list);
    conn.close();
    if (results != null &&
        email == list[0]['email'] &&
        password == list[0]['password']) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getNews() async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('SELECT * FROM `news`');
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getUserData(String email) async {
    var conn = await MySqlConnection.connect(settings);
    var results =
        await conn.query("""SELECT * FROM `user` WHERE email='$email' """);
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getLectures(String grade, String universityId) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        """SELECT * FROM `lectures` INNER JOIN subject ON lectures.subjectId=subject.id 
        WHERE lectures.universityId=$universityId AND lectures.grade=$grade""");
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getSections(String grade, String universityId) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        """SELECT * FROM `sections` INNER JOIN subject ON sections.subjectId=subject.id 
        WHERE sections.universityId=$universityId AND sections.grade=$grade""");
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getFinals(String grade, String universityId) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        """SELECT * FROM `finals` INNER JOIN subject ON finals.subjectId=subject.id 
        WHERE finals.universityId=$universityId AND finals.grade=$grade""");
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getMidterms(String grade, String universityId) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        """SELECT * FROM `midterms` INNER JOIN subject ON midterms.subjectId=subject.id 
        WHERE midterms.universityId=$universityId AND midterms.grade=$grade""");
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> getTickets(String userId) async {
    var conn = await MySqlConnection.connect(settings);
    var results =
        await conn.query("""SELECT * FROM `ticket` WHERE userid=$userId """);
    var list = results.toList();
    conn.close();
    return list;
  }

  Future<List> addTickets(int userId, String subject, String body) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        """INSERT INTO `ticket`(`userid`, `subject`, `body`) VALUES ($userId,'$subject','$body')""");
    var list = results.toList();
    conn.close();
    return list;
  }
}
