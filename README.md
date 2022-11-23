### Hexlet tests and linter status:
[![Actions Status](https://github.com/TheHexReader/rails-project-lvl2/workflows/hexlet-check/badge.svg)](https://github.com/TheHexReader/rails-project-lvl2/actions)

[![test](https://github.com/TheHexReader/rails-project-lvl2/actions/workflows/test.yml/badge.svg)](https://github.com/TheHexReader/rails-project-lvl2/actions/workflows/test.yml)

# Проект: Коллективный блог

Коллективный блог - Аналог Habr. Каждый пользователь может создать запись и опубликовать ее в одной из общих категорий. Другие пользователи ставят оценки и комментируют добавленные посты.

## Требования для запуска проекта

- Ruby 3.0.2
- Ruby on Rails 6.1.6.1
- Node.js 16.16.0

## Установка

1. Клонировать репозиторий


```bash
bundle install
yarn install
bin/rails db:migrate
bin/rails db:seed
```

## Ссылка на Railway
https://rails-project-lvl2-production.up.railway.app