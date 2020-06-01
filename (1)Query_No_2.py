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
query = """select * from post P natural join likes L where L.liker_id 
= (select user_id from user where name='{}')""".format("손준영")

# Execute aforementioned query at server was connected
cur.execute(query)

# Show result
for (p_id, u_id, date, location, contents, like_id, liker_id) in cur:
    print("{:2} | {:2} | {:6} | {:14} | {:10} | {:2} | {:2}".format(
        p_id, u_id, date, location.encode('utf8'), contents.encode('utf8'),
        like_id, liker_id))

# Close Cursor and connection with my server
cur.close()
con.close()