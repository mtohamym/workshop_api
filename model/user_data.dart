class UserModel {
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "email": dataMysql[i]['email'],
        "name": dataMysql[i]['name'],
        "gender": dataMysql[i]['gender'].toString(),
        "phoneNumber": dataMysql[i]['phoneNumber'],
        "universityId": dataMysql[i]['universityId'].toString(),
        "grade": dataMysql[i]['grade'].toString(),
        "id": dataMysql[i]['id'].toString(),
      };
      response.add(json);
    }
    return response;
  }
}
