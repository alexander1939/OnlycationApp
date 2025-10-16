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

- Por defecto, en desarrollo de escritorio puedes usar `http://127.0.0.1:8000/api/`.
- Para MÓVIL (Android físico), 127.0.0.1 NO funciona. Usa:
  - IP LAN de tu PC (ej. `http://192.168.x.x:8000/api/`), o
  - Un túnel público (recomendado): `https://<tu-dominio>.trycloudflare.com/api/`.

Consulta `lib/core/constants/app_constants.dart` para el valor actual de `baseUrl`.

---

## 🔐 Login/Registro con LinkedIn (Móvil) por Deep Link

Este proyecto implementa el flujo OAuth de LinkedIn para móvil usando deep links (`onlycation://auth`).

### Resumen del flujo

1. La app llama a tu backend para obtener `authorization_url`:
   - Login: `GET /api/auth/linkedin/login?redirect_uri=onlycation://auth`
   - Registro estudiante: `GET /api/auth/linkedin/register/student?redirect_uri=onlycation://auth`
2. La app abre el navegador con `authorization_url` (LinkedIn).
3. LinkedIn redirige a tu backend en el callback público (túnel) `https://<tu-dominio>/api/auth/linkedin/callback`.
4. El backend intercambia `code -> tokens`, crea/inicia sesión del usuario y redirige a la app:
   - `onlycation://auth?token=<ACCESS_TOKEN>`
5. La app captura el deep link, guarda el token y navega a Home.

### Archivos relevantes (App)

- `android/app/src/main/AndroidManifest.xml`
  - `intent-filter` para `onlycation://auth` y permiso de `INTERNET`.
- `lib/core/constants/app_constants.dart`
  - `baseUrl` (pon tu IP LAN o dominio del túnel) y constantes de OAuth.
- `lib/presentation/viewmodels/auth/login_viewmodel.dart`
  - Métodos:
    - `loginWithLinkedInMobile()`
    - `registerStudentWithLinkedInMobile()`
  - Usa `flutter_web_auth_2` para abrir LinkedIn y esperar el callback.
- `lib/presentation/screens/auth/login_screen.dart`
  - Botón “Iniciar sesión con LinkedIn”.
- `lib/presentation/screens/auth/register_screen.dart`
  - Botón “Registrarse con LinkedIn (Estudiante)”.
- `lib/routes/app_router.dart`
  - Maneja `"/?token=..."`: guarda token y navega a `AppRouteNames.home`.
- `lib/main.dart`
  - Interceptor de `Dio` envía `Authorization: Bearer <token>`.

### Backend (requisitos)

- Servir en red: `uvicorn app:app --host 0.0.0.0 --port 8000`.
- Variables/config:
  - `LINKEDIN_REDIRECT_URI = https://<tu-dominio>/api/auth/linkedin/callback`
  - Registrar ese Redirect URL en LinkedIn Developer Portal.
- Endpoints mínimos:
  - `GET /api/auth/linkedin/login` → devuelve `{ authorization_url }` (usar `LINKEDIN_REDIRECT_URI`).
  - `GET /api/auth/linkedin/register/student` → idem con `state=register:student`.
  - `GET /api/auth/linkedin/callback` → intercambia `code`, genera tokens y devuelve `RedirectResponse("onlycation://auth?token=<ACCESS_TOKEN>", 307)`.

---

## ☁️ Configuración rápida de Cloudflared (túnel)

Para exponer tu API local al exterior de forma temporal.

### Instalar (Arch Linux)

```bash
sudo pacman -S cloudflared
```

### Levantar el túnel hacia tu API local (8000)

```bash
cloudflared tunnel --url http://localhost:8000
```

Obtendrás una URL pública tipo:

```
https://<algo>.trycloudflare.com
```

Úsala como base de tu API en la app: `https://<algo>.trycloudflare.com/api/`.

### Ajustes en LinkedIn y backend

- En LinkedIn Developer Portal, agrega el Redirect URL:
  - `https://<algo>.trycloudflare.com/api/auth/linkedin/callback`
- En tu backend, usa esa misma URL como `LINKEDIN_REDIRECT_URI`.

---

## 🧪 Cómo probar el flujo en Android físico

1. Verifica que ADB detecta el dispositivo:
   ```bash
   flutter devices
   ```
2. Limpia y ejecuta:
   ```bash
   flutter clean
   flutter pub get
   flutter run -d <ID_DISPOSITIVO>
   ```
3. En la app:
   - Login: “Iniciar sesión con LinkedIn”
   - Registro (estudiante): “Registrarse con LinkedIn (Estudiante)”
4. Completa OAuth en el navegador; el backend redirigirá a `onlycation://auth?token=...` y la app entrará a Home.

---

## 🛠️ Troubleshooting

- **Veo JSON en el navegador al finalizar:** el callback del backend debe hacer `RedirectResponse` al deep link. No devolver JSON.
- **Se abre el navegador pero no vuelve a la app:** revisa el `intent-filter` (Android), el esquema `onlycation`, y que el backend efectivamente redirige a `onlycation://auth?...`.
- **El teléfono no alcanza la API:** usa IP LAN o túnel; 127.0.0.1 del PC no sirve en el móvil.
- **Gradle usa versión vieja (8.9):** actualiza `android/gradle/wrapper/gradle-wrapper.properties` a `8.12-all`, elimina `~/.gradle/wrapper/dists/gradle-8.9-*` y vuelve a ejecutar.
- **Licencias/NDK:** acepta licencias e instala NDK con `sdkmanager` del SDK en HOME.

---

## 🔒 Notas de seguridad

- Nunca publiques tokens en logs o UI.
- Firma/valida `state` en OAuth para prevenir CSRF.
- En producción, usa dominios y certificados gestionados; los túneles son para desarrollo.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.
