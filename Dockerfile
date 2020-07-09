FROM ubuntu

WORKDIR /app

RUN apt-get update -y

RUN apt-get install -y build-essential wget unzip libreadline-dev libsqlite3-dev libedit-dev

RUN wget https://www.sqlite.org/2020/sqlite-amalgamation-3320300.zip

RUN unzip sqlite-amalgamation-3320300.zip


RUN cd sqlite-amalgamation-3320300/ && gcc -Os -I. -DSQLITE_THREADSAFE=0 -DSQLITE_ENABLE_FTS4 \
   -DSQLITE_ENABLE_FTS5 -DSQLITE_ENABLE_JSON1 \
   -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_EXPLAIN_COMMENTS \
   -DHAVE_USLEEP -DHAVE_READLINE \
   -DSQLITE_ENABLE_LOAD_EXTENSION \
   shell.c sqlite3.c -ldl -lreadline -lncurses -lm -o sqlite3  

RUN cp sqlite-amalgamation-3320300/sqlite3 /app/sqlite3

EXPOSE 5000

COPY . .

RUN gcc -fPIC -shared extension-functions.c -o extension-functions.so -lm

RUN /app/sqlite3 test.db ".read load_extension.sql"

