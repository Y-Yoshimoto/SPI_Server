-- \copy t_postcode (id,JLG_Code,old_postcade,postcode,prefectural_kana,municipality_kana,town_kana,prefectural,municipality,town) FROM '/home/y-yoshimoto/okinawa.csv' WITH CSV;
\copy t_postcode FROM '/$HOME/SPIArea/SPI_Server/DB/MakeTestDB/miniPostCodeEdit.csv' WITH CSV;
