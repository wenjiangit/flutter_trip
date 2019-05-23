class TravelTabModel{

  String url;
  Map params;
  List<TravelTab> tabs;

  TravelTabModel({this.url, this.params, this.tabs});


  TravelTabModel.fromJson(Map<String,dynamic> jsonStr){
    url = jsonStr['url'];
    params = jsonStr['params'];
    var tabsJson = jsonStr['tabs'] as List;
    tabs = tabsJson.map((e)=>TravelTab.fromJson(e)).toList();
  }

}


class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}


