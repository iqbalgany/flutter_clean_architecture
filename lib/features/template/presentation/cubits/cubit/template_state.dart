// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_cubit.dart';

class TemplateState extends Equatable {
  final TemplateEntity? template;
  final Failure? failure;
  final String? errorMessage;
  const TemplateState({this.template, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [template, failure, errorMessage];

  TemplateState copyWith({
    TemplateEntity? template,
    Failure? failure,
    String? errorMessage,
  }) {
    return TemplateState(
      template: template ?? this.template,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
