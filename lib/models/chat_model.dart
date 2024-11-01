import 'package:untitled/models/user_model.dart';

class model_chat {
String id  ;
List <user_model>users = [] ;
List users_id = [] ;
List  <String > chat = [] ;
model_chat({required this.chat , required this.id , required this.users , required this.users_id}) ;

model_chat.from_json(map): this(
  id: map ['id'] ,
  users: map['users'].map<user_model>((e) => user_model.from_json(e)).toList() ,
  chat : map['chat'] ,
  users_id : map ['users_id']
);
  to_json() {
    return {
      'id' : id ,
      'users' : users.map((e) => e.to_json()).toList() ,
      'chat' : chat ,
      'users_id' : users_id
} ;
}

}