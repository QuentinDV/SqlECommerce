# Projet E-Commerce

Ce projet génère des données factices pour peupler une base de données d'une boutique en ligne. Il utilise la bibliothèque **Faker** pour générer des utilisateurs, produits, commandes, paniers, évaluations, photos, factures, etc. dans le but de tester une application e-commerce.

## Fonctionnalités

- **Génération d'utilisateurs** : Création de comptes avec des noms d'utilisateur, emails et mots de passe hashés.
- **Produits** : Ajout de produits avec nom, description, prix et stock.
- **Commandes** : Génération de commandes associées aux utilisateurs et paniers.
- **Évaluations** : Attribution d'évaluations de produits avec commentaires.
- **Photos** : Ajout de photos pour les utilisateurs et les produits.
- **Méthodes de paiement** : Création de méthodes de paiement aléatoires pour chaque utilisateur.
- **Factures** : Génération de factures associées aux commandes.

## Installation

### Prérequis
- PHP >= 7.4
- MySQL ou MariaDB
- Composer (pour installer Faker)

### Étapes d'installation

1. Clone ce repository ou télécharge les fichiers.
2. Installe les dépendances via Composer :
   ```bash
   composer install
