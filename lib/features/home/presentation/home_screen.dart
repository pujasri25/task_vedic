import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bookings/bloc/booking_bloc.dart';
import '../../bookings/presentation/booking_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      body: SafeArea(
        top: false, // Maintain full-bleed purple header
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            var allBookings = [];
            var pendingBookings = [];
            String total = '0', pending = '0', confirmed = '0', earnings = '8.4K';

            if (state is BookingLoaded) {
              allBookings = state.allBookings;
              total = allBookings.length.toString();
              pending = allBookings.where((b) => b.status == 'Pending').length.toString();
              confirmed = allBookings.where((b) => b.status == 'Confirmed').length.toString();
              pendingBookings = allBookings.reversed.toList(); 
            }

            return CustomScrollView(
              slivers: [
                // Header Section
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B137B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.amber,
                              child: Text('PI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Namaste,', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                Text('Pandit Iyer', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.notifications_outlined, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.circle, color: Colors.green, size: 10),
                              const SizedBox(width: 8),
                              const Text('Available for Bookings', style: TextStyle(color: Colors.white, fontSize: 12)),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                  value: true,
                                  onChanged: (val) {},
                                  activeColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Overview Section Title
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Text("Today's Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),

                // Stats Grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.4,
                    ),
                    delegate: SliverChildListDelegate([
                      _buildDashboardCard(total, 'Total Bookings', const Color(0xFF6236A7), Icons.calendar_today),
                      _buildDashboardCard(pending, 'Pending', Colors.orange, Icons.pending_actions),
                      _buildDashboardCard(confirmed, 'Confirmed', Colors.green, Icons.check_circle_outline),
                      _buildDashboardCard(earnings, 'Earnings', Colors.deepOrangeAccent, Icons.currency_rupee),
                    ]),
                  ),
                ),

                // Muhurtham Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF3B137B), Color(0xFF6236A7)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [
                          Text('Today\'s Muhurtham', style: TextStyle(color: Colors.white70, fontSize: 14)),
                          SizedBox(height: 8),
                          Text('Abhijit Muhurtha', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('11:45 AM - 12:32 PM', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                // New Requests Section Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('New Booking Request', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                // Booking Requests List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: pendingBookings.isEmpty
                      ? const SliverToBoxAdapter(child: Center(child: Text('No bookings found')))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildBookingCard(context, pendingBookings[index]),
                            childCount: pendingBookings.length,
                          ),
                        ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, dynamic booking) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: Colors.grey.shade200, child: Text(booking.customerName[0], style: const TextStyle(color: Color(0xFF3B137B), fontWeight: FontWeight.bold))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(booking.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(booking.serviceName, style: const TextStyle(color: Colors.grey, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  _buildStatusBadge(booking.status),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(booking.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),

                      Text(booking.duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  Text('₹${booking.totalAmount.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B137B))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'confirmed': color = Colors.green; break;
      case 'completed': color = Colors.blue; break;
      case 'pending': color = Colors.orange; break;
      case 'in progress': color = Colors.deepPurple; break;
      case 'cancelled': color = Colors.red; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
