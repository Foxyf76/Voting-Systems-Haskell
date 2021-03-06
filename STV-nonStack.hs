import Data.List(sort,maximumBy,elemIndex)
import Data.Ord(comparing)
import Data.Maybe
import Debug.Trace

weight :: Double
weight = 1.0

numSeats :: Int
numSeats = 4

votes :: [[String]]
votes = [
    ["","","D. Abbott","E. Balls","A. Burbhm","D. Milliband","E. Milliband"],
    ["1","Ms D Abbott MP  ","1","*","*","*","*"],
    ["2","RtHon B W Ainsworth MP ","5","4","3","1","2"],
    ["3","RtHon D Alexander MP ","5","3","4","1","2"],
    ["4","Ms H Alexander MP ","*","*","1","2","3"],
    ["5","Ms R Ali MP     ","5","3","4","1","2"],
    ["6","Mr G Allen MP   ","*","*","*","1","2"],
    ["7","Mr D Anderson MP ","5","1","4","3","2"],
    ["8","Mr I Austin MP   ","5","1","3","2","4"],
    ["9","Mr A E Bailey MP ","*","3","4","2","1"],
    ["10","Mr W Bain MP    ","5","3","4","1","2"],
    ["11","RtHon E M Balls MP ","*","1","*","*","*"],
    ["12","Mr G R Banks MP ","*","3","4","1","2"],
    ["13","RtHon K J Barron MP ","5","4","1","3","2"],
    ["14","Mr H Bayley MP  ","5","3","4","1","2"],
    ["15","RtHon M M Beckett MP ","*","*","*","*","1"],
    ["16","Miss A Begg MP  ","5","3","4","2","1"],
    ["17","Sir S Bell MP   ","*","2","*","1","*"],
    ["18","RtHon H Benn MP ","*","*","*","2","1"],
    ["19","Mr J E Benton MP ","*","4","1","2","3"],
    ["20","Miss L Berger MP ","5","3","4","2","1"],
    ["","","","","","",""],
    ["21","Mr C Betts MP   ","*","*","1","*","2"],
    ["22","Ms R Blackman-Woods MP ","*","*","2","*","1"],
    ["23","RtHon H A Blears MP ","*","3","1","2","4"],
    ["24","Mr T Blenkinsop MP ","*","1","*","2","*"],
    ["25","Mr P Blomfield MP ","*","*","*","*","1"],
    ["26","RtHon D Blunkett MP ","*","*","1","2","*"],
    ["27","Mr B Bradshaw MP ","*","*","*","1","*"],
    ["28","Mr K Brennan MP ","5","1","4","2","3"],
    ["29","Ms L Brown MP   ","*","1","*","3","2"],
    ["30","Mr R Brown MP   ","*","3","4","1","2"],
    ["31","Mr C Bryant MP  ","5","2","3","1","4"],
    ["32","Ms K Buck MP    ","*","*","*","*","1"],
    ["33","Mr R H Burden MP ","*","3","*","1","2"],
    ["34","RtHon A Burnham MP ","5","4","1","2","3"],
    ["35","Mr L Byrne MP   ","*","2","*","1","3"],
    ["36","Mr D Cairns MP  ","*","*","*","1","*"],
    ["37","Mr A Campbell MP ","*","*","2","1","*"],
    ["38","Mr R Campbell MP ","*","*","1","*","2"],
    ["39","Mr M Cashman MEP","*","*","*","1","2"],
    ["40","Mr M Caton MP   ","2","3","*","*","1"],
    ["","","","","","",""],
    ["41","Ms J Chapman MP ","*","*","*","1","*"],
    ["42","Ms K Clark MP   ","1","2","4","5","3"],
    ["43","RtHon T Clarke MP ","3","5","2","1","4"],
    ["44","RtHon A Clwyd MP ","*","*","*","1","*"],
    ["45","Mr V Coaker MP  ","*","1","4","2","3"],
    ["46","Ms A Coffey MP  ","5","4","3","1","2"],
    ["47","Mr M Connarty MP ","5","2","1","4","3"],
    ["48","Ms R Cooper MP  ","*","2","*","1","*"],
    ["49","Ms Y Cooper MP  ","*","1","*","*","*"],
    ["50","Mr J Corbyn MP  ","1","*","*","*","2"],
    ["51","Mr D Crausby MP ","5","1","4","2","3"],
    ["52","Ms M Creagh MP  ","5","2","4","1","3"],
    ["53","Miss S Creasy MP ","*","*","*","1","2"],
    ["54","Mr J Cruddas MP ","4","2","5","1","3"],
    ["55","Mr J Cryer MP   ","5","2","4","3","1"],
    ["56","Mr A Cunningham MP ","5","3","4","1","2"],
    ["57","Mr J Cunningham MP ","5","1","4","2","3"],
    ["58","Mr T Cunningham MP ","*","1","4","3","2"],
    ["59","Ms M Curran MP  ","5","4","3","2","1"],
    ["60","Mr N Dakin MP   ","5","3","4","1","2"],
    ["","","","","","",""],
    ["61","Mr S Danczuk MP ","*","*","*","1","*"],
    ["62","RtHon A Darling MP ","*","*","*","1","*"],
    ["63","Mr W David MP   ","5","3","4","2","1"],
    ["64","Mr I Davidson MP ","5","1","4","3","2"],
    ["65","Mr G R Davies MP ","*","3","*","2","1"],
    ["66","Ms G De Piero MP ","*","*","*","1","2"],
    ["67","RtHon J Y Denham MP ","*","*","*","*","1"],
    ["68","Mr J Dobbin MP  ","*","1","*","*","2"],
    ["69","RtHon F G Dobson MP ","*","2","*","*","1"],
    ["70","Mr T Docherty MP ","*","4","1","2","3"],
    ["71","Mr B Donohoe MP ","5","3","4","1","2"],
    ["72","Mr F Doran MP   ","*","3","4","2","1"],
    ["73","Mr J Dowd MP    ","*","*","*","1","*"],
    ["74","Miss G Doyle MP ","4","3","5","1","2"],
    ["75","Mr J Dromey MP  ","*","*","*","*","1"],
    ["76","Mr M Dugher MP  ","*","1","*","*","2"],
    ["77","Ms A Eagle MP   ","5","2","4","1","3"],
    ["78","Ms M Eagle MP   ","*","*","*","*","1"],
    ["79","Mr C Efford MP   ","5","3","4","2","1"],
    ["80","Ms J Elliott MP ","*","*","2","1","3"],
    ["","","","","","",""],
    ["81 ","Ms L J Ellman MP ","*","*","2","1","*"],
    ["82","Ms N Engel MP   ","*","*","*","*","1"],
    ["83","Mr B Esterson MP ","5","4","2","3","1"],
    ["84","Mr C Evans MP   ","*","1","4","2","3"],
    ["85","Mr P Farrelly MP ","5","4","3","2","1"],
    ["86","RtHon F Field MP ","*","*","2","*","1"],
    ["87","Mr J Fitzpatrick MP ","*","*","*","1","*"],
    ["88","Mr R C D Flello MP ","*","*","1","2","3"],
    ["89","Ms C Flint MP   ","*","*","*","1","*"],
    ["90","Mr P P Flynn MP ","3","4","2","1","5"],
    ["91","Ms Y Fovargue MP ","*","*","1","2","*"],
    ["92","Dr H Francis MP ","*","2","*","*","1"],
    ["93","Mr M Gapes MP   ","5","3","2","1","4"],
    ["94","Mr B Gardiner MP ","*","*","*","1","2"],
    ["95","Ms S Gilmore MP ","4","5","3","1","2"],
    ["96","Mrs P Glass MP   ","5","2","3","1","4"],
    ["97","Ms M T Glindon MP ","5","4","2","1","3"],
    ["98","Mr R Godsiff MP ","5","4","3","2","1"],
    ["99","Mr P Goggins MP ","*","*","1","2","*"],
    ["100","Ms H Goodman MP ","*","*","*","*","1"],
    ["","","","","","",""],
    ["101","Mr T J Greatrex MP ","*","4","3","2","1"],
    ["102","Ms K Green MP   ","5","1","3","4","2"],
    ["103","Ms L R Greenwood MP ","5","3","4","2","1"],
    ["104","Ms N Griffith MP ","*","1","*","3","2"],
    ["105","Mr A J Gwynne MP ","5","1","4","3","2"],
    ["106","RtHon P Hain MP ","*","*","*","2","1"],
    ["107","The Hon D Hamilton MP ","*","2","3","4","1"],
    ["108","Mr F Hamilton MP ","*","4","3","1","2"],
    ["109","RtHon D Hanson MP ","5","4","2","1","3"],
    ["110","Mr T Harris MP  ","*","*","*","1","*"],
    ["111","Mr D Havard MP   ","*","2","*","*","1"],
    ["112","Mr J Healey MP  ","*","1","*","*","2"],
    ["113","Mr M Hendrick MP ","5","4","3","1","2"],
    ["114","Mr S Hepburn MP ","*","1","*","2","*"],
    ["115","Mr D A Heyes MP ","5","4","1","3","2"],
    ["116","Ms M Hillier MP ","*","2","3","1","*"],
    ["117","Ms J A Hilling MP ","5","4","1","2","3"],
    ["118","RtHon M E Hodge MP ","*","*","*","1","*"],
    ["119","Mrs G Hodges MP ","*","2","*","*","1"],
    ["120","Ms S Hodgson MP ","5","1","2","4","3"],
    ["","","","","","",""],
    ["121","Ms K Hoey MP    ","*","*","1","3","2"],
    ["122","Ms M Honeyball MEP","5","3","4","1","2"],
    ["123","Mr J Hood MP    ","5","2","4","3","1"],
    ["124","Mr K Hopkins MP ","1","3","4","5","2"],
    ["125","RtHon G Howarth MP ","*","2","*","1","*"],
    ["126","Mr R Howitt MEP ","*","*","*","1","2"],
    ["127","Mr L Hoyle MP   ","*","1","*","3","2"],
    ["128","Mr S Hughes MEP ","*","*","3","2","1"],
    ["129","Mr T Hunt MP    ","5","2","4","1","3"],
    ["130","Mr H Irranca-Davies MP ","*","4","2","1","3"],
    ["131","Mrs S James MP  ","*","2","*","*","1"],
    ["132","Ms C Jamieson MP ","5","4","2","3","1"],
    ["133","RtHon A A Johnson MP ","*","*","*","1","*"],
    ["134","Ms D R Johnson MP ","*","1","*","2","*"],
    ["135","Mr G Jones MP   ","*","2","3","4","1"],
    ["136","Ms H Jones MP   ","*","1","*","3","2"],
    ["137","Mr K Jones MP   ","*","*","2","1","*"],
    ["138","Ms S E Jones MP ","*","*","*","2","1"],
    ["139","RtHon T J Jowell MP ","4","5","2","1","3"],
    ["140","Mr E Joyce MP   ","5","1","3","4","2"],
    ["","","","","","",""],
    ["141","RtHonSir G B Kaufman MP","*","4","3","1","2"],
    ["142","Ms B Keeley MP   ","5","1","4","3","2"],
    ["143","Mr A Keen MP    ","5","4","1","3","2"],
    ["144","Miss E Kendall MP ","*","*","*","1","*"],
    ["145","Mr S Khan MP    ","*","*","*","*","1"],
    ["146","Mr D Lammy MP   ","2","3","5","1","4"],
    ["147","Mr I Lavery Snr MP ","*","*","2","*","1"],
    ["148","Mr M Lazarowicz MP ","*","*","*","*","1"],
    ["149","Mr C Leslie MP   ","5","1","4","2","3"],
    ["150","Mr I Lewis MP   ","*","*","*","1","*"],
    ["151","Mr A Love MP    ","5","3","4","2","1"],
    ["152","Mr I Lucas MP    ","5","2","4","3","1"],
    ["153","RtHon D MacShane MP ","*","*","*","1","*"],
    ["154","Ms F Mactaggart MP ","*","2","*","1","*"],
    ["155","Mr K Mahmood MP ","3","1","5","4","2"],
    ["156","Ms S Mahmood MP ","*","*","*","*","1"],
    ["157","Mr J Mann MP    ","*","*","*","1","2"],
    ["158","Mr G Marsden MP ","*","4","3","2","1"],
    ["159","Mr D Martin MEP ","*","*","*","1","*"],
    ["160","Ms L McAvan MEP ","*","*","*","*","1"],
    ["","","","","","",""],
    ["161","Mr S J McCabe MP ","*","1","*","3","2"],
    ["162","Mr M McCann MP  ","*","*","*","1","*"],
    ["163","Ms A McCarthy MEP","*","*","3","2","1"],
    ["164","Ms K McCarthy MP ","*","1","*","2","*"],
    ["165","Mr G McClymont MP ","5","3","4","1","2"],
    ["166","Ms S McDonagh MP ","*","*","*","1","*"],
    ["167","Mr J McDonnell MP ","1","*","*","*","*"],
    ["168","Mr P McFadden MP ","*","*","*","1","*"],
    ["169","Ms A McGovern MP ","5","4","2","1","3"],
    ["170","Mr J McGovern MP ","*","*","*","*","1"],
    ["171","Mrs A McGuire MP ","5","2","4","1","3"],
    ["172","Ms A McKechin MP ","*","2","*","*","1"],
    ["173","Mrs C McKinnell MP ","*","*","*","*","1"],
    ["174","RtHon M Meacher MP ","2","*","*","*","1"],
    ["175","Mr A Meale MP   ","5","3","4","2","1"],
    ["176","Mr I Mearns MP   ","5","2","4","1","3"],
    ["177","RtHon A Michael MP ","5","2","4","1","3"],
    ["178","RtHon D Miliband MP ","*","*","*","1","2"],
    ["179","RtHon E Miliband MP ","*","*","*","2","1"],
    ["180","Mr A P Miller MP ","*","4","1","2","3"],
    ["","","","","","",""],
    ["181","Mr A Mitchell MP ","4","3","5","2","1"],
    ["182","Mrs M Moon MP   ","*","2","*","*","1"],
    ["183","Mr C Moraes MEP ","*","*","*","1","*"],
    ["184","Ms J Morden MP   ","5","4","3","1","2"],
    ["185","Mr G Morrice MP ","*","*","*","*","1"],
    ["186","Mr G M Morris MP ","4","3","2","5","1"],
    ["187","Mr G Mudie MP   ","*","1","*","*","2"],
    ["188","Ms M Munn MP    ","*","*","*","1","*"],
    ["189","Mr J Murphy MP  ","*","*","*","1","*"],
    ["190","RtHon P Murphy MP ","*","*","*","2","1"],
    ["191","Mr I Murray MP   ","5","3","4","1","2"],
    ["192","Ms L Nandy MP   ","*","2","*","*","1"],
    ["193","Miss P Nash MP  ","*","*","*","1","*"],
    ["194","Mrs F O'Donnell MP ","5","4","3","1","2"],
    ["195","Ms C Onwurah MP ","3","*","*","2","1"],
    ["196","Ms S Osborne MP ","*","*","*","*","1"],
    ["197","Mr A Owen MP    ","*","4","2","3","1"],
    ["198","Ms T Pearce MP   ","*","1","*","3","2"],
    ["199","Mr M T Perkins MP ","5","2","4","1","3"],
    ["200","Ms B M Phillipson MP ","*","*","*","1","*"],
    ["","","","","","",""],
    ["201","Mr S Pound MP   ","*","4","2","3","1"],
    ["202","RtHon D Primarolo MP ","*","*","*","*","1"],
    ["203","Ms Y Qureshi MP ","*","*","*","1","*"],
    ["204","RtHon N Raynsford MP ","*","*","*","1","*"],
    ["205","Mr J R Reed MP   ","*","4","3","1","2"],
    ["206","Ms R J Reeves MP ","5","3","4","2","1"],
    ["207","Ms E Reynolds MP ","5","3","4","2","1"],
    ["208","Mr J N Reynolds MP ","*","*","*","1","2"],
    ["209","Ms L Riordan MP ","1","*","*","*","2"],
    ["210","Mr J Robertson MP ","5","1","4","3","2"],
    ["211","Mr G Robinson MP ","5","1","4","2","3"],
    ["212","Mr S P Rotheram MP ","*","*","1","*","2"],
    ["213","Mr F Roy MP     ","*","*","*","1","*"],
    ["214","Mr L A Roy MP   ","*","2","*","3","1"],
    ["215","Mr C Ruane MP   ","5","3","4","1","2"],
    ["216","Ms J Ruddock MP ","*","*","*","*","1"],
    ["217","Mr A Sarwar MP  ","*","*","*","1","2"],
    ["218","Ms A Seabeck MP ","*","*","*","*","1"],
    ["219","Mr V K Sharma MP ","5","3","4","1","2"],
    ["220","Mr B Sheerman MP ","*","*","*","1","*"],
    ["","","","","","",""],
    ["221","Mr J Sheridan MP ","*","*","*","*","1"],
    ["222","Mr G Shuker MP  ","*","2","*","*","1"],
    ["223","Mr B Simpson MEP","*","*","1","*","2"],
    ["224","Mr M Singh MP   ","*","3","*","2","1"],
    ["225","Mr D E Skinner MP ","*","*","*","1","*"],
    ["226","Mr P Skinner MEP","*","*","*","1","*"],
    ["227","Mr A F Slaughter MP ","*","*","*","*","1"],
    ["228","RtHon A Smith MP ","5","1","4","2","3"],
    ["229","Ms A C Smith MP ","*","*","2","1","*"],
    ["230","Mr N Smith MP   ","5","2","4","1","3"],
    ["231","Mr O Smith MP   ","5","2","4","3","1"],
    ["232","Sir P Soulsby KBE MP ","5","4","3","1","2"],
    ["233","RtHon J F Spellar MP ","*","1","4","2","3"],
    ["234","Ms C Stihler MEP","5","4","3","2","1"],
    ["235","RtHon J W Straw MP ","*","3","2","1","*"],
    ["236","Mr G Stringer MP ","*","*","2","1","*"],
    ["237","Ms G Stuart MP  ","*","*","*","1","*"],
    ["238","Mr G Sutcliffe MP ","5","3","1","2","4"],
    ["239","Mr M R Tami MP   ","5","2","3","1","4"],
    ["240","Mr G Thomas MP  ","*","*","*","1","*"],
    ["","","","","","",""],
    ["241","Ms E Thornberry MP ","*","*","*","*","1"],
    ["242","RtHon S Timms MP ","*","4","3","2","1"],
    ["243","Mr J Trickett MP ","4","1","*","3","2"],
    ["244","Mr K Turner MP   ","5","4","1","2","3"],
    ["245","Mr D Twigg MP   ","5","3","1","2","4"],
    ["246","Mr S Twigg MP   ","*","*","*","1","2"],
    ["247","Mr C Umunna MP  ","*","*","*","2","1"],
    ["248","Mr D Vaughan MEP","*","*","*","2","1"],
    ["249","RtHon K Vaz MP   ","4","3","5","1","2"],
    ["250","Ms V Vaz MP     ","2","*","*","1","3"],
    ["251","Ms J L Walley MP ","*","*","2","*","1"],
    ["252","Mr T Watson MP   ","5","1","3","4","2"],
    ["253","Mr D Watts MP   ","4","2","1","5","3"],
    ["254","Mr A Whitehead MP ","*","*","2","3","1"],
    ["255","Mr M Wicks MP   ","5","4","3","1","2"],
    ["256","Mr C Williamson MP ","5","2","4","3","1"],
    ["257","Ms G Willmott MEP","*","*","*","2","1"],
    ["258","Mr P Wilson MP  ","*","*","2","1","*"],
    ["259","Mr D Winnick MP ","*","*","*","1","*"],
    ["260","RtHon R Winterton MP ","*","*","*","*","1"],
    ["","","","","","",""],
    ["261","Mr M Wood MP    ","1","3","*","*","2"],
    ["262","Mr J Woodcock MP ","*","4","2","1","3"],
    ["263","RtHon S Woodward MP ","5","3","4","1","2"],
    ["264","Mr P Woolas MP  ","*","*","*","1","*"],
    ["265","Mr D Wright MP  ","*","1","4","2","3"],
    ["266","Mr I D Wright MP ","*","1","3","4","5"],
    [""]
    ]

