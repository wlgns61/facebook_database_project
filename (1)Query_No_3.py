# -*- coding: utf-8 -*-
import mysql.connector

# Connect to my server(localhost)
con = mysql.connector.connect(user='root',
                              password='dgu1234!',
                              host='localhost',
                              database='facebook2',
                              charset='utf8') # utf8 for korean language

# Define cursor variable that will receives results of query
cur = con.cursor()
cur.execute("set names utf8")

# Query clause that I want to search
query = """select count(*) as total_likes
from likes
group by user_id
having user_id in (select user_id from user where name='박현태');"""

# Execute aforementioned query at server was connected
cur.execute(query)

# Show result
for (total_likes) in cur:
    print("{}".format(total_likes))

# Close Cursor and connection with my server
cur.close()
con.close()