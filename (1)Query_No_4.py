# -*- coding: utf-8 -*-
import mysql.connector

# Connect to my server(localhost)
con = mysql.connector.connect(user='root',
                              password='dgu1234!',
                              host='localhost',
                              database='facebook2',
                              charset='utf8')
# utf8 for korean language

# Define cursor variable that will receives results of query
cur = con.cursor()
cur.execute("set names utf8")

# Query clause that I want to search
query = """select count(*) as post_num
           from post natural join user
           where name="유지훈" and exists(select post_id
							              from post
where user_id in(select user_id from user where name="유지훈"));
"""

# Execute aforementioned query at server was connected
cur.execute(query)

# Show result
for (post_count) in cur:
    print("{}".format(post_count[0]))

# Close Cursor and connection with my server
cur.close()
con.close()