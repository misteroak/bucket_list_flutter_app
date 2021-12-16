import 'package:logger/logger.dart';

final PrettyPrinter _logPrettyPrinter = PrettyPrinter(
  noBoxingByDefault: true,
  methodCount: 0,
);

class AppLogger {
  static final Logger _logger = Logger(printer: _logPrettyPrinter);

  static Logger get logger => _logger;

  // static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
  // static JsonEncoder get jsonEncoder => _encoder;
}
