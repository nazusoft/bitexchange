### BITEXCHANGE ###

App OpenSource Conversor de Moedas.

Conversor de moedas e bitcoin.

Provedores das informações:

- moedas: currencydatafeed.com
- bitcoin: blockchain.info


### First Start
Para iniciar o projeto utilizando docker|docker-compose

```
docker-compose build

docker-compose run --rm app bundle install

docker-compose run --rm app bundle exec rails db:create db:migrate

docker-compose up
```
