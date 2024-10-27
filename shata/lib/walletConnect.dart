import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletConnect extends StatefulWidget {
  const WalletConnect({Key? key}) : super(key: key);

  @override
  State<WalletConnect> createState() => _WalletConnectState();
}

class _WalletConnectState extends State<WalletConnect> {
  final String apiKey = '41fe071f-091e-4a6e-a342-e108204dea04';
  final String walletAddress = 'TVZnMKWTTpEUniCrBnuSLmkdJvCxisHt6K';

  Future<List<dynamic>> getTransactions() async {
    final apiUrl =
        'https://api.shasta.trongrid.io/v1/accounts/$walletAddress/transactions';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return data['data']['data'];
    } else {
      throw Exception('Failed to load transactions');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRONSCAN Transactions'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final transactions = snapshot.data;
            return ListView.builder(
              itemCount: transactions?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Hash: ${transactions?[index]['txID']}'),
                  subtitle: Text(
                    'Value: ${transactions?[index]['amount']} TRX',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
