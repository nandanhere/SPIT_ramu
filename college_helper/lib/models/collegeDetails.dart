// To parse this JSON data, do
//
//     final collegeDetail = collegeDetailFromJson(jsonString);

import 'dart:convert';

CollegeDetail collegeDetailFromJson(String str) =>
    CollegeDetail.fromJson(json.decode(str));

String collegeDetailToJson(CollegeDetail data) => json.encode(data.toJson());

class CollegeDetail {
  CollegeDetail({
    required this.colleges,
  });

  List<CollegeElement> colleges;

  factory CollegeDetail.fromJson(Map<String, dynamic> json) => CollegeDetail(
        colleges: List<CollegeElement>.from(
            json["colleges"].map((x) => CollegeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "colleges": colleges == null
            ? null
            : List<dynamic>.from(colleges.map((x) => x.toJson())),
      };
}

class CollegeElement {
  CollegeElement({
    required this.college,
    required this.id,
    required this.address,
    required this.coordinates,
    required this.hostelFees,
    required this.collegeFees,
    required this.branches,
    required this.imageUrls,
  });

  CollegeCollege college;
  String id;
  String address;
  List<int> coordinates;
  int hostelFees;
  int collegeFees;
  List<Branch> branches;
  List<String> imageUrls;

  factory CollegeElement.fromJson(Map<String, dynamic> json) => CollegeElement(
        college: CollegeCollege.fromJson(json["college"]),
        id: json["_id"] == null ? null : json["_id"],
        address: json["address"] == null ? null : json["address"],
        coordinates: List<int>.from(json["coordinates"].map((x) => x)),
        hostelFees: json["hostelFees"] == null ? null : json["hostelFees"],
        collegeFees: json["collegeFees"] == null ? null : json["collegeFees"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "college": college == null ? null : college.toJson(),
        "_id": id == null ? null : id,
        "address": address == null ? null : address,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "hostelFees": hostelFees == null ? null : hostelFees,
        "collegeFees": collegeFees == null ? null : collegeFees,
        "branches": branches == null
            ? null
            : List<dynamic>.from(branches.map((x) => x.toJson())),
        "imageUrls": imageUrls == null
            ? null
            : List<dynamic>.from(imageUrls.map((x) => x)),
      };
}

class Branch {
  Branch({
    required this.branch,
    required this.cutoff,
  });

  String branch;
  int cutoff;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branch: json["branch"] == null ? null : json["branch"],
        cutoff: json["cutoff"] == null ? null : json["cutoff"],
      );

  Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : branch,
        "cutoff": cutoff == null ? null : cutoff,
      };
}

class CollegeCollege {
  CollegeCollege({
    required this.name,
    required this.website,
  });

  String name;
  String website;

  factory CollegeCollege.fromJson(Map<String, dynamic> json) => CollegeCollege(
        name: json["name"] == null ? null : json["name"],
        website: json["website"] == null ? null : json["website"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "website": website == null ? null : website,
      };
}
