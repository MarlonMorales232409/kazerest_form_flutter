# KazeRest Form - GetX State Management

Una aplicación Flutter que demuestra el uso de **GetX** como gestor de estado junto con **Freezed** para modelos inmutables.

## 🛠️ Tecnologías Utilizadas

- **Flutter 3.8.1+**
- **GetX 4.6.6** - Gestión de estado, navegación y inyección de dependencias
- **Freezed 2.4.6** - Generación de modelos inmutables
- **JSON Serializable** - Serialización automática JSON

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada de la aplicación
├── controller/
│   └── user_controller.dart       # Controlador GetX para usuarios
├── model/
│   ├── model.dart                 # Exports de modelos
│   ├── user.model.dart            # Modelo User con Freezed
│   ├── user.model.freezed.dart    # Archivo generado por Freezed
│   └── user.model.g.dart          # Archivo generado para JSON
└── view/
    ├── user_list_view.dart        # Vista lista de usuarios
    ├── user_form_view.dart        # Vista formulario de usuario
    └── user_search_view.dart      # Vista de búsqueda
```

## 🚀 Características Implementadas

### ✅ **GetX State Management**
- **Controlador reactivo** (`UserController`) con observables
- **Gestión de estado** para lista de usuarios
- **Navegación** entre pantallas usando `Get.to()`
- **Snackbars** para notificaciones
- **Dialogs** para confirmaciones

### ✅ **Freezed Models**
- **Modelo UserModel** inmutable
- **copyWith()** para crear copias modificadas
- **Serialización JSON** automática
- **Equality** y **toString()** automáticos

### ✅ **Funcionalidades de la App**
- ➕ **Crear usuarios** con validación
- ✏️ **Editar usuarios** existentes
- 🗑️ **Eliminar usuarios** con confirmación
- 🔍 **Buscar usuarios** por nombre o email
- 📱 **UI moderna** y responsive

## 🎯 **Características de GetX Implementadas**

### 1. **State Management (Gestión de Estado)**
```dart
// Observables reactivos
final _users = <UserModel>[].obs;
final _selectedUser = Rxn<UserModel>();
final _isLoading = false.obs;

// Widgets reactivos
Obx(() => Text('Total: ${controller.users.length}'))
```

### 2. **Dependency Injection (Inyección de Dependencias)**
```dart
// Inicialización del controlador
Get.put(UserController());

// Obtención del controlador
final UserController controller = Get.find();
```

### 3. **Route Management (Gestión de Rutas)**
```dart
// Navegación simple
Get.to(() => UserFormView());

// Navegación con retorno
Get.back();

// Navegación con reemplazo
Get.off(() => HomePage());
```

### 4. **Utils (Utilidades)**
```dart
// Snackbars
Get.snackbar('Título', 'Mensaje');

// Dialogs
Get.dialog(AlertDialog(...));

// Validaciones
GetUtils.isEmail(email);
```

## 📋 **Modelo UserModel**

```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

## 🎮 **Uso del Controlador**

```dart
class UserController extends GetxController {
  // Lista reactiva de usuarios
  final _users = <UserModel>[].obs;
  
  // Getters
  List<UserModel> get users => _users;
  
  // Métodos
  void addUser(UserModel user) { ... }
  void updateUser(UserModel user) { ... }
  void deleteUser(int id) { ... }
  void searchUsers(String query) { ... }
}
```

## 🔧 **Comandos de Desarrollo**

```bash
# Instalar dependencias
flutter pub get

# Generar archivos Freezed
dart run build_runner build

# Generar con limpieza
dart run build_runner build --delete-conflicting-outputs

# Analizar código
flutter analyze

# Ejecutar app
flutter run
```

## 📱 **Pantallas de la App**

### 1. **UserListView**
- Lista todos los usuarios
- Botones para agregar, buscar, editar y eliminar
- Loading states con `Obx()`

### 2. **UserFormView**
- Formulario para crear/editar usuarios
- Validación de campos
- Usar el mismo widget para crear y editar

### 3. **UserSearchView**
- Búsqueda en tiempo real
- Filtrado por nombre o email
- Resultados reactivos

## 🎨 **Beneficios de GetX**

✅ **Performance**: Reconstruye solo widgets necesarios  
✅ **Simplicidad**: Menos boilerplate code  
✅ **Productividad**: Todo-en-uno (estado, rutas, dependencias)  
✅ **Testing**: Fácil de testear  
✅ **Escalabilidad**: Mantiene el código organizado  

## 📦 **Dependencias del Proyecto**

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                    # GetX
  freezed_annotation: ^2.4.1     # Freezed annotations
  json_annotation: ^4.8.1        # JSON annotations

dev_dependencies:
  freezed: ^2.4.6               # Freezed code generator
  build_runner: ^2.4.7          # Build runner
  json_serializable: ^6.7.1     # JSON serialization
```

---

## 🚀 **¡La app está lista!**

Ejecuta `flutter run` para ver GetX en acción con:
- Estado reactivo
- Navegación fluida  
- Gestión completa de usuarios
- UI moderna y responsive
