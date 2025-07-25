import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/people_model.dart';
import '../cubit/people_cubit.dart';
import '../cubit/people_states.dart';
import '../../../../core/const/constants.dart';
import '../../../../core/widgets/search_text_field.dart';
import 'widgets/custom_people_view_appbar.dart';
import 'widgets/people_item.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({super.key});

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
    _loadInitialData();
  }

  @override
  void dispose() {
    _cleanupScrollListener();
    super.dispose();
  }

  // Sets up scroll listener for pagination
  void _setupScrollListener() {
    _scrollController.addListener(_onScroll);
  }

  // Cleans up scroll listener
  void _cleanupScrollListener() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
  }

  // Loads initial data after widget is built
  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PeopleCubit>().getPeople();
    });
  }

  void _onScroll() {
    if (_isNearBottom()) {
      final cubit = context.read<PeopleCubit>();
      if (cubit.hasMorePeople) {
        cubit.getPeople(isNextPage: true);
      }
    }
  }

  bool _isNearBottom() {
    // Trigger pagination 200px before reaching bottom for seamless loading
    const threshold = 200.0;
    return _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [_buildHeader(), _buildPeopleList()]),
      ),
    );
  }

  // Builds the header section with search
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: horizontalPadding),
          const CustomPeopleViewAppbar(),
          SizedBox(height: horizontalPadding),
          const SearchTextField(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Builds the main people list with state management
  Widget _buildPeopleList() {
    return Expanded(
      child: BlocBuilder<PeopleCubit, PeopleStates>(
        builder: (context, state) => state.whenOrNull(
          initial: () => _buildLoadingSkeletons(),
          loading: () => _buildLoadingSkeletons(),
          emptyInput: () => _buildEmptyState(),
          success: (peopleModel, isLoadingMore) =>
              _buildSuccessState(peopleModel, isLoadingMore),
          error: (message) => _buildErrorState(),
        )?? _buildLoadingSkeletons(),

      ),
    );
  }

  // Builds skeleton loading state
  Widget _buildLoadingSkeletons() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) =>
            PeopleFeaturedItem(person: PersonResult()),
      ),
    );
  }

  // Builds empty state when no data found
  Widget _buildEmptyState() {
    return const Center(
      child: Text('No people found', style: TextStyle(color: Colors.white)),
    );
  }

  // Builds success state with people list
  Widget _buildSuccessState(PeopleModel peopleModel, bool isLoadingMore) {
    final people = peopleModel.results ?? [];

    if (people.isEmpty) {
      return const Center(
        child: Text(
          'No people available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Skeletonizer(
      enabled: false,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: people.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) =>
            _buildListItem(people, index, isLoadingMore),
      ),
    );
  }

  // Builds individual list item or loading indicator
  Widget _buildListItem(
    List<PersonResult> people,
    int index,
    bool isLoadingMore,
  ) {
    // Show bottom loading indicator
    if (index >= people.length) {
      return _buildBottomLoadingIndicator();
    }

    return PeopleFeaturedItem(person: people[index]);
  }

  // Builds loading indicator at bottom of list
  Widget _buildBottomLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  // Builds error state with retry option
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Error In Fetching Data',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<PeopleCubit>().getPeople(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
