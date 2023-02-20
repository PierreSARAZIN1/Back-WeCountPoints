# WeCount Points 🎾 - API

Cette application Ruby On Rails est le backend de l'application front React JS: https://github.com/PierreSARAZIN1/Front-WeCountPoints

L'application front permet d'envoyer les données nécessaires à l'API pour simuler un match de tennis entre deux joueurs. Voici ce qu'il se passe côté back :

- `Création d'un match : `
  Méthode "create"
  app/controllers/matches_controller.rb
- `Création des joueurs : `
  Méthode "create"
  app/controllers/players_controller.rb
  app/models/player.rb
- `Réception de 150 points à envoyer depuis le frontend :`
  Méthode "create"
  app/controllers/points_controller.rb
  app/models/point.rb
- `Visualisation de l'état du match : `
  Méthode "show"
  app/controllers/matches_controller.rb

Le détail des tables se trouve dans : `db/schema.rb` une fois que l'on a effectué les migrations.

Comme vu précédemment la plupart du code se trouve dans les controllers et dans les models (`app/controllers` & `app/models`)

Pour lancer l'application en local il suffit de faire les commandes suivantes :

- `bundle install`
- `rails db:create db:migrate`
- `rails s`

### Informations techniques :

- Version de Ruby : 2.7.4
- Version de Rails : 7.0.3
- Base de donnée : PostgreSQL

### ⚠ Attention

L'application front communique avec l'API.

- Il est nécessaire d'avoir lancé cette application Ruby On Rails en local au préalable
- Il est possible de modifier l'url du backend dans `src/stores/api_url.js` de l'application front.

---

### Pierre SARAZIN
