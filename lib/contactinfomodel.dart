class ContactinfoModel {
    ContactinfoModel({
        this.id,
        this.name,
        this.userId,
        this.email,
        this.gender,
        this.createdAt,
    });

    int id;
    String name;
    int userId;
    String email;
    String gender;
    String createdAt;

    factory ContactinfoModel.fromJson(Map<String, dynamic> json) => ContactinfoModel(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        email: json["email"],
        gender: json["gender"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "email": email,
        "gender": gender,
        "created_at": createdAt,
    };
}