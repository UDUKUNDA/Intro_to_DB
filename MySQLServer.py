import os
import sys

try:
    import mysql.connector
    from mysql.connector import Error
except Exception as e:
    print("Error: mysql-connector-python is not installed. Install with 'pip install mysql-connector-python'.")
    sys.exit(1)


def create_database(db_name: str) -> None:
    """
    Create the MySQL database if it does not exist.
    Requirements:
    - No SELECT or SHOW statements
    - If the database exists, do not fail
    - Print success message on creation
    - Handle connection errors and ensure resources are closed
    """
    host = os.getenv("MYSQL_HOST", "localhost")
    user = os.getenv("MYSQL_USER", "root")
    password = os.getenv("MYSQL_PASSWORD", "")
    port = int(os.getenv("MYSQL_PORT", "3306"))

    conn = None
    cursor = None

    try:
        # Open connection (no default database specified)
        conn = mysql.connector.connect(host=host, user=user, password=password, port=port)
        conn.autocommit = True

        cursor = conn.cursor()
        # Create database without using SELECT/SHOW
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{db_name}`")
        print(f"Database '{db_name}' created successfully!")

    except Error as err:
        print(f"Error connecting to the DB: {err}")
    except Exception as ex:
        print(f"Unexpected error: {ex}")
    finally:
        # Close resources cleanly
        try:
            if cursor is not None:
                cursor.close()
        except Exception:
            pass
        try:
            if conn is not None and conn.is_connected():
                conn.close()
        except Exception:
            pass


if __name__ == "__main__":
    create_database("alx_book_store")