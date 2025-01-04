abstract class BaseModel<T> {
  Map<String, Object?> toJson();
  fromJson(Map<String, dynamic> json);
}
