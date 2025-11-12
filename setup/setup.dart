import 'dart:io';

Future<void> main() async {
  stdout.write('Masukkan nama projek (misal: my_new_app): ');
  final appName = stdin.readLineSync()!.trim();
  stdout.write('Masukkan nama aplikasi (misal: My New App): ');
  final displayName = stdin.readLineSync()!.trim();

  if (appName.isEmpty || displayName.isEmpty) {
    print('❌ Nama projek dan nama aplikasi tidak boleh kosong.');
    exit(1);
  }

  final oldPackage = 'flutter_getx_starter';

  // 1️⃣ Ganti name di pubspec.yaml
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    var content = await pubspec.readAsString();
    content = content.replaceAll(RegExp(r'name:\s+[\w_]+'), 'name: $appName');
    await pubspec.writeAsString(content);
    print('✅ pubspec.yaml diperbarui');
  }

  // 2️⃣ Ganti applicationId di build.gradle
  final gradle = File('android/app/build.gradle');
  if (gradle.existsSync()) {
    var content = await gradle.readAsString();
    content = content.replaceAllMapped(
      RegExp(r'applicationId\s+"([^"]+)"'),
      (match) => 'applicationId "com.example.$appName"',
    );
    await gradle.writeAsString(content);
    print('✅ build.gradle diperbarui');
  }

  // 3️⃣ Ganti package di AndroidManifest.xml
  final manifest = File('android/app/src/main/AndroidManifest.xml');
  if (manifest.existsSync()) {
    var content = await manifest.readAsString();
    content = content.replaceAllMapped(RegExp(r'package="([^"]+)"'), (match) => 'package="com.example.$appName"');
    await manifest.writeAsString(content);
    print('✅ AndroidManifest.xml diperbarui');
  }

  // 4️⃣ Ganti App Name di Android strings.xml
  final strings = File('android/app/src/main/res/values/strings.xml');
  if (strings.existsSync()) {
    var content = await strings.readAsString();
    content = content.replaceAllMapped(
      RegExp(r'<string name="app_name">(.+?)<\/string>'),
      (match) => '<string name="app_name">$displayName</string>',
    );
    await strings.writeAsString(content);
    print('✅ strings.xml (App Name Android) diperbarui');
  }

  // 5️⃣ Rename folder Kotlin package
  final oldKotlin = Directory('android/app/src/main/kotlin/com/example/$oldPackage');
  if (oldKotlin.existsSync()) {
    final newKotlin = Directory('android/app/src/main/kotlin/com/example/$appName');
    await newKotlin.parent.create(recursive: true);
    await oldKotlin.rename(newKotlin.path);
    print('✅ Folder Kotlin diubah');
  }

  // 6️⃣ Ganti Info.plist (iOS)
  final infoPlist = File('ios/Runner/Info.plist');
  if (infoPlist.existsSync()) {
    var content = await infoPlist.readAsString();
    content = content
        .replaceAllMapped(
          RegExp(r'<key>CFBundleName<\/key>\s*<string>.*<\/string>'),
          (match) => '<key>CFBundleName</key>\n\t<string>$displayName</string>',
        )
        .replaceAllMapped(
          RegExp(r'<key>CFBundleDisplayName<\/key>\s*<string>.*<\/string>'),
          (match) => '<key>CFBundleDisplayName</key>\n\t<string>$displayName</string>',
        );
    await infoPlist.writeAsString(content);
    print('✅ Info.plist diperbarui');
  }

  // 7️⃣ Update Bundle Identifier di project.pbxproj (iOS)
  final pbxproj = File('ios/Runner.xcodeproj/project.pbxproj');
  if (pbxproj.existsSync()) {
    var content = await pbxproj.readAsString();
    content = content.replaceAll(
      RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = [^;]+;'),
      'PRODUCT_BUNDLE_IDENTIFIER = com.example.$appName;',
    );
    await pbxproj.writeAsString(content);
    print('✅ Bundle Identifier (iOS) diperbarui');
  }

  // 8️⃣ Ganti semua import "package:flutter_getx_starter" di seluruh proyek
  final dirsToScan = ['lib', 'test', 'integration_test'];
  int fileCount = 0;
  for (final dirName in dirsToScan) {
    final dir = Directory(dirName);
    if (dir.existsSync()) {
      await for (final file in dir.list(recursive: true, followLinks: false)) {
        if (file is File && file.path.endsWith('.dart')) {
          var content = await file.readAsString();
          if (content.contains("package:$oldPackage")) {
            content = content.replaceAll("package:$oldPackage", "package:$appName");
            await file.writeAsString(content);
            fileCount++;
          }
        }
      }
    }
  }
  print('✅ Semua import package diubah ($fileCount file)');

  print('\n🎉 Setup selesai untuk $appName!');
  print('📦 Jalankan perintah berikut:');
  print('flutter clean && flutter pub get');
}
