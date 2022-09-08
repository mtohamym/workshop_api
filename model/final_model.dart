class FinlalModel{
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
        //  "subjectId": dataMysql[i]['subjectId'],
        "subjectName": dataMysql[i]['name'],
        "finalStartTime": dataMysql[i]['startTime'],
        "finalEndTime": dataMysql[i]['endTime'],
        "finalDay": dataMysql[i]['day'],
      };
      response.add(json);
    }
    return response;
  }
}
