class SectionModel{
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
        //  "subjectId": dataMysql[i]['subjectId'],
        "subjectName": dataMysql[i]['name'],
        "sectionStartTime": dataMysql[i]['startTime'],
        "sectionEndTime": dataMysql[i]['endTime'],
        "sectionDay": dataMysql[i]['day'],
      };
      response.add(json);
    }
    return response;
  }
}
