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

# SQL Query clause using stored function that I defined during HW
func = """SELECT total_users_number()"""

# Execute aforementioned function at server was connected
cur.execute(func)

for result in cur:
    print("Total user: {}".format(result[0]))

# Close Cursor and connection with my server
cur.close()
con.close()