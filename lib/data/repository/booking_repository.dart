import '../../core/database/local_database.dart';
import '../../models/booking_model.dart';

class BookingRepository {
  final LocalDatabase dbProvider = LocalDatabase.instance;

  Future<List<BookingModel>> getAllBookings() async {
    final db = await dbProvider.database;
    final result = await db.query('bookings');
    return result.map((json) => BookingModel.fromMap(json)).toList();
  }

  Future<void> updateBookingStatus(String id, String status) async {
    final db = await dbProvider.database;
    await db.update(
      'bookings',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

