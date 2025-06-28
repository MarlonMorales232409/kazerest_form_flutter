import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazerest_form/model/user_answer.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Colección para guardar las respuestas de los usuarios
  static const String userAnswersCollection = 'user_answers';
  
  /// Guarda la respuesta completa del usuario en Firebase
  Future<String?> saveUserAnswer(UserAnswer userAnswer) async {
    try {
      // Crear el documento con timestamp
      final docData = {
        ...userAnswer.toJson(),
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'completed',
      };
      
      // Guardar en Firestore
      final docRef = await _firestore
          .collection(userAnswersCollection)
          .add(docData);
      
      print('✅ Respuesta guardada exitosamente con ID: ${docRef.id}');
      return docRef.id;
      
    } catch (e) {
      print('❌ Error al guardar respuesta: $e');
      return null;
    }
  }
  
  /// Obtiene todas las respuestas de usuarios
  Future<List<UserAnswer>> getAllUserAnswers() async {
    try {
      final querySnapshot = await _firestore
          .collection(userAnswersCollection)
          .orderBy('timestamp', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id; // Agregar el ID del documento
            return UserAnswer.fromJson(data);
          })
          .toList();
          
    } catch (e) {
      print('❌ Error al obtener respuestas: $e');
      return [];
    }
  }
  
  /// Obtiene una respuesta específica por ID
  Future<UserAnswer?> getUserAnswerById(String id) async {
    try {
      final docSnapshot = await _firestore
          .collection(userAnswersCollection)
          .doc(id)
          .get();
      
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        data['id'] = docSnapshot.id;
        return UserAnswer.fromJson(data);
      }
      
      return null;
      
    } catch (e) {
      print('❌ Error al obtener respuesta por ID: $e');
      return null;
    }
  }
  
  /// Actualiza el estado de una respuesta
  Future<bool> updateAnswerStatus(String id, String status) async {
    try {
      await _firestore
          .collection(userAnswersCollection)
          .doc(id)
          .update({
            'status': status,
            'updatedAt': FieldValue.serverTimestamp(),
          });
      
      print('✅ Estado actualizado exitosamente');
      return true;
      
    } catch (e) {
      print('❌ Error al actualizar estado: $e');
      return false;
    }
  }
  
  /// Elimina una respuesta
  Future<bool> deleteUserAnswer(String id) async {
    try {
      await _firestore
          .collection(userAnswersCollection)
          .doc(id)
          .delete();
      
      print('✅ Respuesta eliminada exitosamente');
      return true;
      
    } catch (e) {
      print('❌ Error al eliminar respuesta: $e');
      return false;
    }
  }
  
  /// Stream para escuchar cambios en tiempo real
  Stream<List<UserAnswer>> getUserAnswersStream() {
    return _firestore
        .collection(userAnswersCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return UserAnswer.fromJson(data);
          }).toList();
        });
  }
}
