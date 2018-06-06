### BITEXCHANGE ###

App OpenSource Conversor de Moedas.

### First Start
Para iniciar o projeto utilizando docker|docker-compose

```
docker-compose build

docker-compose run --rm app bundle install

docker-compose run --rm app bundle exec rails db:create db:migrate

docker-compose up
```
