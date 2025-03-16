class ServicesModel {
    ServicesModel({
        required this.services,
    });

    final List<Service> services;

    factory ServicesModel.fromJson(Map<String, dynamic> json){ 
        return ServicesModel(
            services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "services": services.map((x) => x?.toJson()).toList(),
    };

}

class Service {
    Service({
        required this.serviceId,
        required this.name,
        required this.divisionId,
        required this.divisionName,
        required this.categoryId,
        required this.categoryName,
        required this.description,
        required this.estimatedTime,
        required this.basePriceRange,
        required this.serviceType,
        required this.imageUrl,
        required this.faq,
        required this.fixItYourself,
        required this.availability,
        required this.createdAt,
    });

    final String? serviceId;
    final String? name;
    final String? divisionId;
    final String? divisionName;
    final String? categoryId;
    final String? categoryName;
    final String? description;
    final String? estimatedTime;
    final String? basePriceRange;
    final String? serviceType;
    final String? imageUrl;
    final List<Faq> faq;
    final List<FixItYourself> fixItYourself;
    final bool? availability;
    final DateTime? createdAt;

    factory Service.fromJson(Map<String, dynamic> json){ 
        return Service(
            serviceId: json["serviceId"],
            name: json["name"],
            divisionId: json["divisionId"],
            divisionName: json["divisionName"],
            categoryId: json["categoryId"],
            categoryName: json["categoryName"],
            description: json["description"],
            estimatedTime: json["estimatedTime"],
            basePriceRange: json["basePriceRange"],
            serviceType: json["serviceType"],
            imageUrl: json["imageUrl"],
            faq: json["faq"] == null ? [] : List<Faq>.from(json["faq"]!.map((x) => Faq.fromJson(x))),
            fixItYourself: json["fixItYourself"] == null ? [] : List<FixItYourself>.from(json["fixItYourself"]!.map((x) => FixItYourself.fromJson(x))),
            availability: json["availability"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "name": name,
        "divisionId": divisionId,
        "divisionName": divisionName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "description": description,
        "estimatedTime": estimatedTime,
        "basePriceRange": basePriceRange,
        "serviceType": serviceType,
        "imageUrl": imageUrl,
        "faq": faq.map((x) => x?.toJson()).toList(),
        "fixItYourself": fixItYourself.map((x) => x?.toJson()).toList(),
        "availability": availability,
        "createdAt": createdAt?.toIso8601String(),
    };

}

class Faq {
    Faq({
        required this.question,
        required this.answer,
    });

    final String? question;
    final String? answer;

    factory Faq.fromJson(Map<String, dynamic> json){ 
        return Faq(
            question: json["question"],
            answer: json["answer"],
        );
    }

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
    };

}

class FixItYourself {
    FixItYourself({
        required this.tip,
    });

    final String? tip;

    factory FixItYourself.fromJson(Map<String, dynamic> json){ 
        return FixItYourself(
            tip: json["tip"],
        );
    }

    Map<String, dynamic> toJson() => {
        "tip": tip,
    };

}
