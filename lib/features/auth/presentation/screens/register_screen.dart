import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/text_form_field/text_form_field.dart';
import 'package:giftory/features/auth/presentation/providers/auth_provider.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/core/components/giftory_snack_bar.dart';

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
  bool _isSendingCode = false;
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

  Future<void> _onSendVerification() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      GiftorySnackBar.show(context, '올바른 이메일을 입력해주세요.');
      return;
    }
    setState(() => _isSendingCode = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .sendVerification(email);
      if (mounted) {
        GiftorySnackBar.show(context, '인증코드를 메일로 보냈어요.');
      }
    } catch (e) {
      if (mounted) {
        GiftorySnackBar.show(context, '인증코드 발송에 실패했습니다');
      }
    } finally {
      if (mounted) setState(() => _isSendingCode = false);
    }
  }

  Future<void> _onRegister() async {
    final password = _passwordController.text;
    if (_verificationController.text.trim().isEmpty) {
      GiftorySnackBar.show(context, '이메일 인증코드를 입력해주세요.');
      return;
    }
    if (password.length < 8 ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      GiftorySnackBar.show(context, '비밀번호는 특수문자를 포함하여 8자리 이상이어야 합니다.');
      return;
    }
    if (password != _passwordConfirmController.text) {
      GiftorySnackBar.show(context, '비밀번호가 일치하지 않습니다.');
      return;
    }
    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).signup(
            email: _emailController.text.trim(),
            verificationCode: _verificationController.text.trim(),
            password: _passwordController.text,
            passwordConfirm: _passwordConfirmController.text,
          );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        GiftorySnackBar.show(context, '회원가입에 실패했습니다: ${_msg(e)}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _msg(Object e) =>
      e.toString().replaceFirst('예외상황 발생: ', '');

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
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: _isSendingCode ? null : _onSendVerification,
                    child: Text(
                      _isSendingCode ? '발송중…' : '인증하기',
                      style: GiftoryTextStyle.small1.copyWith(
                        color: context.appColors.c700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              CustomTextFormField(
                controller: _verificationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '인증번호 확인',
                  enabledBorder: _outlineBorder(),
                  border: _outlineBorder(),
                ),
              ),
              SizedBox(height: 12),
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
              SizedBox(height: 12),
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
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: GiftoryColor.gray200),
  );
}
