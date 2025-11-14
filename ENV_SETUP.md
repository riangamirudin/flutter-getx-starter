# Setup Environment Configuration (.env)

File `.env` digunakan untuk menyimpan konfigurasi aplikasi berdasarkan environment.

## Cara Setup

1. **Buat file `.env` di root project** (salin dari `.env.example` jika ada):
   ```bash
   cp .env.example .env
   ```

2. **Edit file `.env`** dengan nilai yang sesuai:
   ```env
   # Environment Configuration
   APP_ENV=development

   # API Configuration
   API_BASE_URL_DEV=https://api-dev.example.com
   API_BASE_URL_STAGING=https://api-staging.example.com
   API_BASE_URL_PROD=https://api.example.com

   # API Version
   API_VERSION=v1

   # Network Timeout (dalam milliseconds)
   CONNECT_TIMEOUT=60000
   RECEIVE_TIMEOUT=60000

   # App Version
   APP_VERSION=1.0.0
   APP_BUILD_NUMBER=1
   ```

3. **Pastikan file `.env` sudah ditambahkan ke `pubspec.yaml`**:
   ```yaml
   flutter:
     assets:
       - .env
   ```

4. **File `.env` sudah otomatis di-load di `main.dart`**

## Environment Values

- `APP_ENV`: Set ke `development`, `staging`, atau `production`
- `API_BASE_URL_DEV`: Base URL untuk development
- `API_BASE_URL_STAGING`: Base URL untuk staging
- `API_BASE_URL_PROD`: Base URL untuk production
- `API_VERSION`: Version API (default: v1)
- `CONNECT_TIMEOUT`: Timeout untuk koneksi (dalam milliseconds)
- `RECEIVE_TIMEOUT`: Timeout untuk receive (dalam milliseconds)
- `APP_VERSION`: Version aplikasi
- `APP_BUILD_NUMBER`: Build number aplikasi

## Catatan Penting

⚠️ **JANGAN commit file `.env` ke repository!** 
- File `.env` berisi konfigurasi sensitif
- Gunakan `.env.example` sebagai template
- Tambahkan `.env` ke `.gitignore`

## Penggunaan

Setelah setup, konfigurasi akan otomatis di-load saat aplikasi start:

```dart
// Di main.dart sudah otomatis di-load
await dotenv.load(fileName: ".env");
AppConfig.init();

// Gunakan config
final baseUrl = AppConfig.baseUrl;
final isDev = AppConfig.isDevelopment;
```

