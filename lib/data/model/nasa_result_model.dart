// To parse this JSON data, do
//
//     final nasaData = nasaDataFromJson(jsonString);

import 'dart:convert';

NasaData nasaDataFromJson(String str) => NasaData.fromJson(json.decode(str));

String nasaDataToJson(NasaData data) => json.encode(data.toJson());

class NasaData {
  Collection? collection;

  NasaData({
    this.collection,
  });

  factory NasaData.fromJson(Map<String, dynamic> json) => NasaData(
        collection: json["collection"] == null
            ? null
            : Collection.fromJson(json["collection"]),
      );

  Map<String, dynamic> toJson() => {
        "collection": collection?.toJson(),
      };
}

class Collection {
  String? version;
  String? href;
  List<Item>? items;
  Metadata? metadata;
  List<CollectionLink>? links;

  Collection({
    this.version,
    this.href,
    this.items,
    this.metadata,
    this.links,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        version: json["version"],
        href: json["href"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        links: json["links"] == null
            ? []
            : List<CollectionLink>.from(
                json["links"]!.map((x) => CollectionLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "href": href,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "metadata": metadata?.toJson(),
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Item {
  String? href;
  List<Datum>? data;
  List<ItemLink>? links;

  Item({
    this.href,
    this.data,
    this.links,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        href: json["href"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null
            ? []
            : List<ItemLink>.from(
                json["links"]!.map((x) => ItemLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Datum {
  String? center;
  String? title;
  String? keywords;
  String? nasaId;
  String? dateCreated;
  String? mediaType;
  String? description508;
  String? description;
  String? secondaryCreator;
  String? photographer;
  String? location;
  String? album;

  Datum({
    this.center,
    this.title,
    this.keywords,
    this.nasaId,
    this.dateCreated,
    this.mediaType,
    this.description508,
    this.description,
    this.secondaryCreator,
    this.photographer,
    this.location,
    this.album,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        center: json["center"],
        title: json["title"],
        keywords: json["keywords"] == null
            ? ''
            : (json["keywords"] is String)
                ? json["keywords"]
                : List<String>.from(json["keywords"]!.map((x) => x))[0],
        nasaId: json["nasa_id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]).toString(),
        mediaType: json["media_type"],
        description508: json["description_508"],
        description: json["description"],
        secondaryCreator: json["secondary_creator"],
        photographer: json["photographer"],
        location: json["location"],
        album: json["album"] == null
            ? ''
            : (json["album"] is String)
                ? json["album"]
                : List<String>.from(json["album"]!.map((x) => x))[0],
      );

  Map<String, dynamic> toJson() => {
        "center": center,
        "title": title,
        "keywords": keywords,
        "nasa_id": nasaId,
        "date_created": dateCreated,
        "media_type": mediaType,
        "description_508": description508,
        "description": description,
        "secondary_creator": secondaryCreator,
        "photographer": photographer,
        "location": location,
        "album": album,
      };
}

class ItemLink {
  String? href;
  String? rel;
  String? render;

  ItemLink({
    this.href,
    this.rel,
    this.render,
  });

  factory ItemLink.fromJson(Map<String, dynamic> json) => ItemLink(
        href: json["href"],
        rel: json["rel"],
        render: json["render"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "render": render,
      };
}

class CollectionLink {
  String? rel;
  String? prompt;
  String? href;

  CollectionLink({
    this.rel,
    this.prompt,
    this.href,
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
  int? totalHits;

  Metadata({
    this.totalHits,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        totalHits: json["total_hits"],
      );

  Map<String, dynamic> toJson() => {
        "total_hits": totalHits,
      };
}
