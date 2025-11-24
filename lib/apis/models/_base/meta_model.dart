class MetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;

  final int total;

  MetaModel(this.currentPage, this.lastPage, this.perPage, this.total);

  MetaModel.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int,
        lastPage = json['last_page'] as int,
        perPage = json['per_page'] as int,
        total = json['total'] as int;

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total
      };

  static MetaModel getEmptyOne() {
    return MetaModel(0, 0, 0, 0);
  }
}
