import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class CategoryBottomSheet extends StatefulWidget {
  final selectCategory;
  CategoryBottomSheet({Key? key, this.selectCategory}) : super(key: key);

  @override
  _CategoryBottomSheetState createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  List<String> _categories = [];
  int? _selectedIndexForCat;

  @override
  void initState() {
    super.initState();
    Categories.categoriesNames.forEach(
      (key, value) {
        _categories.add(value);
      },
    );
  }

  List<Widget> get categories {
    List<Widget> _temp = [];
    for (int i = 0; i < _categories.length; i++) {
      _temp.add(
        InkWell(
          onTap: () {
            selectedCategory(i);
            widget.selectCategory(i);
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              _categories[i],
              style: TextStyle(
                fontSize: _selectedIndexForCat == i ? 18 : 16,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            trailing: _selectedIndexForCat == i
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: kPrimaryColor100,
                    child: Icon(
                      Icons.check_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
      );
    }
    return _temp;
  }

  void selectedCategory(int index) {
    setState(() {
      _selectedIndexForCat = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: categories,
          ),
        ),
      ],
    );
  }
}
