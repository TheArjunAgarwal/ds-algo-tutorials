p :: Int -> Int -> Float
p x 0 = 0
p x 1 = 1 / fromIntegral x
p x y = maximum [fromIntegral k / fromIntegral x * (1 - (p y k)) + fromIntegral (x-k) / fromIntegral x * (1 - (p y (x-k)) ) | k <- [1..x]]

-- f :: Int -> Int -> Int
-- f x 1 = 1
-- f x hy = 