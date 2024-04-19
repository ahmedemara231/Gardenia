abstract class ForgotResetPassStates {}

class ForgotResetPassInitialState extends ForgotResetPassStates {}

class SendCodeToEmailLoading extends ForgotResetPassStates {}

class SendCodeToEmailSuccess extends ForgotResetPassStates {}

class SendCodeToEmailError extends ForgotResetPassStates {}

class SendOtpToEmailSuccess extends ForgotResetPassStates {}

class SendOtpToEmailLoading extends ForgotResetPassStates {}

class SendOtpToEmailError extends ForgotResetPassStates {}

class ResetNewPasswordLoading extends ForgotResetPassStates {}

class ResetNewPasswordSuccess extends ForgotResetPassStates {}

class ResetNewPasswordError extends ForgotResetPassStates {}
