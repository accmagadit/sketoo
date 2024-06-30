import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/role/cubit/role_cubit.dart';
import 'package:sketoo/ui/screen/information/input_player.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/typograhpy.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});
  static const routename = "/role_screen";

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBackgroundInformation),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgLogoApp),
                      ),
                    ),
                  ),
                ],
              ).animate().scale(duration: 1500.ms, curve: Curves.bounceOut),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Main sama siapa?",
                  style: juaBlack20,
                ),
              ).animate().scale(duration: 1500.ms, curve: Curves.bounceOut),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, InputPlayer.routename);
                        context.read<RoleCubit>().isOrangtua(false);
                      },
                      child: Image.asset(roleTeman)),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, InputPlayer.routename);
                        context.read<RoleCubit>().isOrangtua(true);
                      },
                      child: Image.asset(roleOrangTua))
                ],
              ).animate().scale(duration: 1500.ms, curve: Curves.bounceOut),
            ],
          ),
        ),
      ),
    );
  }
}
