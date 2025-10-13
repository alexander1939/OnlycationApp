# Onlycation App

Aplicación móvil desarrollada con Flutter que utiliza una arquitectura MVVM (Model-View-ViewModel) con el patrón Repository.

## 🏗️ Estructura Completa del Proyecto

```
lib/
├── core/                    # Funcionalidades centrales
│   ├── base/               # Clases base abstractas
│   │   ├── base_repository.dart
│   │   └── base_viewmodel.dart
│   │
│   ├── constants/          # Constantes globales
│   │   ├── app_constants.dart
│   │   └── api_routes.dart
│   │
│   ├── theme/             # Temas y estilos
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   └── text_styles.dart
│   │
│   └── utils/             # Utilidades
│       ├── validators.dart
│       ├── extensions/
│       └── helpers/
│
├── data/
│   ├── datasources/       # Fuentes de datos
│   │   ├── local/        # Almacenamiento local
│   │   └── remote/       # Llamadas a API
│   │
│   ├── models/           # Modelos de datos (DTOs)
│   │   ├── request/     # Modelos para peticiones
│   │   └── response/    # Modelos para respuestas
│   │
│   └── repositories/     # Implementación de repositorios
│       └── auth_repository_impl.dart
│
├── domain/
│   ├── entities/         # Entidades del negocio
│   │   └── user_entity.dart
│   │
│   ├── repositories/     # Interfaces de repositorios
│   │   └── auth_repository.dart
│   │
│   └── usecases/        # Casos de uso
│       └── auth/
│           ├── login_usecase.dart
│           └── register_usecase.dart
│
├── presentation/
│   ├── screens/         # Pantallas de la aplicación
│   │   └── auth/
│   │       ├── login/
│   │       │   ├── login_screen.dart
│   │       │   └── widgets/
│   │       └── register/
│   │
│   ├── viewmodels/      # Lógica de presentación
│   │   └── auth/
│   │       ├── login_viewmodel.dart
│   │       └── register_viewmodel.dart
│   │
│   └── widgets/         # Componentes reutilizables
│       ├── buttons/
│       ├── dialogs/
│       └── form_fields/
│
├── routes/              # Gestión de rutas
│   ├── app_router.dart
│   └── route_names.dart
│
├── services/            # Servicios externos
│   ├── api_service.dart
│   └── local_storage_service.dart
│
└── utils/               # Utilidades adicionales
    ├── constants.dart
    └── logger.dart
```

### 📂 Explicación de cada directorio:

#### `core/`
- **base/**: Clases base abstractas que implementan patrones comunes
- **constants/**: Constantes globales como URLs de API, claves de almacenamiento, etc.
- **theme/**: Configuración de temas, colores, estilos de texto, etc.
- **utils/**: Utilidades y helpers reutilizables

#### `data/`
- **datasources/**: Implementación de fuentes de datos (API, base de datos local)
- **models/**: Modelos de datos que representan la estructura de la API
- **repositories/**: Implementación concreta de los repositorios del dominio

#### `domain/`
- **entities/**: Modelos del dominio de negocio
- **repositories/**: Interfaces que definen los contratos de los repositorios
- **usecases/**: Casos de uso que implementan la lógica de negocio

#### `presentation/`
- **screens/**: Pantallas de la aplicación organizadas por características
- **viewmodels/**: Lógica de presentación siguiendo el patrón MVVM
- **widgets/**: Componentes de UI reutilizables

#### `routes/`
- Gestión de navegación y rutas nombradas

#### `services/`
- Servicios externos como llamadas a API, autenticación, etc.

#### `utils/`
- Utilidades adicionales y configuraciones globales

## 🚀 Configuración Inicial

1. **Variables de Entorno**
   - Copiar `.env.example` a `.env`
   - Configurar las variables de entorno necesarias

2. **Instalación de Dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la Aplicación**
   ```bash
   flutter run
   ```

## 🔧 Dependencias Principales

- **http/dio**: Para peticiones HTTP
- **provider**: Para gestión de estado
- **shared_preferences**: Para almacenamiento local
- **flutter_dotenv**: Para manejo de variables de entorno
- **intl**: Para internacionalización
- **logger**: Para logs

## 📱 Estructura de Pantallas

Cada característica principal debe tener su propia carpeta dentro de `lib/presentation/screens/` con la siguiente estructura:

```
lib/presentation/screens/
├── auth/                    # Autenticación
│   ├── login/              
│   │   ├── login_screen.dart
│   │   └── widgets/        # Widgets específicos del login
│   └── register/           
│       ├── register_screen.dart
│       └── widgets/
│
├── home/                   # Pantalla principal
│   ├── home_screen.dart
│   └── widgets/
│
├── profile/                # Perfil de usuario
│   ├── profile_screen.dart
│   └── widgets/
│
├── settings/               # Configuración
│   ├── settings_screen.dart
│   └── widgets/
│
└── [feature_name]/         # Otras características
    ├── [feature_name]_screen.dart
    └── widgets/
```

### Estructura de cada pantalla:

1. **Archivo principal de la pantalla** (`login_screen.dart`):
   - Contiene la estructura principal de la UI
   - Maneja los eventos de la interfaz
   - Se conecta con el ViewModel correspondiente

2. **Carpeta `widgets/`**:
   - Contiene componentes reutilizables específicos de la pantalla
   - Ejemplo: `login_form.dart`, `login_button.dart`, etc.
   - Los widgets muy genéricos van en `lib/presentation/widgets/`

3. **Reglas de organización**:
   - Cada pantalla debe ser independiente
   - Los widgets específicos de una pantalla van en su carpeta `widgets/`
   - Los widgets reutilizables van en `lib/presentation/widgets/`
   - Los estilos comunes van en `lib/core/theme/`

## 🔄 API

La aplicación se conecta a una API REST en `http://127.0.0.1:8000/api/`

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.
