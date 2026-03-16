import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {

  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context){

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              Icon(icon,size:40,color:color),

              const SizedBox(height:10),

              Text(title),

              const SizedBox(height:10),

              Text(
                value.toString(),
                style: TextStyle(
                  fontSize:26,
                  fontWeight:FontWeight.bold,
                  color:color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}