<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 25-10-2026
  Time: 01:01
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.Donor" %>
<%@ page import="entity.BloodGroup" %>
<%@ page import="entity.AvailabilityStatus" %>

<%
  Donor donor = (Donor) request.getAttribute("donor");
  String formMode = (String) request.getAttribute("formMode");
  boolean isUpdate = "update".equals(formMode) && donor != null;

  String message = (String) request.getAttribute("message");
  String messageType = (String) request.getAttribute("messageType");

  String bloodGroupValue = request.getParameter("bloodGroup");
  String phoneValue = request.getParameter("phone");
  String collegeValue = request.getParameter("college");
  String availabilityValue = request.getParameter("availabilityStatus");
  String consentValue = request.getParameter("consentToContact");

  if (bloodGroupValue == null && donor != null && donor.getBloodGroup() != null) {
    bloodGroupValue = donor.getBloodGroup().getLabel();
  }

  if (phoneValue == null && donor != null) {
    phoneValue = donor.getPhone();
  }

  if (collegeValue == null && donor != null) {
    collegeValue = donor.getCollege();
  }

  if (availabilityValue == null && donor != null
          && donor.getAvailabilityStatus() != null) {
    availabilityValue = donor.getAvailabilityStatus().name();
  }

  boolean consentChecked;
  if (request.getParameterMap().containsKey("consentToContact")) {
    consentChecked = "true".equals(consentValue);
  } else {
    consentChecked = donor != null && donor.isConsentToContact();
  }

  if (bloodGroupValue == null) bloodGroupValue = "";
  if (phoneValue == null) phoneValue = "";
  if (collegeValue == null) collegeValue = "";
  if (availabilityValue == null) availabilityValue = "AVAILABLE";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>Become a Donor | LifeLink Campus</title>


    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --teal: #246b68;
            --teal-dark: #194e4b;
            --teal-light: #e7f3f0;
            --burgundy: #941b36;
            --burgundy-dark: #77152b;
            --text: #193735;
            --muted: #657a78;
            --border: #dce9e5;
            --background: #f4f8f6;
            --white: #ffffff;
            --shadow: 0 12px 38px rgba(25, 78, 75, 0.08);
        }

        body {
            font-family: "Trebuchet MS", "Segoe UI", Arial, sans-serif;
            background: var(--background);
            color: var(--text);
            min-height: 100vh;
        }

        a {
            transition: color 0.2s ease, background 0.2s ease;
        }

        /* NAVBAR */

        .navbar {
            min-height: 85px;
            padding: 16px 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            background: rgba(255, 255, 255, 0.97);
            border-bottom: 1px solid var(--border);
            box-shadow: 0 4px 18px rgba(25, 78, 75, 0.04);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .brand-icon {
            width: 46px;
            height: 46px;
            border-radius: 13px;
            background: var(--teal);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: bold;
            box-shadow: 0 6px 15px rgba(36, 107, 104, 0.2);
        }

        .brand-name {
            font-size: 21px;
            font-weight: 800;
            letter-spacing: -0.6px;
            color: var(--text);
        }

        .brand-name span {
            color: var(--burgundy);
        }

        .brand-subtitle {
            margin-top: 5px;
            font-size: 10px;
            color: var(--muted);
            letter-spacing: 1.3px;
            text-transform: uppercase;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 17px;
            font-size: 13px;
        }

        .nav-greeting {
            color: var(--muted);
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--teal-light);
            color: var(--teal);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 1px solid #d2e7df;
        }

        .nav-right a {
            text-decoration: none;
            color: var(--burgundy);
            font-weight: bold;
        }

        .nav-right a:hover {
            color: var(--teal);
        }

        /* MAIN PAGE */

        .page-container {
            width: min(1100px, 92%);
            margin: 38px auto 65px;
        }

        .breadcrumb {
            font-size: 12px;
            color: var(--muted);
            margin-bottom: 27px;
        }

        .breadcrumb a {
            color: var(--teal);
            text-decoration: none;
            font-weight: 700;
        }

        .breadcrumb a:hover {
            color: var(--burgundy);
        }

        .breadcrumb span {
            margin: 0 10px;
            color: #9aadaa;
        }

        .breadcrumb strong {
            color: var(--text);
        }

        .eyebrow {
            color: var(--burgundy);
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 2px;
            margin-bottom: 13px;
        }

        h1 {
            font-size: clamp(28px, 4vw, 38px);
            letter-spacing: -1px;
            line-height: 1.25;
            color: var(--teal-dark);
            margin-bottom: 13px;
        }

        .intro {
            color: var(--muted);
            font-size: 14px;
            line-height: 1.9;
            max-width: 700px;
            margin-bottom: 30px;
        }

        /* FORM CARD */

        .form-card {
            width: 100%;
            max-width: 850px;
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 34px;
            box-shadow: var(--shadow);
            animation: fadeUp 0.55s ease both;
        }

        .card-heading {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
        }

        .heart-icon {
            width: 54px;
            height: 54px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8e9ed;
            border: 1px solid #f1d8df;
            border-radius: 15px;
            color: var(--burgundy);
            font-size: 25px;
        }

        .card-heading h2 {
            font-size: 20px;
            color: var(--teal-dark);
            margin-bottom: 7px;
        }

        .card-heading p {
            font-size: 12px;
            color: var(--muted);
            line-height: 1.7;
        }

        .section-title {
            font-size: 13px;
            font-weight: 800;
            color: var(--teal-dark);
            padding-bottom: 14px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 22px;
        }

        /* FORM GRID */

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 24px 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 9px;
            min-width: 0;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: var(--text);
        }

        .required {
            color: var(--burgundy);
        }

        .form-group input,
        .form-group select {
            display: block;
            width: 100%;
            min-width: 0;
            height: 49px;
            padding: 0 14px;
            border: 1px solid #cbded9;
            border-radius: 9px;
            background: #fbfefd;
            color: var(--text);
            font-family: inherit;
            font-size: 13px;
            outline: none;
            transition: border-color 0.2s ease,
            box-shadow 0.2s ease,
            background 0.2s ease;
        }

        .form-group input::placeholder {
            color: #9aadaa;
        }

        .form-group input:hover,
        .form-group select:hover {
            border-color: #9fc8bd;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--teal);
            box-shadow: 0 0 0 3px rgba(36, 107, 104, 0.12);
            background: #ffffff;
        }

        .form-group select {
            cursor: pointer;
            appearance: auto;
        }

        /* CONSENT */

        .consent-box {
            display: flex;
            align-items: flex-start;
            gap: 11px;
            margin-top: 27px;
            padding: 16px;
            border-radius: 11px;
            background: #f2f8f5;
            border: 1px solid #e0eee7;
            font-size: 12px;
            color: #536b67;
            line-height: 1.8;
        }

        .consent-box input {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
            margin-top: 3px;
            accent-color: var(--teal);
            cursor: pointer;
        }

        .consent-box label {
            cursor: pointer;
        }

        .privacy-note {
            margin-top: 13px;
            color: var(--muted);
            font-size: 11px;
            line-height: 1.8;
        }

        /* FORM BUTTONS */

        .form-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin-top: 28px;
            padding-top: 23px;
            border-top: 1px solid var(--border);
        }

        .back-link {
            color: var(--muted);
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
        }

        .back-link:hover {
            color: var(--teal);
        }

        .submit-button {
            border: none;
            border-radius: 9px;
            background: var(--burgundy);
            color: #ffffff;
            padding: 14px 23px;
            font-family: inherit;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 7px 17px rgba(148, 27, 54, 0.16);
            transition: background 0.2s ease,
            transform 0.2s ease,
            box-shadow 0.2s ease;
        }

        .submit-button:hover {
            background: var(--burgundy-dark);
            transform: translateY(-2px);
            box-shadow: 0 10px 22px rgba(148, 27, 54, 0.22);
        }

        .submit-button:active {
            transform: translateY(0);
        }

        /* SERVER MESSAGES */

        .message {
            margin-bottom: 22px;
            padding: 14px 16px;
            border-radius: 10px;
            font-size: 13px;
            line-height: 1.7;
        }

        .error-message {
            background: #fff0f1;
            color: #a51e32;
            border: 1px solid #f3cbd2;
        }

        .success-message {
            background: #eaf7f0;
            color: #216b4b;
            border: 1px solid #c9e9d7;
        }

        /* UPDATE STATUS NOTE */

        .status-note {
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            background: #f0f7f4;
            border: 1px solid #dcebe4;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.8;
        }

        /* ANIMATION */

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(12px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* RESPONSIVE */

        @media (max-width: 650px) {
            .navbar {
                padding: 15px 5%;
                min-height: 75px;
            }

            .brand {
                gap: 9px;
            }

            .brand-icon {
                width: 40px;
                height: 40px;
                font-size: 24px;
            }

            .brand-name {
                font-size: 18px;
            }

            .brand-subtitle {
                font-size: 9px;
                letter-spacing: 0.8px;
            }

            .nav-right {
                gap: 10px;
            }

            .nav-greeting {
                display: none;
            }

            .page-container {
                margin-top: 27px;
                margin-bottom: 40px;
            }

            .form-card {
                padding: 23px 18px;
                border-radius: 16px;
            }

            .card-heading {
                gap: 12px;
                margin-bottom: 25px;
            }

            .heart-icon {
                width: 46px;
                height: 46px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .form-group.full-width {
                grid-column: auto;
            }

            .form-actions {
                align-items: stretch;
                flex-direction: column-reverse;
            }

            .submit-button {
                width: 100%;
            }

            .back-link {
                text-align: center;
                padding: 8px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation: none !important;
                transition: none !important;
            }
        }
    </style>

</head>

<body>

<header class="navbar">
  <div class="brand">
    <div class="brand-icon">+</div>
    <div>
      <div class="brand-name">LifeLink<span>.</span></div>
      <div class="brand-subtitle">Campus Community</div>
    </div>
  </div>

  <div class="nav-right">
        <span class="nav-greeting">
            Hello, <%= session.getAttribute("userName") == null
                ? "Student"
                : session.getAttribute("userName") %>
        </span>

    <div class="avatar">
      <%= session.getAttribute("userName") == null
              ? "S"
              : session.getAttribute("userName").toString()
              .substring(0, 1).toUpperCase() %>
    </div>

    <a href="<%= request.getContextPath() %>/dashboard.jsp">
      Dashboard &rarr;
    </a>
  </div>
</header>

<main class="page-container">

  <div class="breadcrumb">
    <a href="<%= request.getContextPath() %>/dashboard.jsp">Dashboard</a>
    <span>/</span>
    <strong>Donor Registration</strong>
  </div>

  <p class="eyebrow">EVERY DROP CAN MAKE A DIFFERENCE</p>

  <h1><%= isUpdate ? "Update Donor Profile" : "Become a Blood Donor" %></h1>

  <p class="intro">
    Join the LifeLink Campus donor network and let the right people
    contact you about relevant donation opportunities.
  </p>

  <section class="form-card">

    <div class="card-heading">
      <div class="heart-icon">&#9829;</div>
      <div>
        <h2>Donor Information</h2>
        <p>Fields marked with <span class="required">*</span> are required.</p>
      </div>
    </div>

    <% if (message != null && !message.isEmpty()) { %>
    <div class="message <%= "success".equals(messageType)
                    ? "success-message" : "error-message" %>">
      <%= message %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/donor"
          method="post">

      <div class="section-title">Personal &amp; Contact Details</div>

      <div class="form-grid">

        <div class="form-group">
          <label for="bloodGroup">
            Blood Group <span class="required">*</span>
          </label>

          <select id="bloodGroup" name="bloodGroup" required>
            <option value="">Select your blood group</option>

            <option value="A+" <%= "A+".equals(bloodGroupValue) ? "selected" : "" %>>A+</option>
            <option value="A-" <%= "A-".equals(bloodGroupValue) ? "selected" : "" %>>A-</option>
            <option value="B+" <%= "B+".equals(bloodGroupValue) ? "selected" : "" %>>B+</option>
            <option value="B-" <%= "B-".equals(bloodGroupValue) ? "selected" : "" %>>B-</option>
            <option value="AB+" <%= "AB+".equals(bloodGroupValue) ? "selected" : "" %>>AB+</option>
            <option value="AB-" <%= "AB-".equals(bloodGroupValue) ? "selected" : "" %>>AB-</option>
            <option value="O+" <%= "O+".equals(bloodGroupValue) ? "selected" : "" %>>O+</option>
            <option value="O-" <%= "O-".equals(bloodGroupValue) ? "selected" : "" %>>O-</option>
          </select>
        </div>

        <div class="form-group">
          <label for="phone">
            Contact Number <span class="required">*</span>
          </label>

          <input
                  type="tel"
                  id="phone"
                  name="phone"
                  placeholder="Enter contact number"
                  value="<%= phoneValue %>"
                  minlength="7"
                  maxlength="20"
                  pattern="[0-9+() -]{7,20}"
                  title="Enter a valid contact number"
                  required>
        </div>

        <div class="form-group full-width">
          <label for="college">
            College / Institution <span class="required">*</span>
          </label>

          <input
                  type="text"
                  id="college"
                  name="college"
                  placeholder="Enter your college name"
                  value="<%= collegeValue %>"
                  minlength="2"
                  maxlength="150"
                  required>
        </div>

        <% if (isUpdate) { %>
        <div class="form-group full-width">
          <label for="availabilityStatus">
            Donation Availability <span class="required">*</span>
          </label>

          <select id="availabilityStatus"
                  name="availabilityStatus"
                  required>
            <option value="AVAILABLE"
                    <%= "AVAILABLE".equals(availabilityValue) ? "selected" : "" %>>
              Available
            </option>

            <option value="UNAVAILABLE"
                    <%= "UNAVAILABLE".equals(availabilityValue) ? "selected" : "" %>>
              Currently Unavailable
            </option>
          </select>
        </div>
        <% } %>

      </div>

      <div class="consent-box">
        <input
                type="checkbox"
                id="consentToContact"
                name="consentToContact"
                value="true"
          <%= consentChecked ? "checked" : "" %>
                required>

        <label for="consentToContact">
          I consent to having authorized LifeLink Campus coordinators
          contact me about relevant blood donation opportunities.
          <span class="required">*</span>
        </label>
      </div>

      <p class="privacy-note">
        Your contact information should only be used for the stated
        purpose and accessed by authorized personnel.
      </p>

      <div class="form-actions">
        <a class="back-link"
           href="<%= request.getContextPath() %>/dashboard.jsp">
          &larr; Back to Dashboard
        </a>

        <button class="submit-button" type="submit">
          <%= isUpdate ? "Save Changes" : "Register as Donor" %>
          &rarr;
        </button>
      </div>

    </form>

    <% if (isUpdate) { %>
    <div class="status-note">
      Your donor profile is registered. Updating your details does
      not change your donor approval status.
    </div>
    <% } %>

  </section>

</main>

</body>
</html>
