# -*- coding: utf-8 -*-
import mysql.connector

# Connect to my server(localhost)
con = mysql.connector.connect(user='root',
                              password='dgu1234!',
                              host='localhost',
                              database='facebook2',
                              charset='utf8')
# Define cursor variable that will receives results of query
cur = con.cursor()

# I try to find number of likes with user_id = '0'
args = ['0']
# Call the procedure that I defined at DB before.
cur.callproc('get_like_count', args)

for result in cur.stored_results():
    result = result.fetchall()
    user_id = result[0][0].encode('utf8')
    num_likes = result[0][1]
    print("user_id: {} | num_likes: {}".format(user_id, num_likes))

# Close Cursor and connection with my server
cur.close()
con.close()