



// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseRoutes {
  static CollectionReference  USER_DATABASES = FirebaseFirestore.instance.collection('users');
  static CollectionReference  QUESTION_DATABASES = FirebaseFirestore.instance.collection('questions');
  static CollectionReference  RENSPONSE_DATABASES = FirebaseFirestore.instance.collection('responses');
  static CollectionReference  DOWAR_DATABASES = FirebaseFirestore.instance.collection('dowars');
  static CollectionReference  MEDIA_DATABASES = FirebaseFirestore.instance.collection('medias');
  static CollectionReference  INTERVAL_DATABASES = FirebaseFirestore.instance.collection('intervales');
  static CollectionReference  RESSOURCE_DATABASES = FirebaseFirestore.instance.collection('ressources');
  static CollectionReference  PROJET_DATABASES = FirebaseFirestore.instance.collection('projets');
  static CollectionReference  ACTEUR_DATABASES = FirebaseFirestore.instance.collection('acteurs');
  static CollectionReference  INFRASTRUCTURE_DATABASES = FirebaseFirestore.instance.collection('infrastructures');
  // Listes de types paramétrables par l'admin (un document par catégorie,
  // ex. 'infrastructures', 'acteurs_roles', 'ressources_proprietaire'),
  // éditables directement dans la console Firebase.
  static CollectionReference  TYPE_LIST_DATABASES = FirebaseFirestore.instance.collection('type_lists');
  // Propositions de nouveaux types soumises par les enquêteurs, en attente de
  // validation par un chercheur.
  static CollectionReference  TYPE_SUGGESTION_DATABASES = FirebaseFirestore.instance.collection('type_suggestions');
  // Base de référence des villages/localités du Maroc (import initial GeoNames,
  // à compléter avec une source officielle — voir compte-rendu).
  static CollectionReference  VILLAGE_REFERENCE_DATABASES = FirebaseFirestore.instance.collection('villages_maroc');



  static Reference STORAGE_REFERENCE = FirebaseStorage.instance.ref();
}