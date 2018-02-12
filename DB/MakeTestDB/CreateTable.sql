CREATE TABLE t_postcode (
    id int PRIMARY KEY, -- プライマーキー
    JLG_Code int,    -- 全国地方公共団体コード
    old_postcade int, -- 旧郵便番号
    postcode int, -- 郵便番号
    prefectural_kana VARCHAR(64), -- 都道府県名カナ
    municipality_kana VARCHAR(64), -- 市区町村カナ
    town_kana VARCHAR(64), -- 町域名カナ
    prefectural VARCHAR(64), -- 都道府県名カナ
    municipality VARCHAR(64), -- 市区町村カナ
    town VARCHAR(64) -- 町域名カナ
)
