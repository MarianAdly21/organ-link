class UserHomeDateSendModel {
  final int id;

  UserHomeDateSendModel({required this.id});

  Map<String, dynamic> toMap(){
    return {
      "id":id,  //// هتتغير علي اساس الباك 
    };

  }
}