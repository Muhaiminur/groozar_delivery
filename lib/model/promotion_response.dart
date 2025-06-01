class PromotionResponseDataLinks {
  /*
{
  "first": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
  "last": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
  "prev": null,
  "next": null
}
*/

  String? first;
  String? last;
  String? prev;
  String? next;

  PromotionResponseDataLinks({this.first, this.last, this.prev, this.next});

  PromotionResponseDataLinks.fromJson(Map<String, dynamic> json) {
    first = json['first']?.toString();
    last = json['last']?.toString();
    prev = json['prev']?.toString();
    next = json['next']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class PromotionResponseDataMeta {
  /*
{
  "current_page": 1,
  "from": 1,
  "last_page": 1,
  "per_page": 20,
  "to": 2,
  "total": 2
}
*/

  String? currentPage;
  String? from;
  String? lastPage;
  String? perPage;
  String? to;
  String? total;

  PromotionResponseDataMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  PromotionResponseDataMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toString();
    from = json['from']?.toString();
    lastPage = json['last_page']?.toString();
    perPage = json['per_page']?.toString();
    to = json['to']?.toString();
    total = json['total']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class PromotionResponseDataData {
  /*
{
  "id": 4,
  "title": "20 taka discount",
  "image_url": "https://inventory.grozaarbd.com//storage/promotions/1748322398_1851898258_1.png",
  "description": "<p>20 taka discount for all products</p>",
  "end_date": "May 31, 2025"
}
*/

  String? id;
  String? title;
  String? imageUrl;
  String? description;
  String? endDate;

  PromotionResponseDataData({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.endDate,
  });

  PromotionResponseDataData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    imageUrl = json['image_url']?.toString();
    description = json['description']?.toString();
    endDate = json['end_date']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['end_date'] = endDate;
    return data;
  }
}

class PromotionResponseData {
  /*
{
  "data": [
    {
      "id": 4,
      "title": "20 taka discount",
      "image_url": "https://inventory.grozaarbd.com//storage/promotions/1748322398_1851898258_1.png",
      "description": "<p>20 taka discount for all products</p>",
      "end_date": "May 31, 2025"
    }
  ],
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 1,
    "per_page": 20,
    "to": 2,
    "total": 2
  },
  "links": {
    "first": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
    "last": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
    "prev": null,
    "next": null
  }
}
*/

  List<PromotionResponseDataData?>? data;
  PromotionResponseDataMeta? meta;
  PromotionResponseDataLinks? links;

  PromotionResponseData({this.data, this.meta, this.links});

  PromotionResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && (json['data'] is List)) {
      final v = json['data'];
      final arr0 = <PromotionResponseDataData>[];
      v.forEach((v) {
        arr0.add(PromotionResponseDataData.fromJson(v));
      });
      this.data = arr0;
    }
    meta =
        (json['meta'] != null && (json['meta'] is Map))
            ? PromotionResponseDataMeta.fromJson(json['meta'])
            : null;
    links =
        (json['links'] != null && (json['links'] is Map))
            ? PromotionResponseDataLinks.fromJson(json['links'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class PromotionResponse {
  /*
{
  "success": true,
  "message": "Success",
  "data": {
    "data": [
      {
        "id": 4,
        "title": "20 taka discount",
        "image_url": "https://inventory.grozaarbd.com//storage/promotions/1748322398_1851898258_1.png",
        "description": "<p>20 taka discount for all products</p>",
        "end_date": "May 31, 2025"
      }
    ],
    "meta": {
      "current_page": 1,
      "from": 1,
      "last_page": 1,
      "per_page": 20,
      "to": 2,
      "total": 2
    },
    "links": {
      "first": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
      "last": "https://inventory.grozaarbd.com/api/v1/user/get-promotions?page=1",
      "prev": null,
      "next": null
    }
  }
}
*/

  bool? success;
  String? message;
  PromotionResponseData? data;

  PromotionResponse({this.success, this.message, this.data});

  PromotionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data =
        (json['data'] != null && (json['data'] is Map))
            ? PromotionResponseData.fromJson(json['data'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