------------------------
-- SORTING & CLEANING --
------------------------

-- get candidates
candidates :: [String]
candidates = drop 2 (head votes)

-- ignore list items that contain empty strings
rmEmptyStrings :: [[String]] -> [[String]]
rmEmptyStrings = filter (not . null) . map (filter (not . null)) 

-- keep only the voting scores from each list
rmNames :: [[String]] -> [[String]]
rmNames (x:xs) = [ drop 2 x | x <- xs]

cleanVotes :: [[String]]
cleanVotes = rmNames (rmEmptyStrings votes)

votesLength :: Int
votesLength = length cleanVotes

quota :: Double
quota = (realToFrac votesLength / realToFrac(numSeats + 1)) + 1

-- go through each vote and apply zipCandidate
groupCandidateVotes :: [[(String, String)]]
groupCandidateVotes = map zipCandidate cleanVotes

-- zip candidate with specific vote
zipCandidate :: [String] -> [(String, String)]
zipCandidate = zip candidates

sortVotes :: [[(String, String)]]
sortVotes = map isort groupCandidateVotes

-- taken from notes 
isort :: Ord a => [(String, a)] -> [(String, a)]
isort [] = []
isort (x:xs) = insertion x (isort xs)

-- taken from notes and modified to apply on second string in tuple
insertion :: Ord a => (String, a) -> [(String, a)]  -> [(String, a)]
insertion x [] = [x]
insertion x (y:ys) 
                | snd x <= snd y = x : y : ys
                | otherwise = y: insertion x ys

