import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixitbhaiivendor/models/serviceModel.dart';
// import 'services_model.dart'; // Ensure you have your model imported

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Adds a list of services to Firestore
  Future<void> uploadServices(List<Service> services) async {
    WriteBatch batch = _firestore.batch(); // Using batch write for efficiency
    CollectionReference servicesRef = _firestore.collection("services");

    for (Service service in services) {
      DocumentReference docRef = servicesRef.doc(service.serviceId);
      batch.set(docRef, service.toJson());
    }

    try {
      await batch.commit();
      print("🔥 Services successfully uploaded to Firestore!");
    } catch (e) {
      print("❌ Error uploading services: $e");
    }
  }
}


class FirestoreUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Uploads a list of services from JSON to Firestore
  Future<void> uploadServices(String jsonString) async {
    try {
      // Parse JSON string into a List<Map>
      List<dynamic> jsonData = json.decode(jsonString);

      // Firestore batch operation for efficiency
      WriteBatch batch = _firestore.batch();
      CollectionReference servicesRef = _firestore.collection("services");

      for (var item in jsonData) {
        String serviceId = item["serviceId"]; // Ensure serviceId is present
        DocumentReference docRef = servicesRef.doc(serviceId);
        batch.set(docRef, item);
      }

      // Commit batch upload
      await batch.commit();
      print("✅ Services uploaded successfully!");
    } catch (e) {
      print("❌ Error uploading services: $e");
    }
  }
}
