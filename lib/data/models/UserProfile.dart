class UserProfile {
  String fullName;
  String email;
  String age;
  String gender;
  String clubA;
  String clubB;
  String clubC;
  String pasteUrl;
  String buddy;
  String coach;

  UserProfile({this.fullName, this.email,this.age, this.gender,this.clubA,this.clubB,this.clubC,this.pasteUrl,this.buddy,this.coach});

  Map toMap(UserProfile userProfile) {
    var data = Map<String, dynamic>();

    data["fullName"] = userProfile.fullName;
    data["email"] = userProfile.email;
    data["age"] = userProfile.age;
    data["gender"] = userProfile.gender;
    data["clubA"] = userProfile.clubA;
    data["clubB"] = userProfile.clubB;
    data["clubC"] = userProfile.clubC;
    data["pasteUrl"] = userProfile.pasteUrl;
    data["buddy"] = userProfile.buddy;
    data["coach"] = userProfile.coach;

    return data;
  }

  UserProfile.fromMap(Map<String, dynamic> mapData) {
    this.fullName = mapData["fullName"];
    this.email = mapData["email"];
    this.age = mapData["age"];
    this.gender = mapData['gender'];
    this.clubA = mapData['clubA'];
    this.clubB = mapData['clubB'];
    this.clubC = mapData['clubC'];
    this.pasteUrl = mapData['pasteUrl'];
    this.coach = mapData['coach'];
    this.buddy = mapData['buddy'];
  }

}