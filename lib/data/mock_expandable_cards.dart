import 'package:encora_community/models/expandable_card_model.dart';
import 'package:flutter/material.dart';

final List<ExpandableCardModel> mockExpandableCards = [
  ExpandableCardModel(
    leadingIcon: Icons.phone_android,
    title: 'TMA Mobile',
    subtitle: '4 integrantes',
    trailingText: '80%',
    details: [
      'Responsável pela construção das interfaces mobile.',
      'Utiliza Flutter para criar as telas do aplicativo.',
      'Foca em melhorar a experiência do usuário.',
    ],
  ),
  ExpandableCardModel(
    leadingIcon: Icons.storage,
    title: 'TMA Backend',
    subtitle: '4 integrantes',
    trailingText: '70%',
    details: [
      'Desenvolve as APIs e servidores necessários.',
      'Trabalha com Node.js e banco de dados.',
      'Garante a segurança e escalabilidade do sistema.',
    ],
  ),
  ExpandableCardModel(
    leadingIcon: Icons.code,
    title: 'TMA Frontend',
    subtitle: '2 integrantes',
    trailingText: '60%',
    details: [
      'Desenvolve funcionalidades para Android e iOS.',
      'Faz a integração entre o app e o back-end.',
      'Trabalha na performance do aplicativo.',
    ],
  ),
  ExpandableCardModel(
    leadingIcon: Icons.assignment_turned_in,
    title: 'QA Team',
    subtitle: '1 integrantes',
    trailingText: '90%',
    details: [
      'Realiza os testes de qualidade do produto.',
      'Trabalha com automação de testes e testes manuais.',
      'Garante que o produto esteja livre de bugs.',
    ],
  ),
  ExpandableCardModel(
    leadingIcon: Icons.design_services,
    title: 'Design Team',
    subtitle: '1 integrantes',
    trailingText: '85%',
    details: [
      'Responsável pelo design de UI/UX.',
      'Faz a criação de protótipos e testes de usabilidade.',
      'Colabora com o time de Front-End para a implementação do design.',
    ],
  ),
];
