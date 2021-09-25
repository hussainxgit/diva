class Settings {
  String id;
  String appName;
  String appDesc;
  String appLogo;

  Settings({this.id, this.appName, this.appDesc, this.appLogo});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['appName'];
    appDesc = json['appDesc'];
    appLogo = json['appLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appName'] = appName;
    data['appDesc'] = appDesc;
    data['appLogo'] = appLogo;
    return data;
  }
}
