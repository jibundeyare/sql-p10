# Notes

## Suppression de toutes les tables

- choisir la BDD
- en bas de la liste des tables, cocher « Tout cocher » 
- dans la liste déroulante « Avec la sélection », choisir « Supprimer » dans la section « Supprimer les données ou la table »
- une page s'affiche avec une requête de type `DROP TABLE foo, bar, baz;`
- décocher la case «  Activer la vérification des clés étrangères  » et cliquer sur « Oui »

## Export

### Structure et données

- choisir la BDD et cliquer sur « Export »
- appliquer les options suivantes :
  - dans la section « Méthode d'exportation », cocher :
    - « Personnalisée »
  - dans la section « Options spécifiques au format », cocher :
    - « Désactiver la vérification des clés étrangères »
  - dans la section « Options de création d'objets », cocher :
    - « Ajouter une instruction CREATE DATABASE / USE »
    - « Ajouter une instruction DROP TABLE / VIEW / PROCEDURE / FUNCTION / EVENT / TRIGGER »
- cliquer sur exécuter

### Structure seule

- choisir la BDD et cliquer sur « Export »
- appliquer les options suivantes :
  - dans la section « Méthode d'exportation », cocher :
    - « Personnalisée »
  - dans la sectiob « Tables », **décochez** :
    - « Données »
  - dans la section « Options spécifiques au format », cocher :
    - « Désactiver la vérification des clés étrangères »
  - dans la section « Options de création d'objets », cocher :
    - « Ajouter une instruction CREATE DATABASE / USE »
    - « Ajouter une instruction DROP TABLE / VIEW / PROCEDURE / FUNCTION / EVENT / TRIGGER »
- cliquer sur exécuter
- ajoutez le suffixe `-structure` au fichier pour clarifier qu'il ne contient que la structure

### Données seules

- choisir la BDD et cliquer sur « Export »
- appliquer les options suivantes :
  - dans la section « Méthode d'exportation » cocher :
    - « Personnalisée »
  - dans la sectiob « Tables », **décochez** :
    - « Structure »
  - dans la section « Options spécifiques au format » cocher :
    - « Désactiver la vérification des clés étrangères »
  - dans la section « Options de création de données » cocher :
    - « Tronquer la table avant d'insérer »
- cliquer sur exécuter
- ajoutez le suffixe `-data` au fichier pour clarifier qu'il ne contient que la structure

## Import

- choisir la BDD et cliquer sur « Import »
- dans la section « Fichier à importer » choisir le fichier `sql`, `zip` ou `gzip`
- cliquer sur exécuter

Si l'import échoue, essayer l'option suivante :
- dans la section « Autres options » **décocher** :
  - « Activer la vérification des clés étrangères »
- cliquer sur exécuter

## Convention de nommage des contraintes et indexes

Attention : ces conventions ne sont pas forcément respectées pour tous les DBA et tous les dev.
Il s'agit d'une base de travail qui peut être adaptée ou remplacée par une autre.
Le tout est d'avoir un système de nommage cohérent.

- [RootSoft/Database-Naming-Convention: Database Naming Conventions & Best Practices](https://github.com/RootSoft/Database-Naming-Convention)
- [What naming convention do you use for SQL indexes? - Quora](https://www.quora.com/What-naming-convention-do-you-use-for-SQL-indexes)

Proposition :

- clé primaire : pk
- clé étrangère : fk
- index : idx
- unique : uqx
- spatial : spx
- full text : ftx

### Nommage des clés primaires

`pk_[nom de la table]_id`

Exemple :

- table : `post`
- colonne : `id`
- nom de la contrainte : `pk_post_id`

### Nommage des clés étrangères

`fk_[nom de la table]_[nom de la colonne]`

Exemple :

- table : `post`
- colonne : `user_id`
- nom de la contrainte : `fk_post_user_id`

### Nommage des indexes

Sur une colonne : `[type d'index]_[nom de la table]_[nom de la colonne]`

Exemple :

- table : `user`
- colonne : `email`
- type d'index : unique
- nom de l'index : `uqx_user_email_unique`

Sur deux colonnes : `[type d'index]_[nom de la table]_[nom de la 1ère colonne]_[nom de la 2ème colonne]`

Exemple :

- table `post_tag` (table de jointure)
- colonne 1 : `post_id`
- colonne 2 : `tag_id`
- type d'index : `unique`
- nom de l'index : `uqx_post_tag_post_id_tag_id`

