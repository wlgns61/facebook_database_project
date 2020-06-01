# -*- coding: utf-8 -*-
import mysql.connector
import datetime

#페이스 북 구현
class Facebook:
    def __init__(self):
        # Connect to my server(localhost)
        self.con = mysql.connector.connect(user='root',
                                      password='dgu1234!',
                                      host='localhost',
                                      database='facebook2',
                                      charset='utf8')  # utf8 for korean language

        # Define cursor variable that will receives results of query
        self.cur = self.con.cursor(buffered=True)
        self.cur.execute("set names utf8")
        self.login_status = False
        self.user_id = ""

#----------------------------------------------------------------------------------------------------------
    def InsertAccount(self, name, birth, phone, gender, address):
        # Register Account(Insert

        # Checking Logged-in
        if (self.login_status==True):
            print ("Please do again After logout")
        else:
            query = "select user_id from user;"
            self.cur.execute(query)
            existing_user_id = []

            #Give new user ID
            for u_id in self.cur:
                existing_user_id.append(int(u_id[0]))
            user_id = max(existing_user_id) + 1

            query = """insert user values ("{}", "{}", {}, "{}", "{}","{}");""".\
                format(str(user_id), str(name), int(birth), str(phone), str(gender), str(address))
            self.cur.execute(query)
            self.con.commit()

            print("'{}' is registered successfully".format(name))
            print("""{}'s user_id is '{}'""".format(name, user_id))

# ----------------------------------------------------------------------------------------------------------
    def Login(self, user_id):
        #Login to Facebook

        # Checking Logged-in
        if(self.login_status == False):
            query = "select user_id from user;"
            self.cur.execute(query)
            existing_user_id = []

            # Find existing ID in UserList
            for u_id in self.cur:
                existing_user_id.append(int(u_id[0]))
            for u_id in existing_user_id:
                if(u_id == int(user_id)):
                    self.user_id = str(user_id)
                    self.login_status = True

            if(self.login_status==True):
                print("\nLogin successfully")
            else:
                print("\nThe user_id:'{}' is not exist".format(user_id))

        else:
            print("\nAlready logged-in. Please login after logout")

# ----------------------------------------------------------------------------------------------------------
    def Logout(self):
        # Account Logout

        # Checking Logged-in
        if(self.login_status==True):
            self.user_id = ""
            self.login_status = False
            print("\nLogout successfully")
        else:
            print("\nAny account is not login ")

# ----------------------------------------------------------------------------------------------------------
    def UserInfo(self):
        # Print logged-in user's Information

        # Checking Logged-in
        if(self.login_status==True):
            query = "select * from user where user_id='{}';".format(self.user_id)
            self.cur.execute(query)

            print("\n-------------------------------AccountInfo-------------------------------")
            for (user_id, name, birth, phone, gender, address) in self.cur:
                print("{:2} | {:2} | {:6} | {:14} | {:6} | {:10}".format(
                    user_id, name.encode('utf8'), birth, phone.encode('utf8'), gender.encode('utf8'),
                    address.encode('utf8')))
        else:
            print("Any account is not login ")

# ----------------------------------------------------------------------------------------------------------
    def Posting(self, contents, location="동국대학교"):

        # Checking Logged-in
        if(self.login_status==True):
            query = "select post_id from post where user_id = '{}';".format(self.user_id)
            self.cur.execute(query)
            existing_post_id = []

            #Give new post ID
            for p_id in self.cur:
                existing_post_id.append(int(p_id[0]))
            if not existing_post_id:
                post_id = "00"
            else:
                post_id = max(existing_post_id)+1
                if(post_id < 10):
                    post_id = "0" + str(post_id)

            now = datetime.datetime.now()

            # Make a Date Type Consistent
            if (now.month < 10):
                month = "0"+ str(now.month)
            else:
                month = str(now.month)
            if (now.day < 10):
                day = "0" + str(now.day)
            else:
                day = str(now.day)

            date = str(now.year) + str(month) + str(day)

            query = """insert post values ("{}","{}",{},"{}","{}")""".\
                format(str(post_id), self.user_id, int(date), str(location), str(contents))
            self.cur.execute(query)
            self.con.commit()

            print ("\nPosting Successfully")
            print ("The post_id is '{}'".format(post_id))

        else:
            print("For posting, you have to login!")

