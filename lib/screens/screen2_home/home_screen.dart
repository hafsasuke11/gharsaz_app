import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/services_provider.dart';

import '../../widgets/service_card.dart';
import '../../widgets/side_drawer.dart';

import '../../utils/page_transition.dart';

import '../screen4_service_detail/service_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider =
    context.watch<AuthProvider>();

    final servicesProvider =
    context.watch<ServicesProvider>();

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    final services =
    servicesProvider
        .filteredServices
        .where(
          (service) =>
      service.name
          .trim()
          .isNotEmpty,
    )
        .toList();

    final categories = [
      'All',
      'Cleaning',
      'Repair',
      'Painting',
      'Electrical',
      'Plumbing',
      'Shifting',
      'CCTV',
    ];

    return Scaffold(
      drawer: const SideDrawer(),

      appBar: AppBar(
        title: Text(
          'GharSaz',

          style: TextStyle(
            color: isDark
                ? Colors.white
                : Colors.black,

            fontWeight:
            FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.all(
            20,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [
              Text(
                'Hello, ${authProvider.userName} 👋',

                style: TextStyle(
                  fontSize: 34,

                  fontWeight:
                  FontWeight.bold,

                  color: isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                'Find trusted professionals for your home.',

                style: TextStyle(
                  color: isDark
                      ? Colors.white70
                      : Colors.grey,

                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                decoration:
                BoxDecoration(
                  color:
                  Theme.of(context)
                      .cardColor,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),

                child: TextField(
                  style: TextStyle(
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),

                  onChanged: (value) {
                    servicesProvider
                        .searchServices(
                      value,
                    );
                  },

                  decoration:
                  InputDecoration(
                    border:
                    InputBorder.none,

                    icon: Icon(
                      Icons.search,

                      color: isDark
                          ? Colors.white
                          : Colors.black,
                    ),

                    hintText:
                    'Search services...',

                    hintStyle:
                    TextStyle(
                      color: isDark
                          ? Colors.white70
                          : Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              SizedBox(
                height: 50,

                child: ListView.separated(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  categories.length,

                  separatorBuilder:
                      (
                      context,
                      index,
                      ) {
                    return const SizedBox(
                      width: 10,
                    );
                  },

                  itemBuilder:
                      (
                      context,
                      index,
                      ) {
                    final category =
                    categories[
                    index];

                    final isSelected =
                        servicesProvider
                            .selectedCategory ==
                            category;

                    return GestureDetector(
                      onTap: () {
                        servicesProvider
                            .filterByCategory(
                          category,
                        );
                      },

                      child: AnimatedContainer(
                        duration:
                        const Duration(
                          milliseconds:
                          250,
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal:
                          20,

                          vertical: 12,
                        ),

                        decoration:
                        BoxDecoration(
                          color: isSelected
                              ? Colors.green
                              : Theme.of(
                              context)
                              .cardColor,

                          borderRadius:
                          BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: Text(
                          category,

                          style:
                          TextStyle(
                            color:
                            isSelected
                                ? Colors
                                .white
                                : isDark
                                ? Colors
                                .white
                                : Colors
                                .black,

                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(
                  24,
                ),

                decoration:
                BoxDecoration(
                  gradient:
                  const LinearGradient(
                    colors: [
                      Color(
                        0xFF166534,
                      ),
                      Color(
                        0xFF22C55E,
                      ),
                    ],
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    32,
                  ),
                ),

                child: Row(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.all(
                        20,
                      ),

                      decoration:
                      BoxDecoration(
                        color: Colors
                            .white24,

                        borderRadius:
                        BorderRadius.circular(
                          22,
                        ),
                      ),

                      child: const Icon(
                        Icons.work,

                        color:
                        Colors.white,

                        size: 34,
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          Text(
                            'Premium Home Services',

                            style:
                            TextStyle(
                              color: Colors
                                  .white,

                              fontSize:
                              26,

                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Text(
                            'Trusted professionals at your doorstep.',

                            style:
                            TextStyle(
                              color: Colors
                                  .white70,

                              fontSize:
                              16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 36,
              ),

              Text(
                'Popular Services',

                style: TextStyle(
                  fontSize: 24,

                  fontWeight:
                  FontWeight.bold,

                  color: isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              GridView.builder(
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount:
                services.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 18,

                  mainAxisSpacing: 18,

                  childAspectRatio: 0.82,
                ),

                itemBuilder:
                    (
                    context,
                    index,
                    ) {
                  final service =
                  services[index];

                  return ServiceCard(
                    service: service,

                    onTap: () {
                      Navigator.push(
                        context,

                        PageTransition.slide(
                          ServiceDetailScreen(
                            service:
                            service,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}