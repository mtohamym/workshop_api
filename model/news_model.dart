class NewsModel {
  List toJson(List dataMysql) {
    List response = [];
    for (int i = 0; i < dataMysql.length; i++) {
      var json = {
        "id": dataMysql[i]['id'],
        "title": dataMysql[i]['title'],
        "body": dataMysql[i]['body'].toString(),
        "date": dataMysql[i]['date'],
        "linkUrl": dataMysql[i]['linkUrl'].toString(),
        "imageUrl": dataMysql[i]['imageUrl'].toString(),
      };
      response.add(json);
    }
    return response;
  }
}
