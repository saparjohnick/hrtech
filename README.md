# README

1. Отрефакторенная версия `Users::Create`: `app/interactions/users/create.rb`
2. Тесты `test/interactions/users/create_test.rb`

Как исправить опечатку

  1.1. переименовать модель, файл и связи `Skil` => `Skill`, `:skils` => `:skills`

  1.2. создать миграцию на: 
        * переименование таблицы `skils` => `skills`
        * переименование таблицы `users_skils` => `users_skills`
        * переименование связи в `users_skills`: `skils_id` => `skills_id`

  
  2.1. переименовать модель, файл и связи `Skil` => `Skill`, `:skils` => `:skills`

  2.2. добавить в модель `Skill`: 
  ```
  self.table_name = 'skils'
  ```

  2.3. добавить в модель `User`:
  ```
  has_and_belongs_to_many :skills, class_name: 'Skill', join_table: 'skils_users', association_foreign_key: 'skil_id'
  ```
