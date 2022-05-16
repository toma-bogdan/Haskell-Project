
-- =============== DO NOT MODIFY ===================

{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE FlexibleInstances #-}

-- ==================================================

module Tasks where

import Dataset
import Data.List
import Text.Printf
import Data.Array
import Data.Char
import Text.Read
import Data.Maybe
import Data.Monoid

type CSV = String
type Value = String
type Row = [Value]
type Table = [Row]
type ColumnName = String

-- Prerequisities
split_by :: Char -> String -> [String]
split_by x = foldr op [""]
  where op char acc
            | char == x = "":acc
            | otherwise = (char:head(acc)):tail(acc)

read_csv :: CSV -> Table
read_csv = (map (split_by ',')) . (split_by '\n')

write_csv :: Table -> CSV
write_csv = (foldr (++) []).
            (intersperse "\n").
            (map (foldr (++) [])).
            (map (intersperse ","))


{-
    TASK SET 1
-}


-- Task 1

-- returns the length of a list in Float format
len :: [a] -> Float
len [] = 0
len (x:xs) = 1 + len xs

-- returns the sum of a String list in Float format
sum_steps :: [String] -> Float
sum_steps [] = 0
sum_steps l = read (head l) +  sum_steps (tail l)

-- returns average_steps for a person
average :: Float -> Float -> Value
average x y = printf "%.2f" (x/y)

conc :: String -> String -> [String]
conc x y = [x,y]

compute_average_steps :: Table -> Table
compute_average_steps m = ["Name", "Average Number of Steps"] : zipWith conc (map head (tail m)) ( map (\l -> average (sum_steps l) (len l) ) (map tail (tail m)) )

-- Task 2

-- Number of people who have achieved their goal:
get_passed_people_num :: Table -> Int
get_passed_people_num m = foldr (\x acc -> if(x >= 1000) then 1 + acc else acc) 0 (map sum_steps (map tail (tail m)) )

-- Percentage of people who have achieved their:
get_passed_people_percentage :: Table -> Float
get_passed_people_percentage m = fromIntegral (get_passed_people_num m) / len (tail m)

-- Number of steps per day of a person
get_steps :: Table -> [Float]
get_steps m = map sum_steps (map tail (tail m))

-- Average number of daily steps
get_steps_avg :: Table -> Float
get_steps_avg m = ( foldr (+) 0 (get_steps m) ) / len (tail m)

-- Task 3

-- Average number of steps per one hour for all persons
get_steps_per_h :: Table -> Value
get_steps_per_h m = average (foldr (\x acc -> (read (head x)) + acc) 0 m) (len m)

-- List with average steps per hours
get_avg :: Table -> Row
get_avg m = if (len (head m) /= 0) then get_steps_per_h m : (get_avg (map tail m)) else []


get_avg_steps_per_h :: Table -> Table
get_avg_steps_per_h m = ["H10", "H11", "H12", "H13", "H14", "H15", "H16", "H17"] : get_avg (map tail (tail m)) : []

-- Task 4

get_active_minutes :: String -> Table -> Row
get_active_minutes s m = s : show (foldr (\x acc -> if( read (head x) < 50) then 1 + acc else acc) 0 m)
 : show (foldr (\x acc -> if( read (head x) >= 50 && read (head x) < 100) then 1 + acc else acc) 0 m)
 : show (foldr (\x acc -> if( read (head x) >= 100 && read (head x) < 500) then 1 + acc else acc) 0 m) : []

get_activ_summary :: Table -> Table
get_activ_summary m = ["column","range1","range2","range3"] : get_active_minutes "VeryActiveMinutes" (map (drop 3) (tail m) ) : 
  get_active_minutes "FairlyActiveMinutes" (map (drop 4) (tail m)) : get_active_minutes "LightlyActiveMinutes" (map (drop 5) (tail m)) : []


-- Task 5
my_compare :: Row -> Row -> Ordering
my_compare (x:xs) (y:ys)
      | (read (head xs) :: Integer) < (read (head ys) :: Integer) = LT
      | (read (head xs) :: Integer) == (read (head ys) :: Integer) = compare x y
      | otherwise = GT

get_ranking :: Table -> Table
get_ranking m = ["Name","Total Steps"] : sortBy my_compare (map (take 2) (tail m))


-- Task 6
-- Steps for the first 4 hours
get_first_4h :: Table -> Table
get_first_4h m = map (take 4) (map tail (tail m))

-- Steps for the last 4 hours
get_last_4h :: Table -> Table
get_last_4h m = map (drop 4) (map tail (tail m))

-- Average steps per 4h
get_avg_hours :: Table -> Row
get_avg_hours m = map (\l -> average (sum_steps l) (len l)) m

-- Difference between first and last 4 hours
get_diff :: Table -> Row
get_diff m = zipWith oper (get_avg_hours (get_first_4h m)) (get_avg_hours (get_last_4h m))

oper :: String -> String -> String
oper x y = printf "%.2f" (abs ( (read :: String->Float) x - (read :: String->Float) y ))

-- Forms the diff_table unsorted
get_unsorted_diff_table :: Table -> Table
get_unsorted_diff_table m = zipWith (:) (map head (tail m)) ( zipWith (:) (get_avg_hours(get_first_4h m)) (zipWith (conc) (get_avg_hours (get_last_4h m)) (get_diff m)) )

-- Comper function by diff
compare_diff :: Row -> Row -> Ordering
compare_diff x y
        | (read (head (drop 3 x)) :: Float) < (read (head (drop 3 y)) :: Float) = LT
        | (read (head (drop 3 x)) :: Float) == (read (head (drop 3 y)) :: Float) = compare (head x) (head y)
        | otherwise = GT

get_steps_diff_table :: Table -> Table
get_steps_diff_table m = ["Name","Average first 4h","Average last 4h","Difference"] : sortBy compare_diff (get_unsorted_diff_table m)


-- Task 7

-- Applies the given function to all the values
vmap :: (Value -> Value) -> Table -> Table
vmap f m = map (map f) m


-- Task 8

-- Applies the given function to all the entries
rmap :: (Row -> Row) -> [String] -> Table -> Table
rmap f s m = s : (map f m)


get_sleep_total :: Row -> Row
get_sleep_total r = head r : ((printf "%.2f" (sum_steps (tail r))) :: String) : []

{-
    TASK SET 2
-}

-- Task 1

-- Compare function for numeric values
compare_tsortNumber :: ([String],Int) -> ([String],Int) -> Ordering
compare_tsortNumber (l1,pos) (l2,pos1)
        | (read (head (drop pos l1)) :: Float) < (read (head (drop pos1 l2)) :: Float) = LT
        | (read (head (drop pos l1)) :: Float) == (read (head (drop pos1 l2)) :: Float) = if (isNothing (readMaybe (head l1) :: Maybe Float) ) 
                                                                                            then compare (head l1) (head l2) else compare_tsortNumber (l1,0) (l2,0)
        | otherwise = GT

-- Compare function for string values
compare_tsortString :: ([String],Int) -> ([String],Int) -> Ordering
compare_tsortString (l1,pos) (l2, pos1) 
    | compare (head (drop pos l1)) (head (drop pos l2)) == EQ = if (isNothing (readMaybe (head l1) :: Maybe Float) ) 
                                                                    then compare (head l1) (head l2) else compare_tsortNumber (l1,0) (l2,0)
    | otherwise = compare (head (drop pos l1)) (head (drop pos l2))

-- Gets the index of the column we want to sort by
get_index :: ColumnName -> Row -> Int
get_index column [] = 0
get_index column l = if (head l == column) then 0 else 1 + get_index column (tail l)

-- Verify if the column contains strings or numeric values
check_number :: ColumnName -> Table -> Bool
check_number column table = if (isNothing (readMaybe (head (drop (get_index column (head table)) (head (tail table)) ) ) :: Maybe Float))
                                 then False else True

-- Creates a table with tuples : (Row, value to be sorted)
make_tuple :: ColumnName -> Table -> [([String],Int)]
make_tuple column table = map (\x -> (x,get_index column (head table))) (tail table)

-- Transforms a table with tuples into a normal table
make_nonTuple :: [([String],Int)] -> [[String]]
make_nonTuple [] = []
make_nonTuple ((x,pos):xs) = x : make_nonTuple xs

-- Sort by a given column
tsort :: ColumnName -> Table -> Table
tsort column table = if (check_number column table) then head table : make_nonTuple (sortBy compare_tsortNumber (make_tuple column table)) 
                                                    else head table : make_nonTuple (sortBy compare_tsortString (make_tuple column table))


-- Task 2

-- Verify if a table has the same columns
check_columns :: Row -> Row -> Bool 
check_columns [] [] = True
check_columns h1 h2 = if (head h1 == head h2) then True && check_columns (tail h1) (tail h2) else False

vunion :: Table -> Table -> Table
vunion t1 t2 = if (check_columns (head t1) (head t2)) then t1 ++ (tail t2) else t1

-- Task 3
mylen :: [a] -> Integer
mylen [] = 0
mylen (x:xs) = 1 + mylen xs

-- Creates a row with n empty strings
addEmpty :: Integer -> [String]
addEmpty 0 = []
addEmpty n = "" : addEmpty (n - 1)

-- Concatenates 2 tables row by row
myzip :: (Row -> Row -> Row) -> Table -> Table -> Integer -> Integer -> Table
myzip f (x:xs) (y:ys) n1 n2 = f x y : myzip f xs ys n1 n2
myzip f [] (y:ys) n1 n2 = (addEmpty n1 ++ y) : myzip f [] ys n1 n2
myzip f (x:xs) [] n1 n2 = (x ++ addEmpty n2) : myzip f xs [] n1 n2
myzip f [] [] n1 n2 = []

hunion :: Table -> Table -> Table
hunion t1 t2 = myzip (++) t1 t2 (mylen (head t1)) (mylen (head t2))

-- Task 4
-- searches a value in a row and removes it
search_elem :: Value -> Row -> Row
search_elem val l = foldr(\x acc -> if(val == x ) then acc else x : acc) [] l

-- searches in the other table if the value from the index exists
search_table :: Int -> Table -> Row -> Row
search_table index t l = l ++ (foldr (\x acc -> if((l !! index) `elem` x) then (search_elem (l !! index) x) ++ acc else acc ) [] t)

-- concatenates the final table
join :: Int -> Table -> Table -> Table
join index [] t2 = []
join index t1 t2 = if ((search_table index t2 (head t1)) == head t1 ) then join index (tail t1) t2 else (search_table index t2 (head t1) ) : join index (tail t1) t2

tjoin :: ColumnName -> Table -> Table -> Table
tjoin key_column t1 t2 = join (get_index key_column (head t1)) t1 t2

-- Task 5

calculate_cart :: (Row -> Row -> Row) -> Table -> Table -> Table
calculate_cart f [] t2 = []
calculate_cart f t1 t2 = map (\x -> f (head t1) x) t2 ++ calculate_cart f (tail t1) t2

cartesian :: (Row -> Row -> Row) -> [ColumnName] -> Table -> Table -> Table
cartesian new_row_function new_column_names t1 t2 = new_column_names : calculate_cart new_row_function (tail t1) (tail t2)

-- Task 6

--  Returns a list of indexes of columns which we want extract values
get_projection_index :: [ColumnName] -> Row -> [Int]
get_projection_index [] h = []
get_projection_index columns h = (get_index (head columns) h) : (get_projection_index (tail columns) h)

-- List of indexes, curent index and row
projection_op :: [Int] -> Int -> Row -> Row
projection_op h index row
      | index == length h = []
      | index `elem` h = (head row) : projection_op h (index + 1) (tail row)
      | otherwise = projection_op h (index + 1) (tail row)

projection :: [ColumnName] -> Table -> Table
projection columns_to_extract t = map (projection_op (get_projection_index columns_to_extract (head t)) 0) t

-- Task 7

filterTable_op :: Int -> Int -> (Value -> Bool) -> Row -> Bool
filterTable_op column index f row
      | index == column = f (head row)
      | otherwise = filterTable_op column (index + 1) f (tail row)

filterTable :: (Value -> Bool) -> ColumnName -> Table -> Table
filterTable condition key_column t = head t : filter (filterTable_op (get_index key_column (head t)) 0 condition) (tail t)

