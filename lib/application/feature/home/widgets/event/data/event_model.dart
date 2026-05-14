import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime eventDate; // We'll map 'endDate' from Firestore to this
  final String type; // event | offer | seasonal
  final bool isActive;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.eventDate,
    required this.type,
    required this.isActive,
    required this.createdAt,
  });

  factory EventModel.fromMap(Map<String, dynamic> map, String documentId) {
    // Map 'endDate' from Firestore to 'eventDate' in our model
    final dynamic firestoreDate = map['endDate'] ?? map['eventDate'];
    
    return EventModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      eventDate: firestoreDate != null 
          ? (firestoreDate as Timestamp).toDate() 
          : DateTime.now(),
      type: map['type'] ?? 'event',
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'endDate': Timestamp.fromDate(eventDate),
      'type': type,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
