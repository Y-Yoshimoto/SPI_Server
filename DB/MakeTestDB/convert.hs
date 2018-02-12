import System.IO
import Data.List.Split

listToLine :: [String] -> String
listToLine = foldl1 (\acc x -> acc ++ "," ++ x)

addIndex :: [String] -> [String]
addIndex = zipWith (\ a b -> show a ++ "," ++ b) [1..]

-- 日本郵政の郵便番号データをcsv形式でダウンロードし、形式の変換を行う
-- 事前にnkfで文字コード及び改行コードを変換しておく
-- nkf -w -Lu --overwrite x-ken-all.csv
main:: IO()
main = do
        handle <- openFile "./x-ken-all.csv" ReadMode
        contents <- hGetContents handle
        -- putStrLn contents
        let line = lines contents
        (writeFile "../AllPostCodeEdit.csv" . unlines) . addIndex $ fmap (listToLine . take 9 . splitOn "," ) line
        hClose handle
