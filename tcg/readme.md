# Установка стороннего ПО

## MariaDB

- установливаем mariadb из репозитория
- создаём необходимых пользователей и таблицы
```mysql
create user 'username'@localhost;
create database tcg;
grant all privileges on tcg.* to 'username'@localhost with grant option;
flush privileges;

grant all on tcg.* to username@localhost;

show grants for 'username'@localhost;
```
**NB** Необходимые таблицы будут созданы при первом запуске сервиса

# Сборка сервиса

```bash
git clone git@bitbucket.org:tcjwo/tcg.git
git checkout master
go get
go build -o tcg
cp config.sample.json config.json
nano config.json
./tcg -config=./config.json
curl -X POST localhost:8084/v1/health/check
```

# CLI

## Информационные запросы

Чтобы посмотреть помощь:

`tcg -help`

Чтобы получить версию приложения:

`tcg -version`

## Запуск приложения

`tcg -config=./config.json <command>`

Доступные команды <command>:

- start - Запуск в качестве демона
- stop - Остановка демона
- restart - Перезапуск демона
- status - Возвращает состояние демона

Если не указать команду, то приложение будет запущенно в основном жизненном цикле.

# Список примеров CURL запросов для тестирования работы интерфейсов

Чтобы сохранить теги:

`curl -X POST localhost:8084/v1/tag/store -d '{"tags":["some", "tags"]}'`

Чтобы удалить теги:

`curl -X POST localhost:8084/v1/tag/remove -d '{"tags":["some", "tags"]}'`

Чтобы получить спинизированные тексты для тегов:

`curl -X POST localhost:8084/v1/text/get -d '{"tags":["some", "tags"]}'`

**NB** Если для тега нет текста, в ответе для него верётся пустая строчка
