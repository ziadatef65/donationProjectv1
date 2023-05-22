class EventModel
{
  String? nameOfEvent;
  String?  imageOfEvent;
  String?  details;
  int? target;
  int? fixedTarget;
  dynamic? percentage;





  EventModel({
    this.nameOfEvent,
    this.imageOfEvent,
    this.details,
    this.target,
    this.percentage,
    this.fixedTarget,


  });


  EventModel.fromJson(Map<dynamic,dynamic> json)
  {

    nameOfEvent = json['nameOfEvent'];
    imageOfEvent= json['imageOfEvent'];
    details= json['details'];
    target= json['target'];
    percentage= json['percentage'];
    fixedTarget= json['fixedTarget'];



  }

  Map<String,dynamic> toMap()
  {
    return{
      'nameOfEvent':nameOfEvent,
      'imageOfEvent':imageOfEvent,
      'details':details,
      'target':target,
      'percentage':percentage,
      'fixedTarget':fixedTarget,



    };
  }


}