# README

# テーブル設計

## users テーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| email     | string | null: false |
| password  | string | null: false |
| nickname  | string | null: false |
| lastname  | string | null: false |
| firstname | string | null: false |
| lastkana  | string | null: false |
| firstkana | string | null: false |
| birthday  | string | null: false |

### Association

- has_many :items
- has_many :comments, through: items
- has_many :orders,   through: items


## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | string     | null: false                    |
| category    | string     | null: false                    |
| status      | string     | null: false                    |
| delivery    | string     | null: false                    |
| shipping    | string     | null: false                    |
| area        | string     | null: false                    |
| days        | string     | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments, through: user
- belongs_to :order


## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| cardnumber   | string     | null: false                    |
| validmonth   | string     | null: false                    |
| validyear    | string     | null: false                    |
| cord         | string     | null: false                    |
| postal       | string     | null: false                    |
| prefectures  | string     | null: false                    |
| municipality | string     | null: false                    |
| address      | string     | null: false                    |
| building     | string     |                                |
| phone        | string     | null: false                    |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item


## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null:                          |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item