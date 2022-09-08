class LectureModel {
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
      //  "subjectId": dataMysql[i]['subjectId'],
        "subjectName": dataMysql[i]['name'],
        "lectureStartTime": dataMysql[i]['startTime'],
        "lectureEndTime": dataMysql[i]['endTime'],
        "lectureDay": dataMysql[i]['day'],
      };
      response.add(json);
    }
    return response;
  }
}
