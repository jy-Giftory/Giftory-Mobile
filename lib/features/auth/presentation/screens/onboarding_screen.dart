import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/app_logo.png',
                width: 180,
                errorBuilder: (context, error, stackTrace) => Text(
                  'Giftory',
                  style: GiftoryTextStyle.header1.copyWith(
                    fontSize: 40,
                    color: GiftoryColor.moca700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'AI 선물 추천 및 기념일 비서',
                style: GiftoryTextStyle.body2.copyWith(
                  color: GiftoryColor.moca700,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '계정이 없다면?  ',
                    style: GiftoryTextStyle.small1.copyWith(
                      color: GiftoryColor.gray500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/register'),
                    child: Text(
                      '회원가입',
                      style: GiftoryTextStyle.small1.copyWith(
                        color: GiftoryColor.moca700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GiftoryButton(
                label: '로그인 하기',
                onPressed: () => context.push('/login'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
