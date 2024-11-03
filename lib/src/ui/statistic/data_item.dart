import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../bek/entites/data_item.dart';
import '../item_card.dart';



class DataItemProvider with ChangeNotifier {
  List<DataItem> _dataItems = [];

  List<DataItem> get dataItems => _dataItems;

  void setDataItems(List<DataItem> items) {
    _dataItems = items;
    notifyListeners();
  }
}

class DataItemAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataItemProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.dataItems.length,
          itemBuilder: (context, index) {
            final item = provider.dataItems[index];
            return DataItemCard(dataItem: item);
          },
        );
      },
    );
  }
}
