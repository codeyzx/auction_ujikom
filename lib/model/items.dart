class Items {
  String? itemid;
  String? uid;
  String? title;
  String? about;
  String? about_detail;
  String? status;
  String? picture;
  dynamic createdAt;
  dynamic harga_awal;
  dynamic harga_akhir;


  Items({
    this.itemid,
    this.uid,
    this.title,
    this.about,
    this.about_detail,
    this.status,
    this.picture,
    this.createdAt,
    this.harga_awal,
    this.harga_akhir,
  });

  Items copyWith({
    String? itemid,
    String? uid,
    String? title,
    String? about,
    String? about_detail,
    String? status,
    String? picture,
    dynamic createdAt,
    dynamic harga_awal,
    dynamic harga_akhir
  }) {
    return Items(
        itemid: itemid ?? this.itemid,
        uid: uid ?? this.uid,
        title: title ?? this.title,
        about: about ?? this.about,
        about_detail: about_detail ?? this.about_detail,
        status: status ?? this.status,
        picture: picture ?? this.picture,
        createdAt: createdAt ?? this.createdAt,
        harga_awal: harga_awal ?? this.harga_awal,
        harga_akhir: harga_akhir ?? this.harga_akhir
    );

  }

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items (
      itemid: json['itemid'],
      uid: json['uid'],
      title: json['title'],
      about: json['about'],
      about_detail: json['about_detail'],
      status: json['status'],
      picture: json['picture'],
      createdAt: DateTime.parse(json['createdAt']),
      harga_awal: json['harga_awal'],
      harga_akhir: json['harga_akhir']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemid': itemid,
      'uid': uid,
      'title': title,
      'about': about,
      'about_detail': about_detail,
      'status': status,
      'picture': picture,
      'createdAt': createdAt,
      'harga_awal': harga_awal,
      'harga_akhir' : harga_akhir,
    };
  }
}
