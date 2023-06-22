import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        bgWidget_child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                mainAxisExtent: 250),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 150,
                  ),
                  20.heightBox,
                  categoriesList[index]
                      .toString()
                      .text
                      .fontFamily(semibold)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .outerShadowSm
                  .rounded
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(
                  CategoryDetails(title: categoriesList[index]),
                );
              });
            })),
      ),
    ));
  }
}
