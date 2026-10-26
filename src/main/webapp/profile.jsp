<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 27-10-2026
  Time: 00:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>

<%!
  // Escape user-provided text before displaying it in HTML.
  private String escapeHtml(String value) {
    if (value == null) {
      return "";
    }

    return value.replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#x27;");
  }
%>

<%
  // This page must be accessed through ProfileServlet.
  User profileUser = (User) request.getAttribute("profileUser");

  if (session == null || session.getAttribute("userId") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }

  if (profileUser == null) {
    response.sendRedirect(request.getContextPath() + "/profile");
    return;
  }

  String fullName = profileUser.getFullName();
  String email = profileUser.getEmail();

  String role = profileUser.getRole() != null
          ? profileUser.getRole().name().replace("_", " ")
          : "STUDENT";

  Date createdAt = profileUser.getCreatedAt();

  String joinedDate = "Not available";
  if (createdAt != null) {
    joinedDate = new SimpleDateFormat(
            "dd MMMM yyyy", Locale.ENGLISH
    ).format(createdAt);
  }

  String message = request.getParameter("message");
  boolean success = "Profile updated successfully!".equals(message);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>My Profile | LifeLink Campus</title>

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: #f3f7f6;
      color: #253b3a;
      min-height: 100vh;
    }

    .navbar {
      height: 76px;
      background: #194e4b;
      color: #ffffff;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 7%;
      box-shadow: 0 4px 18px rgba(25, 78, 75, 0.14);
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      color: white;
      text-decoration: none;
      font-size: 23px;
      font-weight: 750;
      letter-spacing: 0.2px;
    }

    .brand-icon {
      width: 42px;
      height: 42px;
      border-radius: 13px;
      background: #ffffff;
      color: #246b68;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 25px;
      font-weight: bold;
    }

    .nav-links {
      display: flex;
      align-items: center;
      gap: 25px;
    }

    .nav-links a {
      color: #e7f2ef;
      text-decoration: none;
      font-size: 14px;
      font-weight: 600;
      transition: 0.2s;
    }

    .nav-links a:hover,
    .nav-links a.active {
      color: #ffffff;
    }

    .nav-links a.active {
      border-bottom: 2px solid #e9b7c1;
      padding-bottom: 7px;
    }

    .logout-link {
      padding: 10px 17px;
      border: 1px solid rgba(255, 255, 255, 0.5);
      border-radius: 9px;
    }

    .page-container {
      width: min(1100px, 90%);
      margin: 42px auto 60px;
    }

    .page-heading {
      margin-bottom: 28px;
    }

    .eyebrow {
      color: #941b36;
      font-size: 12px;
      letter-spacing: 2px;
      font-weight: 800;
      text-transform: uppercase;
      margin-bottom: 9px;
    }

    .page-heading h1 {
      font-size: clamp(29px, 4vw, 38px);
      color: #194e4b;
      margin-bottom: 9px;
    }

    .page-heading h1 span {
      color: #941b36;
    }

    .page-subtitle {
      color: #738481;
      font-size: 15px;
      line-height: 1.6;
    }

    .profile-layout {
      display: grid;
      grid-template-columns: 310px 1fr;
      gap: 25px;
      align-items: start;
    }

    .profile-card,
    .details-card {
      background: #ffffff;
      border-radius: 20px;
      border: 1px solid #e2ece9;
      box-shadow: 0 12px 35px rgba(25, 78, 75, 0.06);
    }

    .profile-card {
      overflow: hidden;
      text-align: center;
    }

    .profile-banner {
      height: 115px;
      background: linear-gradient(135deg, #194e4b, #348b83);
      position: relative;
    }

    .profile-avatar {
      width: 104px;
      height: 104px;
      border-radius: 50%;
      background: #ffffff;
      border: 5px solid #ffffff;
      color: #246b68;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 42px;
      font-weight: 750;
      margin: -53px auto 15px;
      position: relative;
      box-shadow: 0 5px 18px rgba(25, 78, 75, 0.13);
    }

    .profile-summary {
      padding: 0 23px 26px;
    }

    .profile-summary h2 {
      color: #194e4b;
      font-size: 21px;
      overflow-wrap: anywhere;
      margin-bottom: 8px;
    }

    .profile-summary .email {
      color: #758582;
      font-size: 13px;
      line-height: 1.6;
      overflow-wrap: anywhere;
      margin-bottom: 17px;
    }

    .role-badge {
      display: inline-block;
      background: #f8e9ed;
      color: #941b36;
      border: 1px solid #f0d1d9;
      border-radius: 30px;
      padding: 7px 15px;
      font-size: 11px;
      font-weight: 800;
      letter-spacing: 1px;
    }

    .summary-divider {
      height: 1px;
      background: #edf1f0;
      margin: 22px 0;
    }

    .joined-label {
      font-size: 12px;
      color: #879491;
      margin-bottom: 6px;
    }

    .joined-date {
      font-size: 14px;
      color: #194e4b;
      font-weight: 700;
    }

    .details-card {
      padding: 32px;
    }

    .details-heading {
      margin-bottom: 28px;
    }

    .details-heading h2 {
      color: #194e4b;
      font-size: 22px;
      margin-bottom: 8px;
    }

    .details-heading p {
      font-size: 13px;
      color: #81908d;
      line-height: 1.6;
    }

    .message {
      padding: 13px 15px;
      border-radius: 10px;
      font-size: 13px;
      margin-bottom: 23px;
      line-height: 1.5;
      overflow-wrap: anywhere;
    }

    .message.success {
      background: #e8f6ed;
      border: 1px solid #c5e8d0;
      color: #216b3b;
    }

    .message.error {
      background: #fff0f1;
      border: 1px solid #f0cbd1;
      color: #941b36;
    }

    .form-group {
      margin-bottom: 23px;
    }

    .form-group label {
      display: block;
      margin-bottom: 9px;
      color: #344d49;
      font-size: 13px;
      font-weight: 700;
    }

    .required {
      color: #941b36;
    }

    .form-group input {
      width: 100%;
      height: 49px;
      padding: 0 15px;
      border: 1px solid #d9e5e2;
      border-radius: 10px;
      outline: none;
      color: #294642;
      background: #ffffff;
      font-size: 14px;
      font-family: inherit;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .form-group input:focus {
      border-color: #348b83;
      box-shadow: 0 0 0 3px rgba(52, 139, 131, 0.12);
    }

    .form-hint {
      display: block;
      color: #84918f;
      font-size: 11px;
      margin-top: 8px;
      line-height: 1.5;
    }

    .form-actions {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
      margin-top: 30px;
      padding-top: 23px;
      border-top: 1px solid #edf1f0;
    }

    .btn {
      min-height: 46px;
      display: inline-flex;
      justify-content: center;
      align-items: center;
      padding: 0 22px;
      border-radius: 10px;
      text-decoration: none;
      font-size: 13px;
      font-family: inherit;
      font-weight: 750;
      cursor: pointer;
      transition: 0.2s;
    }

    .btn-primary {
      border: 1px solid #246b68;
      background: #246b68;
      color: #ffffff;
    }

    .btn-primary:hover {
      background: #194e4b;
      border-color: #194e4b;
      transform: translateY(-1px);
    }

    .btn-secondary {
      background: #ffffff;
      border: 1px solid #d9e5e2;
      color: #536965;
    }

    .btn-secondary:hover {
      background: #f3f7f6;
    }

    .footer {
      text-align: center;
      color: #879491;
      font-size: 12px;
      padding: 0 15px 25px;
    }

    @media (max-width: 800px) {
      .navbar {
        height: auto;
        min-height: 76px;
        padding: 17px 5%;
        gap: 18px;
        flex-wrap: wrap;
      }

      .nav-links {
        gap: 15px;
        flex-wrap: wrap;
      }

      .profile-layout {
        grid-template-columns: 1fr;
      }

      .profile-card {
        max-width: 100%;
      }

      .details-card {
        padding: 25px 20px;
      }
    }

    @media (max-width: 480px) {
      .brand {
        font-size: 19px;
      }

      .nav-links {
        gap: 12px;
      }

      .nav-links a {
        font-size: 12px;
      }

      .page-container {
        margin-top: 30px;
      }

      .form-actions .btn {
        width: 100%;
      }
    }
  </style>
</head>

<body>

<nav class="navbar">
  <a class="brand" href="<%= request.getContextPath() %>/dashboard.jsp">
    <span class="brand-icon">&#9829;</span>
    <span>LifeLink Campus</span>
  </a>

  <div class="nav-links">
    <a href="<%= request.getContextPath() %>/dashboard.jsp">Dashboard</a>
    <a href="<%= request.getContextPath() %>/profile" class="active">My Profile</a>
    <a href="<%= request.getContextPath() %>/donor-profile.jsp">Donor</a>
    <a href="<%= request.getContextPath() %>/logout" class="logout-link">Logout</a>
  </div>
</nav>

<main class="page-container">

  <header class="page-heading">
    <p class="eyebrow">YOUR ACCOUNT, YOUR DETAILS</p>
    <h1>My Profile <span>&#10022;</span></h1>
    <p class="page-subtitle">
      Manage your personal information and keep your LifeLink Campus
      account up to date.
    </p>
  </header>

  <section class="profile-layout">

    <!-- LEFT: PROFILE SUMMARY -->
    <aside class="profile-card">

      <div class="profile-banner"></div>

      <div class="profile-avatar">
        <%= escapeHtml(
                fullName != null && !fullName.trim().isEmpty()
                        ? fullName.trim().substring(0, 1).toUpperCase()
                        : "U"
        ) %>
      </div>

      <div class="profile-summary">
        <h2><%= escapeHtml(fullName) %></h2>

        <p class="email"><%= escapeHtml(email) %></p>

        <span class="role-badge">
                    <%= escapeHtml(role) %>
                </span>

        <div class="summary-divider"></div>

        <p class="joined-label">Member since</p>
        <p class="joined-date">
          <%= escapeHtml(joinedDate) %>
        </p>
      </div>

    </aside>

    <!-- RIGHT: EDIT PROFILE -->
    <section class="details-card">

      <div class="details-heading">
        <h2>Personal Information</h2>
        <p>
          Update your name or email address below.
          Your account role cannot be changed here.
        </p>
      </div>

      <% if (message != null && !message.trim().isEmpty()) { %>
      <div class="message <%= success ? "success" : "error" %>"
           role="status">
        <%= escapeHtml(message) %>
      </div>
      <% } %>

      <form action="<%= request.getContextPath() %>/profile"
            method="post">

        <div class="form-group">
          <label for="fullName">
            Full Name <span class="required">*</span>
          </label>

          <input
                  type="text"
                  id="fullName"
                  name="fullName"
                  value="<%= escapeHtml(fullName) %>"
                  maxlength="100"
                  autocomplete="name"
                  placeholder="Enter your full name"
                  required>
        </div>

        <div class="form-group">
          <label for="email">
            Email Address <span class="required">*</span>
          </label>

          <input
                  type="email"
                  id="email"
                  name="email"
                  value="<%= escapeHtml(email) %>"
                  maxlength="150"
                  autocomplete="email"
                  placeholder="Enter your email address"
                  required>

          <span class="form-hint">
                        Your email address must be unique to your account.
                    </span>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">
            &#10003; Save Changes
          </button>

          <a href="<%= request.getContextPath() %>/dashboard.jsp"
             class="btn btn-secondary">
            Cancel
          </a>
        </div>

      </form>

    </section>

  </section>

</main>

<footer class="footer">
  LifeLink Campus &copy; 2026. Connecting people, creating impact.
</footer>

</body>
</html>

