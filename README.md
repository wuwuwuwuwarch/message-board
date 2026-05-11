# Message Board System

An online message board web application built with Java Servlet, JSP, and MySQL. This project implements a classic MVC-like architecture with full CRUD (Create, Read, Update, Delete) functionality, allowing users to post messages and administrators to manage them through a web interface.

## Project Overview

This project serves as a comprehensive demonstration of a three-layer web application architecture using core Java Enterprise technologies without any heavy framework dependencies. The system consists of public-facing pages for viewing and posting messages, and a password-protected admin panel for managing existing messages. The frontend utilizes Bootstrap 3 for responsive design and consistent styling across all pages, with custom CSS enhancements including glassmorphism effects and background images.

The technology stack is deliberately kept to fundamental Java web technologies: Java 8 as the runtime, Servlet 4.0 for request handling and control flow, JSP (JavaServer Pages) for view rendering, JSTL for template logic, and a MySQL database for persistent storage. The build system uses Maven with WAR packaging for deployment to standard Servlet containers like Apache Tomcat.

## Architecture

The application follows a structured layered architecture that separates concerns into distinct tiers:

### Data Layer (dao/)

The data access layer encapsulates all database interactions. The `NoteDAO` class provides methods for inserting, querying, updating, and deleting message records. It uses JDBC with PreparedStatement for parameterized queries, which helps prevent SQL injection attacks. The data access object pattern abstracts the underlying database operations, allowing the servlet layer to work with Java objects rather than raw SQL queries and result sets.

The `Note` class in the `dao.sqlBean` package serves as the data model (POJO), representing a single message entry with fields for user ID, title, content, email, IP address, and timestamp. Each field has corresponding getter and setter methods following JavaBean conventions, enabling seamless integration with JSP expression language and JSTL tags.

### Database Connection (util/)

The `DataBaseConnection` utility class manages the MySQL database connection lifecycle. It loads the JDBC driver, establishes connections using `DriverManager`, and provides a method to close connections when they are no longer needed. The connection parameters — including the database URL, username, and password — are configured as static constants. The database is configured to connect to a local MySQL instance with timezone set to Asia/Shanghai, SSL disabled, and UTF-8 character encoding enabled.

### Controller Layer (Servlet/)

Five servlet classes handle HTTP request routing and business logic coordination:

- **LoginServlet** — Processes administrator login requests by validating hard-coded credentials (admin/123456). On successful authentication, it creates a session attribute to maintain login state and redirects to the admin management page. Failed attempts are redirected back to the login page with an error parameter.

- **AddNoteServlet** — Handles new message submissions. It extracts form parameters including user ID, title, content, and email from the POST request, performs validation (checking for empty fields and email format via regex), records the submitter's IP address and current timestamp, then persists the message through NoteDAO.

- **QueryNoteByIdServlet** — Retrieves a specific message by its database ID and forwards the result to the edit page for modification. Returns a 404 error if the requested message does not exist.

- **UpdateNoteServlet** — Processes updates to existing messages. It accepts the message ID, updated title, and updated content from a POST request, creates a Note object with these values, and delegates the update operation to NoteDAO.

- **DeleteNoteByIdServlet** — Handles message deletion requests. It validates the message ID parameter, invokes the DAO's delete method, and returns appropriate HTTP error codes for invalid input (400) or missing records (404). It includes comprehensive error handling with java.util.logging for audit purposes.

### Presentation Layer (JSP)

The web views consist of five JSP pages:

- **index.jsp** — The main public page displaying all messages in a table layout. It uses JSTL forEach tags to iterate over the message list stored in the session and presents each message with the user ID, email, timestamp, title, and content. The page features a hero banner with a background image and a responsive Bootstrap navigation bar.

- **addNote.jsp** — A form page for submitting new messages. It includes input fields for user ID, name, email, title, and message content, with HTML5 validation attributes and Bootstrap styling.

- **login.jsp** — The administrator login page with a username and password form. It displays an error message when authentication fails, passed through the query string parameter `error=true`.

- **admin.jsp** — The admin dashboard that lists all messages in a table format with edit and delete action links for each entry. Delete operations include a JavaScript confirmation dialog to prevent accidental removals.

- **editNote.jsp** — A form pre-populated with an existing message's data, allowing the admin to modify the title and content. It queries the database directly using JDBC within the page.

## Database Schema

The application uses a MySQL database named `_messageboard` with a single table `note`:

```sql
CREATE TABLE note (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    email VARCHAR(255) NOT NULL,
    ip VARCHAR(45),
    writetime VARCHAR(30) NOT NULL
);
```

## Deployment Instructions

### Prerequisites

- Java Development Kit (JDK) 8 or later
- Apache Maven 3.x
- MySQL 5.7 or later
- A Servlet container such as Apache Tomcat 8 or later

### Setup Steps

1. **Database Setup**: Create the MySQL database and table using the schema provided above. Configure the database connection parameters in `src/main/java/util/DataBaseConnection.java` — update the password and any other connection settings as needed for your environment.

2. **Build the Project**: Run `mvn clean package` in the project root directory. This will generate a WAR file in the `target/` directory.

3. **Deploy**: Deploy the generated WAR file to your Servlet container. For Tomcat, copy the WAR file to the `webapps/` directory and start (or restart) the server.

4. **Access the Application**: Navigate to `http://localhost:8080/_messageboard/` (the exact URL depends on your server configuration and the WAR file name).

### Default Admin Credentials

- Username: `admin`
- Password: `123456`

## Key Features

- **Public Message Posting** — Any visitor can submit a message through the public form
- **Message Validation** — Server-side validation ensures all required fields are populated and email addresses follow a valid format
- **Admin Management** — Password-protected admin interface for editing and deleting messages
- **Responsive Design** — Bootstrap 3 provides a mobile-friendly interface
- **Visual Effects** — Custom CSS glassmorphism (backdrop-filter blur) and background images create a modern aesthetic
- **IP Logging** — The submitter's IP address is automatically recorded with each message

## Security Notes

This is an educational/demonstration project. Before using in any production environment, the following improvements should be considered:

- Replace hard-coded admin credentials with a database-backed or OAuth-based authentication system
- Remove database credentials from the source code and use environment variables or configuration files
- Add HTTPS support
- Implement CSRF protection for form submissions
- Add input sanitization and output encoding to prevent XSS vulnerabilities
- Hash passwords instead of storing or checking them in plain text
- Consider using a connection pool (e.g., HikariCP) instead of opening and closing connections per request

## License

This project is available for educational purposes.
