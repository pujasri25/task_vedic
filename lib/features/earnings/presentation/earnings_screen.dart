import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(
        title: const Text('Earnings', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF3B137B),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 40,  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFF3B137B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                const Text('₹84,500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMiniStat('This Month', '₹12,400'),
                    Container(width: 1, height: 35, color: Colors.white24),
                    _buildMiniStat('Last Month', '₹18,200'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Service Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildPerformanceItem('Homam', '₹48,000', 0.6, Colors.orange),
              _buildPerformanceItem('Puja', '₹24,500', 0.3, Colors.blue),
              _buildPerformanceItem('Grihapravesham', '₹12,000', 0.1, Colors.green),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('View All', style: TextStyle(color: Color(0xFF3B137B), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTransactionItem('Ganesh Homam Payout', '08 June 2024', '+₹42,000', Colors.green),
              _buildTransactionItem('Satyanarayana Puja Payout', '05 June 2024', '+₹12,500', Colors.green),
              _buildTransactionItem('Bank Withdrawal', '01 June 2024', '-₹20,000', Colors.red),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B137B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Withdraw Earnings', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPerformanceItem(String label, String amount, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: color.withOpacity(0.1),
            color: color,
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, Color amountColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: amountColor.withOpacity(0.1),
        child: Icon(amount.startsWith('+') ? Icons.arrow_downward : Icons.arrow_upward, color: amountColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amountColor)),
    );
  }
}
