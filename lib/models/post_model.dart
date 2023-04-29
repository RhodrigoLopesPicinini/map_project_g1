
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String value;

  PostModel ({
    required this.value

  });

  factory PostModel.fromJson(Map<String,dynamic> json) => _$PostModelFromJson(json);
  Map<String,dynamic> toJson() => _$PostModelToJson(this);
}