-- return list of candidates sorted by vote number
extractVotes :: [[(String, String)]]
extractVotes = map rmEmptyVotes sortVotes

-- remove asterix and vote number which isn't needed 
rmEmptyVotes :: [(String, String)] -> [(String, String)]
rmEmptyVotes vote = [x | x <- vote, snd x /= "*"]

-- take from list until duplicate is encountered, modified from: https://stackoverflow.com/questions/28755554/taking-from-a-list-until-encountering-a-duplicate
takeUntilDuplicate :: Eq a => [(String, a)] -> [(String, a)]
takeUntilDuplicate = helper []
    where helper seen [] = seen
          helper seen (x:xs)
              | snd x `elem` map snd seen = init seen
              | otherwise = helper (seen ++ [x]) xs

rmVoteTally :: [(String, String)] -> [String]
rmVoteTally = map fst

readAsInt :: String -> Int
readAsInt s = read s :: Int

takeUntilGap :: [(String, String)] -> [(String, String)]
takeUntilGap = helper []
    where helper seen [] = seen
          helper seen (x:xs)
              | not (null seen) && readAsInt (snd x) - readAsInt(snd (last seen)) > 1 = seen
              | otherwise = helper (seen ++ [x]) xs

finalVotes :: [[String]]
finalVotes =  map ((rmVoteTally . takeUntilGap) . takeUntilDuplicate) extractVotes

