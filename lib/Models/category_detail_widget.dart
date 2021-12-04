import 'package:flutter/material.dart';
import 'category.dart';

class CategoryDetailWidget extends StatelessWidget {
  final Category category;
  final ValueChanged<Category> onSelectedCategory;

  const CategoryDetailWidget({
    Key key,
    @required this.category,
    @required this.onSelectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onSelectedCategory(category),
        child:
            /*Container(
          padding: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //buildImage(),
              SizedBox(height: 12),
              Text(
                category.categoryName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),*/
            Container(
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(12),
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Resolver",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                child: Text(
                  category.categoryName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildImage() => Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
      );
}
