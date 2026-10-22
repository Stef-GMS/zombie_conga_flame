import 'package:google_fonts/google_fonts.dart';
import 'package:zombie_conga_flame/app/app_barrel_file.dart';
import 'package:zombie_conga_flame/bootstrap.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  bootstrap(
    () => const App(),
  );
}
