import 'package:flutter_lh_deer/generated/json/user_entity_helper.dart';
import 'package:flutter_lh_deer/shop/models/user_entity.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
      case UserEntity:
        return userEntityFromJson(data as UserEntity, json) as T;
      default:
    }
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {
      case UserEntity:
        return userEntityToJson(data as UserEntity);
    }
    return data as T;
  }
}
