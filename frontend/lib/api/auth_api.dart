// ถ้าแพลตฟอร์มรองรับ js_interop (เว็บ/wasm) จะเลือกเวอร์ชัน web
// มิฉะนั้นใช้เวอร์ชัน io
export 'auth_api_io.dart'
  if (dart.library.js_interop) 'auth_api_web.dart';
