import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/presentation/pages/home/widgets/ad_banner.dart';
import 'package:cullinarium/presentation/pages/home/widgets/lists/category_list.dart';
import 'package:cullinarium/presentation/pages/home/widgets/lists/popular_food_list.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/menu.png',
            width: 24,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/icons/location.png',
                  scale: 2.5,
                ),
              ),
              TextSpan(
                text: ' ул. Маяковская 145',
                style: theme.textTheme.titleSmall!.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/temp/profile.png',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Привет Аяна!',
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Не жди, заказывай вкусную еду',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AdBanner(),

              const SizedBox(height: 20),
              CategoryList(),
              const SizedBox(height: 20),
              PopularFoodList()

            ],
          ),
        ),
      ),
    );
  }
}
