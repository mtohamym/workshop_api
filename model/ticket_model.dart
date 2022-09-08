class TicketModel {
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
        "userid": dataMysql[i]['userid'],
        "subject": dataMysql[i]['subject'].toString(),
        "body": dataMysql[i]['body'].toString(),
      };
      response.add(json);
    }
    return response;
  }
}
