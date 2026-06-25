import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/booking_repository.dart';
import '../../../models/booking_model.dart';


// Simple base classes without Equatable dependencies
abstract class BookingEvent {}
class LoadBookingsEvent extends BookingEvent {}
class FilterBookingsEvent extends BookingEvent {
  final String query;
  final String statusFilter;
  FilterBookingsEvent({required this.query, required this.statusFilter});
}

class UpdateBookingStatusEvent extends BookingEvent {
  final String bookingId;
  final String newStatus;
  UpdateBookingStatusEvent({required this.bookingId, required this.newStatus});
}

abstract class BookingState {}
class BookingLoading extends BookingState {}
class BookingLoaded extends BookingState {
  final List<BookingModel> allBookings;
  final List<BookingModel> filteredBookings;
  final String activeFilter;
  BookingLoaded({required this.allBookings, required this.filteredBookings, this.activeFilter = 'All'});
}
class BookingEmpty extends BookingState {}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;

  BookingBloc({required this.repository}) : super(BookingLoading()) {
    on<LoadBookingsEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final list = await repository.getAllBookings();
        if (list.isEmpty) {
          emit(BookingEmpty());
        } else {
          emit(BookingLoaded(allBookings: list, filteredBookings: list));
        }
      } catch (_) {
        emit(BookingEmpty());
      }
    });

    on<FilterBookingsEvent>((event, emit) {
      if (state is BookingLoaded) {
        final currentState = state as BookingLoaded;
        List<BookingModel> filtered = currentState.allBookings.where((booking) {
          final matchesSearch = booking.customerName.toLowerCase().contains(event.query.toLowerCase());
          final matchesStatus = event.statusFilter == 'All' || booking.status.toLowerCase() == event.statusFilter.toLowerCase();
          return matchesSearch && matchesStatus;
        }).toList();

        emit(BookingLoaded(
          allBookings: currentState.allBookings,
          filteredBookings: filtered,
          activeFilter: event.statusFilter,
        ));
      }
    });

    on<UpdateBookingStatusEvent>((event, emit) async {
      try {
        await repository.updateBookingStatus(event.bookingId, event.newStatus);
        add(LoadBookingsEvent());
      } catch (_) {}
    });
  }
}



