// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.success,
        this.id,
        this.qrId,
    });

    bool success;
    String id;
    String qrId;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        id: json["id"],
        qrId: json["qr_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "id": id,
        "qr_id": qrId,
    };
}
