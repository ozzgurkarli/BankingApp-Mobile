import 'package:parbank/dto/CallerInformation.dart';
import 'package:parbank/dto/DTOLogin.dart';

class MessageContainer {
  CallerInformation callerInformation = CallerInformation();
  Map<String, dynamic> contents = {};

  MessageContainer();
  MessageContainer.builder(this.contents);

  void Add(String key, dynamic content) {
    contents[key] = content;
  }

  void Clear() {
    contents = {};
  }

  T? Get<T>() {
    for (var content in contents.values) {
      if (content is T) {
        return content;
      }
    }
    return null;
  }

  T? GetWithKey<T>(String key) {
    T? content = contents[key];

    if (content is Map) {
      switch (key.split('.').last) {
        case 'DTOLogin':
          return DTOLogin.fromJson(content) as T?;
      }
    }
    
    return contents[key] as T?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {};
    Map<String, dynamic> finalList = {};
    
    for (var item in contents.entries) {
      if(item.value is List){
        for (var i = 0; i < item.value.length; i++) {
          try{
            item.value[i] = item.value[i].toJson();
          }
          catch(e){}
        }
        temp[item.key] = item.value;
      }
      else{
        temp[item.key] = item.value.toJson();
      }
    }

    finalList["contents"] = temp;

    return finalList;
  }

  static MessageContainer fromJson(Map<String, dynamic> json) {
    MessageContainer container = MessageContainer();
    container.contents = json;
    return container;
  }
}
