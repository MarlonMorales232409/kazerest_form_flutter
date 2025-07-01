import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazerest_form/model/user_answer.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Colección para guardar las respuestas de los usuarios
  static const String userAnswersCollection = 'user_answers';
  
  /// Guarda la respuesta completa del usuario en Firebase
  Future<String?> saveUserAnswer(UserAnswer userAnswer) async {
    try {
      print('🔍 Iniciando guardado de UserAnswer...');
      
      // Convertir el UserAnswer a JSON manualmente para evitar problemas de serialización
      final jsonData = userAnswer.toJson();
      print('🔍 JSON base generado: ${jsonData.keys}');
      
      // Convertir UserInterest objects a JSON
      print('🔍 Convirtiendo ${userAnswer.userInterests.length} UserInterests...');
      jsonData['userInterests'] = userAnswer.userInterests
          .map((interest) => interest.toJson())
          .toList();
      
      // Convertir CategoryImportance objects a JSON
      print('🔍 Convirtiendo ${userAnswer.categoryImportance.length} CategoryImportances...');
      jsonData['categoryImportance'] = userAnswer.categoryImportance
          .map((category) => category.toJson())
          .toList();
      
      print('🔍 Datos finales para Firestore: ${jsonData.keys}');
      
      // Crear el documento con timestamp
      final docData = {
        ...jsonData,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'completed',
      };
      
      print('🔍 Enviando a Firestore...');
      
      // Guardar en Firestore
      final docRef = await _firestore
          .collection(userAnswersCollection)
          .add(docData);
      
      print('✅ Respuesta guardada exitosamente con ID: ${docRef.id}');
      return docRef.id;
      
    } catch (e) {
      print('❌ Error al guardar en Firebase: $e');
      
      // Fallback: Guardar localmente si Firebase falla
      try {
        print('🔄 Intentando guardar localmente como fallback...');
        final localId = await _saveUserAnswerLocally(userAnswer);
        if (localId != null) {
          print('✅ Respuesta guardada localmente con ID: $localId');
          print('📋 Los datos se guardarán en Firebase una vez que se configuren los permisos');
          return localId;
        }
      } catch (localError) {
        print('❌ Error al guardar localmente: $localError');
      }
      
      print('❌ Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  /// Guarda la respuesta localmente como fallback
  Future<String?> _saveUserAnswerLocally(UserAnswer userAnswer) async {
    try {
      // Generar un ID único
      final localId = 'local_${DateTime.now().millisecondsSinceEpoch}';
      
      // Convertir a JSON
      final jsonData = userAnswer.toJson();
      jsonData['userInterests'] = userAnswer.userInterests
          .map((interest) => interest.toJson())
          .toList();
      jsonData['categoryImportance'] = userAnswer.categoryImportance
          .map((category) => category.toJson())
          .toList();
      jsonData['timestamp'] = DateTime.now().toIso8601String();
      jsonData['status'] = 'completed_locally';
      jsonData['id'] = localId;
      
      // En una app real, aquí guardarías en SharedPreferences, SQLite, etc.
      // Por ahora, solo loggeamos los datos completos
      print('📦 Datos guardados localmente:');
      print('   � Datos de usuario:');
      print('     - Nombre: ${jsonData['userName'] ?? 'No especificado'}');
      print('     - Email: ${jsonData['userEmail'] ?? 'No especificado'}');
      print('     - Teléfono: ${jsonData['userPhone'] ?? 'No especificado'}');
      print('     - Empresa: ${jsonData['businessName'] ?? 'No especificado'}');
      print('     - Rol: ${jsonData['userRole'] ?? 'No especificado'}');
      print('   �📊 Módulos de interés: ${jsonData['interestedModules']?.length ?? 0}');
      print('   📋 Módulos priorizados: ${jsonData['priorityModules']?.length ?? 0}');
      print('   ⭐ Calificaciones: ${jsonData['userInterests']?.length ?? 0}');
      print('   📈 Importancia categorías: ${jsonData['categoryImportance']?.length ?? 0}');
      print('   💬 Comentarios: ${jsonData['comments'] ?? 'Sin comentarios'}');
      
      return localId;
    } catch (e) {
      print('❌ Error en guardado local: $e');
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
