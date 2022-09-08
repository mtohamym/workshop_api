class MidtermModel{
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
        "subjectName": dataMysql[i]['name'],
        "midtermStartTime": dataMysql[i]['startTime'],
        "midtermEndTime": dataMysql[i]['endTime'],
        "midtermDay": dataMysql[i]['day'],
      };
      response.add(json);
    }
    return response;
  }
}
