/*1. Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in Sequel Ace as you go.

2. Use the albums_db database.

3. Explore the structure of the albums table.

a. How many rows are in the albums table?
31
b. How many unique artist names are in the albums table?
22
c. What is the primary key for the albums table?
'id'
d. What is the oldest release date for any album in the albums table? What is the most recent release date?
1967
4. Write queries to find the following information:

a. The name of all albums by Pink Floyd
The Dark Side of the Moon, The Wall
b. The year Sgt. Pepper's Lonely Hearts Club Band was released
1967
c. The genre for the album Nevermind
Grunge, Alternative Rock
d. Which albums were released in the 1990s
The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural

e. Which albums had less than 20 million certified sales
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall

f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? 
Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural

Because I didn't specify albums that include the string 'Rock' just which albums are equal to 'Rock'
*/
#1 done
#2 done
#3, 3c
SHOW CREATE TABLE albums;

#3b
SELECT DISTINCT artist
FROM albums
WHERE artist != 'Various artists';

#4a
SELECT name
FROM albums 
WHERE artist = 'Pink Floyd';

#4b
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

#4c
SELECT genre
FROM albums
WHERE name = 'Nevermind';

#4d
SELECT name
FROM albums
WHERE release_date <= 1999 and release_date >= 1990;

#4e
SELECT name
FROM albums
WHERE sales < 20;
