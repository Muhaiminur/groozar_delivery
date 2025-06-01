class UserResponseDataUser {
/*
{
  "id": 12,
  "first_name": "himel1",
  "last_name": null,
  "username": "nuruzzamanhimel",
  "email": "nuruzzaman.himel147@gmail.com",
  "phone": "01622849959",
  "gender": null,
  "email_verified_at": "2025-05-15T07:30:08.000000Z",
  "type": "Customer",
  "status": "active",
  "avatar": null,
  "created_by": null,
  "updated_by": null,
  "created_at": "2025-05-15T06:16:33.000000Z",
  "updated_at": "2025-05-15T07:30:08.000000Z",
  "deleted_at": null,
  "avatar_url": "https://grozaar.heizoelscout.com/images/default/user_default.png",
  "full_name": "himel1 ",
  "is_email_verified": "1",
  "supplier_name": "",
  "status_badge": "<span class=\"badge bg-success\">ACTIVE</span>"
}
*/

  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phone;
  String? gender;
  String? emailVerifiedAt;
  String? type;
  String? status;
  String? avatar;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? avatarUrl;
  String? fullName;
  String? isEmailVerified;
  String? supplierName;
  String? statusBadge;

  UserResponseDataUser({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.gender,
    this.emailVerifiedAt,
    this.type,
    this.status,
    this.avatar,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.avatarUrl,
    this.fullName,
    this.isEmailVerified,
    this.supplierName,
    this.statusBadge,
  });
  UserResponseDataUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    username = json['username']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    emailVerifiedAt = json['email_verified_at']?.toString();
    type = json['type']?.toString();
    status = json['status']?.toString();
    avatar = json['avatar']?.toString();
    createdBy = json['created_by']?.toString();
    updatedBy = json['updated_by']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    avatarUrl = json['avatar_url']?.toString();
    fullName = json['full_name']?.toString();
    isEmailVerified = json['is_email_verified']?.toString();
    supplierName = json['supplier_name']?.toString();
    statusBadge = json['status_badge']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['email_verified_at'] = emailVerifiedAt;
    data['type'] = type;
    data['status'] = status;
    data['avatar'] = avatar;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['avatar_url'] = avatarUrl;
    data['full_name'] = fullName;
    data['is_email_verified'] = isEmailVerified;
    data['supplier_name'] = supplierName;
    data['status_badge'] = statusBadge;
    return data;
  }
}

class UserResponseData {
/*
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOWQwYTI3N2MxNTZlMWVmZDNiZDJkOWU4ZGExNWMxYjFhNzA5OTZhYTYxMWZjODY5NTU1YWYzMzcwYTU3MGE5MDg0MTZmMmNiNzQ3MWE4ZWUiLCJpYXQiOjE3NDc1NDczMzEuMDMyMDA2OTc4OTg4NjQ3NDYwOTM3NSwibmJmIjoxNzQ3NTQ3MzMxLjAzMjAxMDA3ODQzMDE3NTc4MTI1LCJleHAiOjE3NzkwODMzMzEuMDI1MzE1MDQ2MzEwNDI0ODA0Njg3NSwic3ViIjoiMTIiLCJzY29wZXMiOltdfQ.Ousq1hvwYuJhz_jzTYGxviBwSsl0bsrXACBveH5ya5DMkVL31Nk66TxC0lM-X5epCiZrVc_PElPSAG8DgLTTWfbdBGVtTCLTRSqd-Fr8NoLg9W941fOKHgIRnKxwwSRWUAJHTe9VlubSxl1QWACm1WYuwzbPYVwxQL3ZOcT2gvzuFxckX6X3fxV-lCBA8aeopLTmD4ENgHkaCjRcegx1Eh4VhW1U_EOLlbgUOBt4eHEHcbbqOqjqoWxkUZYsV7z5FE6d5rqpMmps2ZQw4KkIQTGMh4qshq7j8CUrPu8RHiydoD8p7LuRK0riPL-PY0kImrgpEBUDTHUbKqCFWsIGBp7WXMgZQiwQ6KxM224Ye8Xzgi7LYMYNsIdN2RYfc6wpeLyx4AxaZR30I6eEpOl9jKntoR_PEZQyFAnnNNstEqiiItJzVo64gh3cCbMVmNQO4UjchCxxJZ2xfokJwq5yJZgs8FjxvumRC7HHF_4G-cJu5h0_yuGdtE6IKPMHaM74eJmxryS8GkB7ohU23GM5r9FxB1ApNRqd-d-Sue1hlAUNtUhfHx6cBthZpt58-Hb4EYEdqy-NwHhOHRyh6DtvKnUPT410B1HabYV8BSHmRhFVGtTRR0Ub_EQAlGvJVU3BtCqu6a-Ez0Ky2HadAf4NcYaPOVKCJMNMlKMU2KLbc1M",
  "refresh_token": "9d0a277c156e1efd3bd2d9e8da15c1b1a70996aa611fc869555af3370a570a908416f2cb7471a8ee",
  "token_type": "Bearer",
  "user": {
    "id": 12,
    "first_name": "himel1",
    "last_name": null,
    "username": "nuruzzamanhimel",
    "email": "nuruzzaman.himel147@gmail.com",
    "phone": "01622849959",
    "gender": null,
    "email_verified_at": "2025-05-15T07:30:08.000000Z",
    "type": "Customer",
    "status": "active",
    "avatar": null,
    "created_by": null,
    "updated_by": null,
    "created_at": "2025-05-15T06:16:33.000000Z",
    "updated_at": "2025-05-15T07:30:08.000000Z",
    "deleted_at": null,
    "avatar_url": "https://grozaar.heizoelscout.com/images/default/user_default.png",
    "full_name": "himel1 ",
    "is_email_verified": "1",
    "supplier_name": "",
    "status_badge": "<span class=\"badge bg-success\">ACTIVE</span>"
  }
}
*/

