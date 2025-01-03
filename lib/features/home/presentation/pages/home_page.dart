import 'package:flutter/material.dart';
import 'package:mvvm/core/styles/app_colors.dart';
import 'package:mvvm/core/styles/app_font_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello, Anne',
                            style: TextStyle(
                              fontSize: AppFontSize.medium,
                              color: AppColors.grey500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              'What would you like to cook today?',
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: AppFontSize.xxLarge,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search any recipes',
                      hintStyle: const TextStyle(
                        fontSize: AppFontSize.medium,
                        color: AppColors.grey500,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.grey500,
                      ),
                      suffixIcon: const Icon(
                        Icons.filter_alt,
                        color: AppColors.grey600,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SectionTitle(title: 'Categories', onTap: () {}),
                  TabBar(
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        setState(() { 
                          _selectedIndex = index;
                        });
                      },
                      isScrollable: true,
                      indicator: const BoxDecoration(),
                      unselectedLabelColor: AppColors.black,
                      unselectedLabelStyle: const TextStyle(
                          fontSize: AppFontSize.large,
                          fontWeight: FontWeight.normal),
                      labelStyle: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontSize.large,
                          fontWeight: FontWeight.bold),
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        CategoryCard(
                          title: 'Breakfast',
                          icon: Icons.breakfast_dining,
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/512/6192/6192074.png',
                          isSelected: _selectedIndex == 0,
                        ),
                        CategoryCard(
                          title: 'Lunch',
                          icon: Icons.lunch_dining,
                          imageUrl: '',
                          isSelected: _selectedIndex == 1,
                        ),
                        CategoryCard(
                          title: 'Dinner',
                          icon: Icons.dinner_dining,
                          imageUrl: '',
                          isSelected: _selectedIndex == 2,
                        ),
                        CategoryCard(
                          title: 'Dessert',
                          icon: Icons.icecream,
                          imageUrl: '',
                          isSelected: _selectedIndex == 3,
                        ),
                      ]),
                 
                  const SizedBox(height: 18),
                  SectionTitle(title: 'Recommendation', onTap: () {}),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        RecipeCard(
                          title: 'Creamy Pasta',
                          author: 'David Charles',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                        RecipeCard(
                          title: 'Macarons',
                          author: 'Rachel William',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                        RecipeCard(
                          title: 'Chicken Salad',
                          author: 'Sam Green',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SectionTitle(title: 'Recipes Of The Week', onTap: () {}),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        RecipeCard(
                          title: 'Vegan Bowl',
                          author: 'Laura Brown',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                        RecipeCard(
                          title: 'Grilled Salmon',
                          author: 'Mike Adams',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                        RecipeCard(
                          title: 'Chocolate Cake',
                          author: 'Emma Stone',
                          imageUrl:
                              "https://static.vecteezy.com/system/resources/previews/043/290/966/non_2x/fresh-spaghetti-with-pesto-and-cherry-tomatoes-photo.jpg",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(Icons.home), onPressed: () {}),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              const SizedBox(width: 48), // Space for the floating action button
              IconButton(icon: const Icon(Icons.bookmark), onPressed: () {}),
              IconButton(icon: const Icon(Icons.person), onPressed: () {}),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imageUrl;
  final bool isSelected;
  const CategoryCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.imageUrl,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.shade300),
        color: isSelected ? AppColors.primaryColor : AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(icon, size: 32, color: Colors.green),

          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  const RecipeCard(
      {super.key,
      required this.title,
      required this.author,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'By $author',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionTitle({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('See all'),
        ),
      ],
    );
  }
}