------------------------
--  ALTERNATIVE VOTE  --
------------------------

-- The following code is sourced from 'Programming in Haskell' by Graham Hutton.
-- The code is referenced from pages 86 to 88.

countOccurances :: Eq a => a -> [a] -> Int
countOccurances x = length . filter (== x)

getFirstPastPost :: Ord a => [a] -> [(Int, a)]
getFirstPastPost vs = sort [(countOccurances v vs, v) | v <- rmDuplicates vs]

rmEmptyBallots :: Eq a => [[a]] -> [[a]]
rmEmptyBallots = filter (/= [])

rmDuplicates :: Eq a => [a] -> [a]
rmDuplicates []     = []
rmDuplicates (x:xs) = x : filter (/= x) (rmDuplicates xs)

eliminateCandidate :: Eq a => a -> [[a]] -> [[a]]
eliminateCandidate x = map (filter (/= x))

rankCandidates :: Ord a => [[a]] -> [a]
rankCandidates = map snd . getFirstPastPost . map head

getWinner :: Ord a => [[a]] -> a
getWinner bs = case rankCandidates (rmEmptyBallots bs) of
                [c]    -> c
                (c:cs) -> getWinner (eliminateCandidate c bs)

startAlternativeVoting :: String
startAlternativeVoting = getWinner finalVotes

