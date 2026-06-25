import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings (
        id TEXT PRIMARY KEY,
        customerName TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        serviceName TEXT NOT NULL,
        duration TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        location TEXT NOT NULL,
        attendees TEXT NOT NULL,
        serviceFee REAL NOT NULL,
        platformFee REAL NOT NULL,
        gst REAL NOT NULL,
        totalAmount REAL NOT NULL,
        specialInstructions TEXT,
        status TEXT NOT NULL
      )
    ''');

    // Seed initial app assessment data rows
    final List<Map<String, dynamic>> initialData = [
      {
        'id': 'BK-9942',
        'customerName': 'Rajesh Kumar',
        'email': 'rajesh@email.com',
        'phone': '+91 98765 43210',
        'serviceName': 'Ganesh Homam',
        'duration': '2-3 Hours',
        'date': '08 June 2024',
        'time': '10:00 AM',
        'location': "Rajesh's Residence, Adyar, Chennai, Tamil Nadu",
        'attendees': '~15 persons',
        'serviceFee': 42000.0,
        'platformFee': 1500.0,
        'gst': 2500.0,
        'totalAmount': 46000.0,
        'specialInstructions': 'Customer requested traditional Vedic setup of Ganesh Ashtothram.',
        'status': 'Pending'
      },
      {
        'id': 'BK-9943',
        'customerName': 'Priya Basu',
        'email': 'priya@email.com',
        'phone': '+91 98765 43211',
        'serviceName': 'Ganesh Homam',
        'duration': '3-4 Hours',
        'date': '10 June 2024',
        'time': '09:00 AM',
        'location': "Priya's Residence, T.Nagar, Chennai",
        'attendees': '~25 persons',
        'serviceFee': 32000.0,
        'platformFee': 1200.0,
        'gst': 1800.0,
        'totalAmount': 35000.0,
        'specialInstructions': 'Traditional setup.',
        'status': 'Pending'
      },
      {
        'id': 'BK-9944',
        'customerName': 'Arun Sharma',
        'email': 'arun@email.com',
        'phone': '+91 98765 43212',
        'serviceName': 'Ganesh Homam',
        'duration': '4-5 Hours',
        'date': '12 June 2024',
        'time': '06:00 AM',
        'location': "Arun's Residence, Velachery, Chennai",
        'attendees': '~50 persons',
        'serviceFee': 52000.0,
        'platformFee': 2000.0,
        'gst': 3000.0,
        'totalAmount': 57000.0,
        'specialInstructions': 'Full Vedic rituals.',
        'status': 'Confirmed'
      },
      {
        'id': 'BK-9945',
        'customerName': 'Kavita Nair',
        'email': 'kavita@email.com',
        'phone': '+91 98765 43213',
        'serviceName': 'Ganesh Homam',
        'duration': '5-6 Hours',
        'date': '15 June 2024',
        'time': '08:00 AM',
        'location': "Kavita's Residence, OMR, Chennai",
        'attendees': '~100 persons',
        'serviceFee': 72000.0,
        'platformFee': 3000.0,
        'gst': 4500.0,
        'totalAmount': 79500.0,
        'specialInstructions': 'Grand wedding setup.',
        'status': 'Completed'
      },
      {
        'id': 'BK-9946',
        'customerName': 'Amit Patel',
        'email': 'amit@email.com',
        'phone': '+91 98765 43214',
        'serviceName': 'Ganesh Homam',
        'duration': '3 Hours',
        'date': '18 June 2024',
        'time': '07:30 AM',
        'location': "Amit's Villa, ECR, Chennai",
        'attendees': '~10 persons',
        'serviceFee': 35000.0,
        'platformFee': 1500.0,
        'gst': 2100.0,
        'totalAmount': 38600.0,
        'status': 'Pending'
      },
      {
        'id': 'BK-9947',
        'customerName': 'Suresh Raina',
        'email': 'suresh@email.com',
        'phone': '+91 98765 43215',
        'serviceName': 'Ganesh Homam',
        'duration': '4 Hours',
        'date': '20 June 2024',
        'time': '08:00 AM',
        'location': "Raina Estate, Mylapore, Chennai",
        'attendees': '~20 persons',
        'serviceFee': 45000.0,
        'platformFee': 2000.0,
        'gst': 2700.0,
        'totalAmount': 49700.0,
        'status': 'Confirmed'
      },
      {
        'id': 'BK-9948',
        'customerName': 'Meena Kumari',
        'email': 'meena@email.com',
        'phone': '+91 98765 43216',
        'serviceName': 'Ganesh Homam',
        'duration': '2 Hours',
        'date': '22 June 2024',
        'time': '06:00 PM',
        'location': "Meena's Apartment, Anna Nagar, Chennai",
        'attendees': '~5 persons',
        'serviceFee': 15000.0,
        'platformFee': 500.0,
        'gst': 900.0,
        'totalAmount': 16400.0,
        'status': 'Pending'
      },
      {
        'id': 'BK-9949',
        'customerName': 'Vikram Seth',
        'email': 'vikram@email.com',
        'phone': '+91 98765 43217',
        'serviceName': 'Ganesh Homam',
        'duration': '3 Hours',
        'date': '25 June 2024',
        'time': '09:30 AM',
        'location': "Vikram's House, Besant Nagar, Chennai",
        'attendees': '~15 persons',
        'serviceFee': 28000.0,
        'platformFee': 1000.0,
        'gst': 1680.0,
        'totalAmount': 30680.0,
        'status': 'Confirmed'
      },
      {
        'id': 'BK-9950',
        'customerName': 'Anjali Devi',
        'email': 'anjali@email.com',
        'phone': '+91 98765 43218',
        'serviceName': 'Ganesh Homam',
        'duration': '2 Hours',
        'date': '28 June 2024',
        'time': '10:30 AM',
        'location': "Vedic School, Perungudi, Chennai",
        'attendees': '~30 persons',
        'serviceFee': 12000.0,
        'platformFee': 500.0,
        'gst': 720.0,
        'totalAmount': 13220.0,
        'status': 'Completed'
      },
      {
        'id': 'BK-9951',
        'customerName': 'Rohan Gupta',
        'email': 'rohan@email.com',
        'phone': '+91 98765 43219',
        'serviceName': 'Ganesh Homam',
        'duration': '4 Hours',
        'date': '30 June 2024',
        'time': '07:00 AM',
        'location': "Gupta Residence, Tambaram, Chennai",
        'attendees': '~12 persons',
        'serviceFee': 38000.0,
        'platformFee': 1500.0,
        'gst': 2280.0,
        'totalAmount': 41780.0,
        'status': 'Pending'
      },
    ];

    for (var booking in initialData) {
      await db.insert('bookings', booking);
    }
  }
}