  String? token;
  String? refreshToken;
  String? tokenType;
  UserResponseDataUser? user;

  UserResponseData({
    this.token,
    this.refreshToken,
    this.tokenType,
    this.user,
  });
  UserResponseData.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
    refreshToken = json['refresh_token']?.toString();
    tokenType = json['token_type']?.toString();
    user = (json['user'] != null && (json['user'] is Map)) ? UserResponseDataUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserResponse {
/*
{
  "success": true,
  "data": {
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOWQwYTI3N2MxNTZlMWVmZDNiZDJkOWU4ZGExNWMxYjFhNzA5OTZhYTYxMWZjODY5NTU1YWYzMzcwYTU3MGE5MDg0MTZmMmNiNzQ3MWE4ZWUiLCJpYXQiOjE3NDc1NDczMzEuMDMyMDA2OTc4OTg4NjQ3NDYwOTM3NSwibmJmIjoxNzQ3NTQ3MzMxLjAzMjAxMDA3ODQzMDE3NTc4MTI1LCJleHAiOjE3NzkwODMzMzEuMDI1MzE1MDQ2MzEwNDI0ODA0Njg3NSwic3ViIjoiMTIiLCJzY29wZXMiOltdfQ.Ousq1hvwYuJhz_jzTYGxviBwSsl0bsrXACBveH5ya5DMkVL31Nk66TxC0lM-X5epCiZrVc_PElPSAG8DgLTTWfbdBGVtTCLTRSqd-Fr8NoLg9W941fOKHgIRnKxwwSRWUAJHTe9VlubSxl1QWACm1WYuwzbPYVwxQL3ZOcT2gvzuFxckX6X3fxV-lCBA8aeopLTmD4ENgHkaCjRcegx1Eh4VhW1U_EOLlbgUOBt4eHEHcbbqOqjqoWxkUZYsV7z5FE6d5rqpMmps2ZQw4KkIQTGMh4qshq7j8CUrPu8RHiydoD8p7LuRK0riPL-PY0kImrgpEBUDTHUbKqCFWsIGBp7WXMgZQiwQ6KxM224Ye8Xzgi7LYMYNsIdN2RYfc6wpeLyx4AxaZR30I6eEpOl9jKntoR_PEZQyFAnnNNstEqiiItJzVo64gh3cCbMVmNQO4UjchCxxJZ2xfokJwq5yJZgs8FjxvumRC7HHF_4G-cJu5h0_yuGdtE6IKPMHaM74eJmxryS8GkB7ohU23GM5r9FxB1ApNRqd-d-Sue1hlAUNtUhfHx6cBthZpt58-Hb4EYEdqy-NwHhOHRyh6DtvKnUPT410B1HabYV8BSHmRhFVGtTRR0Ub_EQAlGvJVU3BtCqu6a-Ez0Ky2HadAf4NcYaPOVKCJMNMlKMU2KLbc1M",
    "refresh_token": "9d0a277c156e1efd3bd2d9e8da15c1b1a70996aa611fc869555af3370a570a908416f2cb7471a8ee",
    "token_type": "Bearer",
    "user": {
      "id": 12,
      "first_name": "himel1",
      "last_name": null,
      "username": "nuruzzamanhimel",
      "email": "nuruzzaman.himel147@gmail.com",
      "phone": "01622849959",
      "gender": null,
      "email_verified_at": "2025-05-15T07:30:08.000000Z",
      "type": "Customer",
      "status": "active",
      "avatar": null,
      "created_by": null,
      "updated_by": null,
      "created_at": "2025-05-15T06:16:33.000000Z",
      "updated_at": "2025-05-15T07:30:08.000000Z",
      "deleted_at": null,
      "avatar_url": "https://grozaar.heizoelscout.com/images/default/user_default.png",
      "full_name": "himel1 ",
      "is_email_verified": "1",
      "supplier_name": "",
      "status_badge": "<span class=\"badge bg-success\">ACTIVE</span>"
    }
  },
  "message": "User login successfully."
}
*/

  bool? success;
  UserResponseData? data;
  String? message;

  UserResponse({
    this.success,
    this.data,
    this.message,
  });
  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] != null && (json['data'] is Map)) ? UserResponseData.fromJson(json['data']) : null;
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}
