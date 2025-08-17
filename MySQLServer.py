import mysql.connector
from mysql.connector import Error

def create_database():
    """Create the 'alx_book_store' database if it doesn't already exist."""
    connection = None
    cursor = None
    try:
        # 1) Connect to the MySQL *server* (not to any database yet)
        connection = mysql.connector.connect(
            host="localhost",      # change if your server is remote
            user="root",           # <-- put your MySQL username here
            password="@Tb5te2300"  # <-- put your MySQL password here
        )

        # 2) Use a cursor to send SQL to MySQL
        cursor = connection.cursor()

        # 3) Create the database safely (no SELECT/SHOW used)
        cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")

        # 4) Print the required success message
        print("Database 'alx_book_store' created successfully!")

    except Error as e:
        # If connection fails or SQL fails, print a clear error
        print(f"Error while connecting to MySQL: {e}")

    finally:
        # 5) Always close cursor and connection
        if cursor is not None:
            try:
                cursor.close()
            except Exception:
                pass
        if connection is not None:
            try:
                if connection.is_connected():
                    connection.close()
            except Exception:
                pass

if __name__ == "__main__":
    create_database()
