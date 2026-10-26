<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 21-10-2026
  Time: 02:17
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | LifeLink Campus</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Trebuchet MS", "Segoe UI", Arial, sans-serif;
            background:
                    linear-gradient(
                            110deg,
                            rgba(20, 66, 64, 0.78),
                            rgba(36, 107, 104, 0.62),
                            rgba(20, 66, 64, 0.82)
                    ),
                    url("images/lifelink-background.webp") center / cover no-repeat fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
        }

        .login-card {
            width: 100%;
            max-width: 430px;
            padding: 38px 35px;
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid rgba(255, 255, 255, 0.65);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(10, 43, 41, 0.28);
            backdrop-filter: blur(10px);
            animation: fadeUp 0.6s ease both;
        }

        .brand {
            text-align: center;
            color: #246b68;
            font-size: 27px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .brand::first-letter {
            color: #941b36;
        }

        .subtitle {
            text-align: center;
            color: #657a78;
            margin: 12px 0 28px;
            font-size: 14px;
            line-height: 1.6;
        }

        label {
            display: block;
            margin: 17px 0 8px;
            font-size: 13px;
            font-weight: 700;
            color: #193735;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #cbded9;
            border-radius: 9px;
            background: #fbfefd;
            color: #193735;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus {
            outline: none;
            border-color: #39837b;
            box-shadow: 0 0 0 3px rgba(57, 131, 123, 0.14);
            background: #ffffff;
        }

        input::placeholder {
            color: #9aadaa;
        }

        button {
            width: 100%;
            margin-top: 27px;
            padding: 15px;
            border: none;
            border-radius: 9px;
            background: #941b36;
            color: white;
            font-family: inherit;
            font-size: 15px;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(148, 27, 54, 0.19);
            transition: background 0.2s, transform 0.2s,
            box-shadow 0.2s;
        }

        button:hover {
            background: #77152b;
            transform: translateY(-2px);
            box-shadow: 0 11px 23px rgba(148, 27, 54, 0.25);
        }

        button:active {
            transform: translateY(0);
        }

        .message {
            margin-top: 18px;
            padding: 11px;
            border-radius: 8px;
            background: #fff0f1;
            color: #a51e32;
            text-align: center;
            font-size: 13px;
            line-height: 1.6;
        }

        .success-message {
            background: #e8f7ef;
            color: #246b4a;
        }

        .register-link {
            text-align: center;
            margin-top: 24px;
            color: #657a78;
            font-size: 13px;
        }

        a {
            color: #941b36;
            text-decoration: none;
            font-weight: 800;
            transition: color 0.2s;
        }

        a:hover {
            color: #246b68;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(14px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 18px;
                background-attachment: scroll;
            }

            .login-card {
                padding: 30px 23px;
                border-radius: 16px;
            }

            .brand {
                font-size: 24px;
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
<div class="login-card">

    <div class="brand">&#9829; LifeLink Campus</div>

    <p class="subtitle">Welcome back! Sign in to continue.</p>

    <form action="<%= request.getContextPath() %>/login"
          method="post">

        <label for="email">Email Address</label>
        <input
                type="email"
                id="email"
                name="email"
                required
                maxlength="150"
                autocomplete="email">

        <label for="password">Password</label>
        <input
                type="password"
                id="password"
                name="password"
                required
                autocomplete="current-password">

        <button type="submit">Login</button>
    </form>

    <%
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType");

        if (message != null) {
    %>
    <p class="message <%= "success".equals(messageType)
                ? "success-message" : "" %>">
        <%= message %>
    </p>
    <%
        }
    %>

    <div class="register-link">
        Don't have an account?
        <a href="<%= request.getContextPath() %>/register.jsp">
            Register
        </a>
    </div>

</div>
</body>
</html>

