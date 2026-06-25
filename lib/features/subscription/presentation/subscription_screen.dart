import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
        backgroundColor: const Color(0xFF3B137B),
        centerTitle: false,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(100), child: Container(
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
            const Icon(Icons.stars, color: Colors.amber, size: 50),
            SizedBox(height: 10),
            const Text('Upgrade Your Sacred Journey', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white), textAlign: TextAlign.center),
            SizedBox(height: 5),

            const Text('Reach more devotees, reduce commissions and elevate your spiritual practice', style: TextStyle(fontSize: 12,color: Colors.white), textAlign: TextAlign.center),

          ],
        ),
      ),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              _buildPlanCard(
                context,
                'Sacred Basic',
                'Free',
                ['Up to 10 Bookings/month' '15% platform commission', 'Basic profile listing',],
                false,
              ),
              const SizedBox(height: 20),
              _buildPlanCard(
                context,
                'Scared Pro',
                '₹999 /month',
                ['Unlimited Bookings', '15% platform commission', 'Featured profile & Priority Search', '24/7 priority support'],
                true,
              ),
              const SizedBox(height: 20),
              _buildPlanCard(
                context,
                'Sacred Elite',
                '₹2,499 /month',
                ['Everything in  Pro features','only 5% platform commission & Top results', 'Dedicated Account Manager', 'Verified Elite Badges'],
                false,
                isElite: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String price, List<String> features, bool isPopular, {bool isElite = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: isPopular ? Border.all(color: const Color(0xFF3B137B), width: 2) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF3B137B), borderRadius: BorderRadius.circular(20)),
                child: const Text('MOST POPULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF3B137B))),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(f, style: const TextStyle(color: Colors.black87))),
              ],
            ),
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular || isElite ? const Color(0xFF3B137B) : Colors.white,
                foregroundColor: isPopular || isElite ? Colors.white : const Color(0xFF3B137B),
                side: const BorderSide(color: Color(0xFF3B137B)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(isPopular ? 'Current Plan' : 'Choose Plan', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
