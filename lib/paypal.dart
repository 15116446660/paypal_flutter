class AuthModel{
  final String scope;
  final String access_token;
  final String token_type;
  final String app_id;
  final String expires_in;
  final String nonce;

  AuthModel({this.scope, this.access_token, this.token_type, this.app_id, this.expires_in, this.nonce});

  factory AuthModel.fromJson(Map json){
    return AuthModel(
      scope : json['scope'],
      access_token : json['access_token'],
      token_type : json['token_type'],
      app_id : json['app_id'],
      expires_in : json['expires_in'].toString(),
      nonce: json['nonce'],
    );
  }
}

class OrderDetail{
  final String id;
  final List<Link> links;
  final String status;

  OrderDetail({this.id, this.links, this.status});

  factory OrderDetail.fromJson(Map json){
    var list = json['links'] as List;


    List<Link> links = list.map((linkJson) {
      return Link(
        href: linkJson['href'],
        method: linkJson['method'],
        rel: linkJson['rel'],
      );
    }).toList();
    
    
    return OrderDetail(
      id: json['id'],
      links: links,
      status: json['status'],
    );
  }
}

class Link{
  final String href;
  final String rel;
  final String method;

  Link({this.href, this.rel, this.method});
}



