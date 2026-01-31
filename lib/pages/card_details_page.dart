import 'package:flutter/material.dart';
import 'package:trilhaapp/models/card_details_model.dart';

class CardDetailsPage extends StatefulWidget {
  final CardDetailsModel cardDetail;
  const CardDetailsPage({super.key, required this.cardDetail});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Hero cria transações entre telas
    return Hero(
      tag: widget.cardDetail.id,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.close)),
                Row(
                  children: [
                    Image.asset(
                      widget.cardDetail.url,
                      height: 100,
                    ),
                  ],
                ),
                Text(
                      widget.cardDetail.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    widget.cardDetail.text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}