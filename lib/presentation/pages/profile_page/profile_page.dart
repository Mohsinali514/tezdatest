import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/misc/methods.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/widgets/mybutton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile',),
        ),
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is UserDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailError) {
              return Center(child: Text(state.message.toString()));
            } else if (state is UserDetailLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          CachedNetworkImageProvider(/*state.userEntity.avatar*/'https://i.pravatar.cc'),
                    ),
                    verticalSpace(10),
                    Text(
                      state.userEntity.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      state.userEntity.email,
                      style: const TextStyle(fontSize: 16),
                    ),
                    verticalSpace(30),
                    MyButton(
                      child: const Text('Sign Out'),
                      ontap: () => context.read<AuthBloc>().add(
                            AuthLogoutButtonPressed(),
                          ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
