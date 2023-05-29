# テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| ------------------    | ------ | ------------------------- |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| nickname              | string | null: false               |
| first_name            | string | null: false               |
| last_name             | string | null: false               |
| first_name_kana       | string | null: false               |
| last_name_kana        | string | null: false               |
| date_of_birth         | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address


##  itemsテーブル

| Column                | Type       | Options                         |
| --------------------- | ---------- | ------------------------------- |
| user_id               | references | null: false , foreign_key: true |
| name                  | string     | null: false                     |
| content               | text       | null: false                     |
| category_name_id      | integer    | null: false                     |
| condition_id          | integer    | null: false                     |
| shipping_fee_payer_id | integer    | null: false                     |
| prefecture_id         | integer    | null: false                     |
| shipping_day_id       | integer    | null: false                     |
| price                 | integer    | null: false                     |

### Association

- has_one :order
- belongs_to :user

##  addressesテーブル

| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| order          | references | null: false , foreign_key: true |
| postal_code    | string     | null: false                     |
| prefecture_id  | integer    | null: false                     |
| city           | string     | null: false                     |
| street_address | string     | null: false                     |
| building_name  | string     |                                 |
| phone_number   | string     | null: false                     |

### Association

- belongs_to :order