------------------------
--      ST VOTE       --
------------------------

-- not used, zip weight with each vote
zipWeights :: [[String]] -> Double -> [([String], Double)]
zipWeights votes weight = [(x, weight) | x <- votes]

-- get the first candidate of a sorted vote
groupPref :: [String]
groupPref = map head finalVotes

-- get tuple of candidate and vote count (modified from https://codereview.stackexchange.com/questions/88720/return-list-with-numbers-of-color-occurrences-in-another-list)
votesRecieved :: [String] -> [(String, Double)]
votesRecieved xs = reverse (isort (zip candidates (map (\x -> realToFrac(length (filter (== x) xs))) candidates)))

-- remove candidate from list of first preferences
removeCandidate :: [(String, Double)] -> (String, Double) -> [(String, Double)]
removeCandidate allCans can = filter (/=can) allCans

-- get the fist preference of all votes
firstPref :: [(String, Double)]
firstPref = votesRecieved (map head finalVotes)

elected :: [(String, Double)]
elected = []

eliminated :: [(String, Double)]
eliminated = []

filterVotes :: String -> String -> [[String]] -> [[String]]
filterVotes currentCan nextCan votes = [x | x <- votes, currentCan `elem` x && nextCan `elem` x]

-- use gregory method of calculating weight to apply to transferable votes
calculateWeightFactor :: Double -> Double -> Double -> Double
calculateWeightFactor oldWeight surplus transferableVotes = oldWeight * (realToFrac surplus / (oldWeight * transferableVotes))

-- if there are no other candidates in a list AFTER the current candidate, they have no transferable votes
calculateTransferable :: [[String]] -> String -> Int
calculateTransferable votes can = length ([x | x <- votes, x /= [] && head x == can && not (null (tail x))])

-- work out transferable count for inputted candidate
calculateSurplusPerCandidate :: [[String]] -> String -> String -> Int
calculateSurplusPerCandidate votes currentCan nextCan = length ([x | x <- votes, tail x /= [] && head x == currentCan && head (tail x) == nextCan])

-- add list of surpluses to the respective candidates
applySurplus :: [Double] -> [(String, Double)] -> [(String, Double)]
applySurplus surpluses votes = zip (map fst votes) (zipWith (+) surpluses (map snd votes))

startElection :: Double -> Int -> [(String, Double)] -> [(String, Double)] -> [(String, Double)] -> IO String
startElection _ _ elected _ []  = return (show elected)
startElection _ 0 elected _ _   = return (show elected)
startElection weight numSeats elected eliminated votes

  -- initial run, check if candidate equal or greater than quota - if so, elect them, distribute the surplus and re run the election
  | realToFrac (snd (head votes)) >= quota = do 
        let transferable = calculateTransferable finalVotes (fst (head votes))
        let weightFactor = calculateWeightFactor weight (realToFrac (snd (head votes)) - quota) (realToFrac transferable)
        let surplusForEach = [y | x <- filter (/= fst (head votes)) (map fst votes), let y = realToFrac(calculateSurplusPerCandidate finalVotes (fst (head votes)) x)]
        let adjustedSurplus = map (* weightFactor) surplusForEach
        let updatedVotes = applySurplus adjustedSurplus (tail votes)

        putStrLn "\nNEXT ROUND\n"
        print votes

        print $ show(fst (head votes)) ++ " is elected with weight of: " ++ show (snd (head votes))
        print $ "Redistributing surplus of: " ++ show(snd (head votes) - quota)
        print $ "Weight factor is: " ++ show weightFactor

        startElection weightFactor (numSeats - 1) (elected ++ [head votes]) eliminated updatedVotes

  -- if there is only one seat left and one candidate left, elect the candidate regardless
  | numSeats == 1 && length votes == 1 = 
        startElection weight (numSeats - 1) (elected ++ [head votes]) eliminated []

  -- else eliminate the candidate with the least first preferences and distribute their votes
  | otherwise = do 
        let transferable = calculateTransferable finalVotes (fst (last votes))
        let surplusForEach = [y | x <- filter (/= fst (last votes)) (map fst votes), let y = realToFrac (calculateSurplusPerCandidate finalVotes (fst (last votes)) x)]
        let adjustedSurplus = map (* weight) surplusForEach
        let updatedVotes = applySurplus adjustedSurplus (removeCandidate votes (last votes))

        putStrLn "\nQUOTA NOT MET, ELIMINATING AND DISTRIBUTING\n"
        print $ show(fst (last votes)) ++ " is eliminated with weight of: " ++ show (snd (last votes)) 
        print $ "Required quota: " ++ show quota

        startElection weight numSeats elected (eliminated ++ [last votes]) updatedVotes


main = do
    str <- startElection weight numSeats elected eliminated firstPref
    putStrLn str
------------------------
--      OLD CODE      --
------------------------

-- -- take first vote of sorted list of votes
-- extractFirstVote:: [String] -> (String, [String])
-- extractFirstVote (x:xs) = (x, xs)

-- -- seperate first vote from other votes
-- seperateVote :: [(String, [String])]
-- seperateVote = map (extractFirstVote) extractVotes

-- -- return a list of each first vote
-- listFirstVote :: [String]
-- listFirstVote = [fst x | x <- seperateVote]

-- -- get tuple of candidate and vote (modified from https://codereview.stackexchange.com/questions/88720/return-list-with-numbers-of-color-occurrences-in-another-list)
-- countFirstVote :: [String] -> [(String,Int)]
-- countFirstVote xs = isort (zip candidates (map (\x -> length (filter (== x) xs)) candidates))

-- -- get last candidate in sorted list
-- roundWinner :: Int -> (String, Int)
-- roundWinner index = (countFirstVote listFirstVote) !! (length (countFirstVote listFirstVote) - index)

-- -- if vote count exceeds quota, add surplus to next roundWinner
-- -- this needs to be recursive to change roundWinner value
-- getSurplus :: (String, Int) -> (String, Int)
-- getSurplus (x, y) | y > quota = (addSurplus quota (roundWinner 2))
--                   | otherwise = (x, y)

-- -- add surplus to candidate
-- addSurplus :: Int -> (String, Int) -> (String, Int)
-- addSurplus z (x, y) = (x, y + z) 

-- removeLoser :: [(String, Int)] -> [(String, Int)]
-- removeLoser xs = tail xs

-- calculateSurplusPerCandidate :: [[String]] -> String -> String -> Int
-- calculateSurplusPerCandidate votes currentCan nextCan = length ([x | x <- votes, tail x /= [] && head x == currentCan && nextCan `elem` [head (tail x)]])

-- redistributeVotes :: [(String, Int)] -> Double -> Double -> [(String, Int)]
-- redistributeVotes votes transferableVotes weightFactor = [(x, y+ round(transferableVotes * weightFactor)) | (x,y ) <- tail votes]

-- test7 = realToFrac (calculateTransferable finalVotes "D. Milliband")
-- test8 = calculateWeightFactor weight 111 43.5 test7 finalVotes
-- test9 = redistributeVotes firstPref 40 test8
-- test10 = zipWith (zipWith (+)) [1,2,3,4] [("D. Abbott",2),("E. Balls",18),("A. Burbhm",17),("E. Milliband",40)]

-- test13 surpluses votes = [y | x <- surpluses, let y = map (applySurplus x) votes]

-- calculate how much votes the next candidate should have after redistributing the surplus
-- calculateFinalSurplus :: Int -> Double -> Double
-- calculateFinalSurplus votesRecieved weightFactor = (realToFrac(votesRecieved) / (weightFactor)) - realToFrac(votesRecieved)

-- distributeSurplus :: [(String, Int)] -> Double -> [(String, Int)]
-- distributeSurplus votes surplus = [(x,y+ round(surplus)) | (x,y ) <- [head (tail votes)]] ++ tail (tail votes)

-- distributeEliminated :: [(String, Int)] -> Double -> [(String, Int)]
-- distributeEliminated votes surplus = [(x,y+ round(surplus)) | (x,y ) <- [head votes]] ++ removeCandidate (tail votes) (last votes)

-- test1 = calculateWeightFactor (snd (last firstPref)) (finalVotes) (fst (last firstPref))
-- test2 = calculateFinalSurplus (snd (last firstPref)) test1
-- test3 = distributeEliminated firstPref test2

-- recalculateAllVotes :: [(String, Int)] -> Double -> [(String, Int)]
-- recalculateAllVotes votes weightFactor = [(x, round ((realToFrac y) / weightFactor)) | (x,y) <- tail votes]

-- to do --> fix calculating transferable votes
-- drop from list until candidate is head of that list
-- ensure the tail of this new list is not null

-- test4 = getIndex "D. Milliband" "E. Milliband"
-- test5 = filter (/=[]) (reassembleVotes test4 (filterVotes "D. Milliband" "E. Milliband" finalVotes))
-- test6 = calculateTransferable test5 "D. Milliband"

-- reassembleVotes :: [Int] -> [[String]]-> [[String]]
-- reassembleVotes indexes votes = zipWith (drop) (indexes) (votes)

-- getIndex :: String -> String -> [Int]
-- getIndex currentCan nextCan = map (fromMaybe 0 . (nextCan `elemIndex`)) (filterVotes currentCan nextCan finalVotes)