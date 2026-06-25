class BookingModel {
  final String id;
  final String customerName;
  final String email;
  final String phone;
  final String serviceName;
  final String duration;
  final String date;
  final String time;
  final String location;
  final String attendees;
  final double serviceFee;
  final double platformFee;
  final double gst;
  final double totalAmount;
  final String? specialInstructions;
  final String status; // Pending, Confirmed, Completed

  const BookingModel({
    required this.id,
    required this.customerName,
    required this.email,
    required this.phone,
    required this.serviceName,
    required this.duration,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
    required this.serviceFee,
    required this.platformFee,
    required this.gst,
    required this.totalAmount,
    this.specialInstructions,
    required this.status,
  });

  BookingModel copyWith({String? status}) {
    return BookingModel(
      id: id,
      customerName: customerName,
      email: email,
      phone: phone,
      serviceName: serviceName,
      duration: duration,
      date: date,
      time: time,
      location: location,
      attendees: attendees,
      serviceFee: serviceFee,
      platformFee: platformFee,
      gst: gst,
      totalAmount: totalAmount,
      specialInstructions: specialInstructions,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'customerName': customerName,
    'email': email,
    'phone': phone,
    'serviceName': serviceName,
    'duration': duration,
    'date': date,
    'time': time,
    'location': location,
    'attendees': attendees,
    'serviceFee': serviceFee,
    'platformFee': platformFee,
    'gst': gst,
    'totalAmount': totalAmount,
    'specialInstructions': specialInstructions,
    'status': status,
  };

  factory BookingModel.fromMap(Map<String, dynamic> map) => BookingModel(
    id: map['id'],
    customerName: map['customerName'],
    email: map['email'],
    phone: map['phone'],
    serviceName: map['serviceName'],
    duration: map['duration'],
    date: map['date'],
    time: map['time'],
    location: map['location'],
    attendees: map['attendees'],
    serviceFee: map['serviceFee'],
    platformFee: map['platformFee'],
    gst: map['gst'],
    totalAmount: map['totalAmount'],
    specialInstructions: map['specialInstructions'],
    status: map['status'],
  );
}