# ----------------------------------------------------------------------------------------------------------
    def Comments(self, post_id, poster_id, text):
        # Comments at post

        # Checking login
        if (self.login_status == True):
            # Searching post
            query = "select count(*) from post where user_id ='{}' and post_id = '{}'".\
                format(str(poster_id), str(post_id))
            self.cur.execute(query)
            for n in self.cur:
                num = int(n[0])
            if (num == 0):
                print("The post is not exist.")
            # If Post exists
            else:
                query = "select comment_id from comments where user_id ='{}' and post_id = '{}'".\
                    format(str(poster_id), str(post_id))
                self.cur.execute(query)

                # Give a new comment_id
                existing_comment_id = []
                for comment_id in self.cur:
                    existing_comment_id.append(int(comment_id[0]))
                if not existing_comment_id:
                    comment_id = "000"
                else:
                    comment_id = max(existing_comment_id) + 1
                    if (comment_id < 10):
                        comment_id = "00" + str(comment_id)
                    elif (10 <= comment_id < 100):
                        comment_id = "0" + str(comment_id)

                now = datetime.datetime.now()

                # Make a Date Type Consistent
                if (now.month < 10):
                    month = "0" + str(now.month)
                else:
                    month = str(now.month)
                if (now.day < 10):
                    day = "0" + str(now.day)
                else:
                    day = str(now.day)

                date = str(now.year) + str(month) + str(day)

                query = "select (select name from user where user_id = '{}') as name, post_id, contents from post where user_id ='{}' and post_id = '{}'"\
                    .format(str(poster_id), str(poster_id), str(post_id))
                self.cur.execute(query)

                for name, post_id, contents in self.cur:
                    print("\n\nname: '{:1}' | post_id : '{:1}' \n '{:5}'".
                          format(name.encode('utf8'), post_id, contents.encode('utf8')))


                query = "insert comments values ('{}','{}','{}','{}', {}, '{}')".\
                    format(str(comment_id), str(post_id), str(poster_id), str(self.user_id), int(date), str(text))
                self.cur.execute(query)
                self.con.commit()
                print ("Commenting on the post successfully")
                print ("-------------------------------Comments-------------------------------")
                query = "select comment_id, text from comments where user_id = '{}' and post_id='{}'".\
                    format(poster_id, post_id)
                self.cur.execute(query)
                for comment_id, text in self.cur:
                    print("'{:2}' | '{:6}'".format(comment_id, text.encode('utf8')))



        else:
            print("\nFor commenting on the post, you have to login")

# ----------------------------------------------------------------------------------------------------------
    def Like(self, post_id, poster_id):
        if (self.login_status == True):
            # Searching post
            query = "select count(*) from post where user_id ='{}' and post_id = '{}'".format(str(poster_id),
                                                                                              str(post_id))
            self.cur.execute(query)
            for n in self.cur:
                num = int(n[0])
            if (num == 0):
                print("The post is not exist.")
            # If Post exists
            else:
                query = "select like_id from likes where user_id ='{}' and post_id = '{}'".format(str(poster_id),
                                                                                                        str(post_id))
                self.cur.execute(query)

                # Give a new comment_id
                existing_like_id = []
                for like_id in self.cur:
                    existing_like_id.append(int(like_id[0]))
                if not existing_like_id:
                    like_id = "0000"
                else:
                    like_id = max(existing_like_id) + 1
                    if (like_id < 10):
                        like_id = "000" + str(like_id)
                    elif (10 <= like_id < 100):
                        like_id = "00" + str(like_id)
                    elif (100 <= like_id < 1000):
                        like_id = "0" + str(like_id)

            query = "select (select name from user where user_id = '{}') as name, post_id, contents from post where user_id ='{}' and post_id = '{}'"\
                .format(str(poster_id), str(poster_id), str(post_id))
            self.cur.execute(query)

            for name, post_id, contents in self.cur:
                print("\n\nname: '{:1}' | post_id : '{:1}' \n '{:5}'".format(name.encode('utf8'), post_id,
                                                                             contents.encode('utf8')))

            query = "select liker_id, user_id, post_id from likes where user_id ='{}' and post_id='{}'"\
                .format(poster_id, post_id)
            self.cur.execute(query)

            # For checking like already
            check = 0
            for liker_id, _, _ in self.cur:
                if (liker_id == self.user_id):
                    print("Already you did Like")
                    check = 1
                    query = "select count(*) from likes where user_id='{}' and post_id='{}'"\
                        .format(poster_id, post_id)
                    self.cur.execute(query)
                    for num_likes in self.cur:
                        print("Like:{}".format(int(num_likes[0])))
                    break

            if(check == 0):
                query = "insert likes values ('{}', '{}', '{}', '{}')".format(like_id, post_id, poster_id, self.user_id)
                self.cur.execute(query)
                self.con.commit()
                print ("Like on the post successfully")

                query = "select count(*) from likes where user_id='{}' and post_id='{}'".format(poster_id, post_id)
                self.cur.execute(query)
                for num_likes in self.cur:
                    print("Like:{}".format(int(num_likes[0])))

        else:
            print("\nFor like on the post, you have to login")

# ----------------------------------------------------------------------------------------------------------
    def Timeline(self):
        if (self.login_status == True):
            print("\n---------------------------Timeline---------------------------")
            query = "select name, user_id, post_id, date, contents from post natural join user order by date desc"
            self.cur.execute(query)
            for name, user_id, post_id, date, contents in self.cur:
                print("name: '{}' | poster_id: '{}' | post_id: '{}' | date: '{}' \n contents: '{}'").\
                    format(name.encode('utf8'), user_id, post_id, date, contents.encode('utf8'))
        else:
            print("For showing, you have to login")

#----------------------------------------------------------------------------------------------------------

facebook = Facebook()

# 모든 메소드는 대문자로 시작

#facebook.InsertAccount("김지민","19950602","01000001234","남자","중앙동")
#facebook.InsertAccount("김가영","19970604","01022221234","여자","필동")


#facebook.InsertAccount("크크켘","19950602","01000001234","남자","중앙둥")
facebook.Login(2)
#facebook.Posting("데이터베이스 과제하는중!!!","신공학관")
#facebook.Logout()
#facebook.Login(1)
#facebook.UserInfo()
#facebook.Comments("02","1", "ㅠㅠ힘들겠다 조금만힘내자!")
#facebook.Comments("02","1", "얼른 과제끝내고 맛있는거 먹자 ㅎㅅㅎ")
facebook.Timeline()
#facebook.Logout()
#facebook.Login(2)
#facebook.UserInfo()
#facebook.Like("00", "3")
#facebook.Timeline()













