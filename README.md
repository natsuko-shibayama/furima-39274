# テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| ------------------    | ------ | ------------------------- |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| password_confirmation | string | null: false               |
| full_name             | string | null: false               |
| kana_name             | string | null: false               |
| date_of_birth         | string | null: false               |

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
- has_one :address


##  itemsテーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| user               | references | null: false , foreign_key: true |
| image              | text       | null: false                     |
| name               | string     | null: false                     |
| content            | text       | null: false                     |
| category_name      | integer    | null: false                     |
| condition          | integer    | null: false                     |
| shipping_fee_payer | integer    | null: false                     |
| shipping_area      | integer    | null: false                     |
| shipping_days      | integer    | null: false                     |
| price              | integer    | null: false                     |

### Association

- has_one :order
- belongs_to :user

##  addressesテーブル

| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| order          | references | null: false , foreign_key: true |
| postal_code    | integer    | null: false                     |
| prefecture     | integer    | null: false                     |
| city           | text       | null: false                     |
| street_address | string     | null: false                     |
| building_name  | string     |                                 |
| phone_number   | integer    | null: false                     |

### Association

- belongs_to :order