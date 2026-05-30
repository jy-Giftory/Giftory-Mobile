import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/text_form_field/text_form_field.dart';
import 'package:giftory/features/auth/presentation/providers/auth_provider.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _verificationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _verificationController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (_passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입에 실패했습니다: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: '이메일',
                        hintText: 'abcd@gmail.com',
                        enabledBorder: _outlineBorder(),
                        border: _outlineBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '인증하기',
                      style: GiftoryTextStyle.small1.copyWith(
                        color: GiftoryColor.moca700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: _verificationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '인증번호 확인',
                  enabledBorder: _outlineBorder(),
                  border: _outlineBorder(),
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '특수문자 포함 8자리 이상',
                  enabledBorder: _outlineBorder(),
                  border: _outlineBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: GiftoryColor.gray400,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: _passwordConfirmController,
                obscureText: _obscurePasswordConfirm,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  hintText: '특수문자 포함 8자리 이상',
                  enabledBorder: _outlineBorder(),
                  border: _outlineBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePasswordConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: GiftoryColor.gray400,
                      size: 20,
                    ),
                    onPressed: () => setState(
                      () => _obscurePasswordConfirm = !_obscurePasswordConfirm,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GiftoryButton(
                label: '회원가입 하기',
                onPressed: _isLoading ? null : _onRegister,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: GiftoryColor.gray200),
      );
}
