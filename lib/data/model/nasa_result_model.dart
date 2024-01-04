// To parse this JSON data, do
//
//     final nasaResult = nasaResultFromJson(jsonString);

import 'dart:convert';

NasaResult nasaResultFromJson(String str) =>
    NasaResult.fromJson(json.decode(str));

String nasaResultToJson(NasaResult data) => json.encode(data.toJson());

class NasaResult {
  Collection collection;

  NasaResult({
    required this.collection,
  });

  factory NasaResult.fromJson(Map<String, dynamic> json) => NasaResult(
        collection: Collection.fromJson(json["collection"]),
      );

  Map<String, dynamic> toJson() => {
        "collection": collection.toJson(),
      };
}

class Collection {
  String version;
  String href;
  List<Item> items;
  Metadata metadata;
  List<CollectionLink> links;

  Collection({
    required this.version,
    required this.href,
    required this.items,
    required this.metadata,
    required this.links,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        version: json["version"],
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        metadata: Metadata.fromJson(json["metadata"]),
        links: List<CollectionLink>.from(
            json["links"].map((x) => CollectionLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "href": href,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "metadata": metadata.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Item {
  String href;
  List<Datum> data;
  List<ItemLink>? links;

  Item({
    required this.href,
    required this.data,
    this.links,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        href: json["href"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: json["links"] == null
            ? []
            : List<ItemLink>.from(
                json["links"]!.map((x) => ItemLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Datum {
  Center center;
  String title;
  List<String> keywords;
  String nasaId;
  DateTime dateCreated;
  MediaType mediaType;
  String description;
  Photographer? photographer;
  Location? location;
  List<Album>? album;

  Datum({
    required this.center,
    required this.title,
    required this.keywords,
    required this.nasaId,
    required this.dateCreated,
    required this.mediaType,
    required this.description,
    this.photographer,
    this.location,
    this.album,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        center: centerValues.map[json["center"]]!,
        title: json["title"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        nasaId: json["nasa_id"],
        dateCreated: DateTime.parse(json["date_created"]),
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        description: json["description"],
        photographer: photographerValues.map[json["photographer"]]!,
        location: locationValues.map[json["location"]]!,
        album: json["album"] == null
            ? []
            : List<Album>.from(json["album"]!.map((x) => albumValues.map[x]!)),
      );

  Map<String, dynamic> toJson() => {
        "center": centerValues.reverse[center],
        "title": title,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "nasa_id": nasaId,
        "date_created": dateCreated.toIso8601String(),
        "media_type": mediaTypeValues.reverse[mediaType],
        "description": description,
        "photographer": photographerValues.reverse[photographer],
        "location": locationValues.reverse[location],
        "album": album == null
            ? []
            : List<dynamic>.from(album!.map((x) => albumValues.reverse[x])),
      };
}

enum Album {
  APOLLO,
  KSC_50_TH_ANNIVERSARY,
  RESOURCE_REEL_BROLL,
  THE_201907_APOLLO_50_TH_IN_DC
}

final albumValues = EnumValues({
  "Apollo": Album.APOLLO,
  "KSC_50th_Anniversary": Album.KSC_50_TH_ANNIVERSARY,
  "resource_reel_broll": Album.RESOURCE_REEL_BROLL,
  "201907_Apollo_50th_in_DC": Album.THE_201907_APOLLO_50_TH_IN_DC
});

enum Center { HQ, JSC, KSC }

final centerValues =
    EnumValues({"HQ": Center.HQ, "JSC": Center.JSC, "KSC": Center.KSC});

enum Location {
  GODDARD_SPACE_FLIGHT_CENTER_FL,
  IMAX_THEATER_KSC_VISITOR_COMPLE,
  KENNEDY_SPACE_CENTER_FL,
  KSC,
  NASA_HQ,
  NATIONAL_AIR_AND_SPACE_MUSEUM,
  NATIONAL_MALL,
  SATURN_V_BUILDING
}

final locationValues = EnumValues({
  "Goddard Space Flight Center, FL": Location.GODDARD_SPACE_FLIGHT_CENTER_FL,
  "IMAX Theater, KSC Visitor Comple": Location.IMAX_THEATER_KSC_VISITOR_COMPLE,
  "Kennedy Space Center, FL": Location.KENNEDY_SPACE_CENTER_FL,
  "KSC": Location.KSC,
  "NASA HQ": Location.NASA_HQ,
  "National Air and Space Museum": Location.NATIONAL_AIR_AND_SPACE_MUSEUM,
  "National Mall": Location.NATIONAL_MALL,
  "Saturn V Building": Location.SATURN_V_BUILDING
});

enum MediaType { AUDIO, IMAGE, VIDEO }

final mediaTypeValues = EnumValues({
  "audio": MediaType.AUDIO,
  "image": MediaType.IMAGE,
  "video": MediaType.VIDEO
});

enum Photographer {
  NASA,
  NASA_AUBREY_GEMIGNANI,
  NASA_BILL_INGALLS,
  NASA_CONNIE_MOORE,
  NASA_CORY_HUSTON,
  NASA_JOEL_KOWSKY,
  NASA_KIM_SHIFLETT
}

final photographerValues = EnumValues({
  "NASA": Photographer.NASA,
  "NASA/Aubrey Gemignani": Photographer.NASA_AUBREY_GEMIGNANI,
  "NASA/Bill Ingalls": Photographer.NASA_BILL_INGALLS,
  "NASA/Connie Moore": Photographer.NASA_CONNIE_MOORE,
  "NASA/Cory Huston": Photographer.NASA_CORY_HUSTON,
  "NASA/Joel Kowsky": Photographer.NASA_JOEL_KOWSKY,
  "NASA/Kim Shiflett": Photographer.NASA_KIM_SHIFLETT
});

class ItemLink {
  String href;
  Rel rel;
  MediaType? render;

  ItemLink({
    required this.href,
    required this.rel,
    this.render,
  });

  factory ItemLink.fromJson(Map<String, dynamic> json) => ItemLink(
        href: json["href"],
        rel: relValues.map[json["rel"]]!,
        render: mediaTypeValues.map[json["render"]]!,
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": relValues.reverse[rel],
        "render": mediaTypeValues.reverse[render],
      };
}

enum Rel { CAPTIONS, PREVIEW }

final relValues =
    EnumValues({"captions": Rel.CAPTIONS, "preview": Rel.PREVIEW});

class CollectionLink {
  String rel;
  String prompt;
  String href;

  CollectionLink({
    required this.rel,
    required this.prompt,
    required this.href,
  });

  factory CollectionLink.fromJson(Map<String, dynamic> json) => CollectionLink(
        rel: json["rel"],
        prompt: json["prompt"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "prompt": prompt,
        "href": href,
      };
}

class Metadata {
  int totalHits;

  Metadata({
    required this.totalHits,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        totalHits: json["total_hits"],
      );

  Map<String, dynamic> toJson() => {
        "total_hits": totalHits,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
