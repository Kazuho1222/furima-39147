## users テーブル

|Column            |Type  |Options    |
|------------------|------|-----------|
|nickname          |string|null: false|
|email             |string|null: false|
|encrypted_password|string|null: false|
|last_name         |string|null: false|
|first_name        |string|null: false|
|last_name_kana    |string|null: false|
|first_name_kana   |string|null: false|
|birthday          |string|null: false|

### Association

- has_many :items
- has_many :orders
- has_many :addresses

## items テーブル

|Column|Type|Options|
|-------------|----------|------------------------------|
|name         |string    |null: false                   |
|description  |text      |null: false                   |
|category     |string    |null: false                   |
|status       |string    |null: false                   |
|postage      |string    |null: false                   |
|state        |string    |null: false                   |
|shipping_date|string    |null: false                   |
|price        |integer   |null: false                   |
|user         |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- has_and_belongs_to_many :orders

## orders テーブル

|Column |Type      |Options                       |
|-------|----------|------------------------------|
|user   |references|null: false, foreign_key: true|
|item   |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- has_and_belongs_to_many :items

## addresses テーブル

|Column          |Type      |Options                       |
|----------------|----------|------------------------------|
|post_code       |string    |null: false                   |
|state           |string    |null: false                   |
|city            |string    |null: false                   |
|address         |string    |null: false                   |
|building_name   |string    |                              |
|telephone_number|string    |null: false                   |
|user            |references|null: false, foreign_key: true|

### Association

- belongs_to :user