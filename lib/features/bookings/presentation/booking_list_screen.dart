import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';
import 'booking_details_screen.dart';

class BookingsListScreen extends StatefulWidget {
  const BookingsListScreen({super.key});

  @override
  State<BookingsListScreen> createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final state = context.read<BookingBloc>().state;
    String activeFilter = 'All';
    if (state is BookingLoaded) {
      activeFilter = state.activeFilter;
    }
    context.read<BookingBloc>().add(FilterBookingsEvent(
          query: _searchController.text,
          statusFilter: activeFilter,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(
        title: _isSearchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (_) => _applyFilter(),
              )
            : const Text('My Bookings', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF3B137B),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(_isSearchVisible ? Icons.close : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                if (_isSearchVisible) {
                  _searchController.clear();
                  _applyFilter();
                }
                _isSearchVisible = !_isSearchVisible;
              });
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        toolbarHeight: 80,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            child: BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                int total = 0, pending = 0, confirmed = 0, completed = 0, cancelled = 0;
                if (state is BookingLoaded) {
                  total = state.allBookings.length;
                  pending = state.allBookings.where((b) => b.status == 'Pending').length;
                  confirmed = state.allBookings.where((b) => b.status == 'Confirmed').length;
                  completed = state.allBookings.where((b) => b.status == 'Completed').length;
                  cancelled = state.allBookings.where((b) => b.status == 'Cancelled').length;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAppBarStat(total.toString(), 'Total', Colors.amber),
                    _buildAppBarStat(pending.toString(), 'Pending', Colors.orange),
                    _buildAppBarStat(completed.toString(), 'Completed', Colors.green),
                    _buildAppBarStat(cancelled.toString(), 'Cancel', Colors.red),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Search Category Status Rows Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  String activeFilter = 'All';
                  if (state is BookingLoaded) activeFilter = state.activeFilter;

                  return Row(
                    children: ['All', 'Pending', 'Confirmed', 'Completed', 'Cancelled'].map((status) {
                      bool isActive = activeFilter == status;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(status),
                          labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black87),
                          selected: isActive,
                          selectedColor: const Color(0xFF3B137B),
                          backgroundColor: Colors.white,
                          checkmarkColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onSelected: (val) {
                            context.read<BookingBloc>().add(FilterBookingsEvent(
                                  query: _searchController.text,
                                  statusFilter: status,
                                ));
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Central Data Content List Engine Container
            Expanded(
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is BookingEmpty || (state is BookingLoaded && state.filteredBookings.isEmpty)) {
                    return const Center(child: Text('No matching records found.'));
                  }
                  if (state is BookingLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<BookingBloc>().add(LoadBookingsEvent());
                      },
                      child: ListView.builder(
                        itemCount: state.filteredBookings.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemBuilder: (context, index) {
                          final item = state.filteredBookings[index];
                          return Hero(
                            tag: 'booking-${item.id}',
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 2,
                              shadowColor: Colors.black12,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BookingDetailsScreen(booking: item)),
                                  );
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color(0xFF3B137B).withOpacity(0.1),
                                        child: Text(item.customerName[0],
                                            style: const TextStyle(color: Color(0xFF3B137B), fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: Text(item.customerName,
                                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(item.duration, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.home, size: 14, color: Colors.black),
                                                          const SizedBox(width: 4),
                                                          Text(item.serviceName,
                                                              style: const TextStyle(
                                                                  fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 4.0),
                                                      child: Text('₹${item.totalAmount.toInt()}',
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF3B137B))),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    _buildStatusBadge(item.status),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(Icons.calendar_today, size: 14, color: Colors.black),
                                                const SizedBox(width: 4),
                                                Text(item.date, style: const TextStyle(color: Colors.black, fontSize: 13)),
                                                const SizedBox(width: 12),
                                                const Icon(Icons.access_time, size: 14, color: Colors.black),
                                                const SizedBox(width: 4),
                                                Text(item.time, style: const TextStyle(color: Colors.black, fontSize: 13)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarStat(String value, String label, Color indicator) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 2),
        Row(
          children: [
            CircleAvatar(radius: 3, backgroundColor: indicator),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        )
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'confirmed':
        color = Colors.green;
        break;
      case 'completed':
        color = Colors.blue;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'in progress':
        color = Colors.deepPurple;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
