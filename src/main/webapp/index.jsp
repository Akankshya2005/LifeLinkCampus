
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeLink Campus | Every Life Matters</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --teal: #246b68;
            --teal-dark: #174b49;
            --aqua: #dff3ef;
            --burgundy: #941b36;
            --dark: #193735;
            --muted: #657a78;
            --white: #ffffff;
            --light: #f1f9f7;
        }

        html {
            scroll-behavior: smooth;
            scroll-padding-top: 90px;
        }

        body {
            font-family: "Trebuchet MS", "Segoe UI", Arial, sans-serif;
            color: var(--dark);
            background: var(--white);
            overflow-x: hidden;
        }

        a {
            text-decoration: none;
        }

        .navbar {
            min-height: 82px;
            padding: 16px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            background: rgba(255, 255, 255, 0.96);
            border-bottom: 1px solid #dcece8;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--dark);
        }

        .logo {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--teal);
            color: white;
            font-size: 30px;
            font-weight: bold;
            box-shadow: 0 6px 18px rgba(36, 107, 104, 0.2);
        }

        .brand-name {
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -0.8px;
        }

        .brand-name span,
        .footer-brand span {
            color: var(--burgundy);
        }

        .brand-tagline {
            margin-top: 4px;
            font-size: 10px;
            letter-spacing: 1.7px;
            text-transform: uppercase;
            color: var(--muted);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 28px;
        }

        .nav-links a {
            color: #526966;
            font-size: 13px;
            font-weight: 700;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: var(--burgundy);
        }

        .nav-links .login-link {
            padding: 12px 23px;
            border: 1px solid #b8d7d1;
            border-radius: 9px;
            color: var(--teal);
        }

        .nav-links .login-link:hover {
            background: var(--light);
        }

        /* HERO BACKGROUND */

        .hero {
            min-height: 650px;
            padding: 80px 8%;
            display: flex;
            align-items: center;
            justify-content: flex-end;

            background:
                    linear-gradient(
                            90deg,
                            rgba(20, 66, 64, 0.05) 0%,
                            rgba(20, 66, 64, 0.30) 35%,
                            rgba(20, 66, 64, 0.88) 100%
                    ),
                    url("images/lifelink-background.webp") center / cover no-repeat;
        }

        .hero-content {
            width: 55%;
            max-width: 680px;
            color: white;
            animation: fadeUp 0.8s ease both;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            margin-bottom: 28px;
            border: 1px solid rgba(255, 255, 255, 0.35);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.12);
            color: #e4fffa;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.6px;
        }

        .eyebrow-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #ff9caa;
        }

        h1 {
            max-width: 760px;
            font-size: clamp(39px, 5.2vw, 68px);
            line-height: 1.15;
            letter-spacing: -1.8px;
            font-weight: 800;
            margin-bottom: 25px;
        }

        h1 .highlight {
            color: #ffb8c1;
        }

        .hero-description {
            max-width: 580px;
            margin-bottom: 33px;
            color: #effbf8;
            font-size: 15px;
            line-height: 1.95;
        }

        .hero-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 16px 25px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 800;
            transition: transform 0.2s, background 0.2s;
        }

        .btn:hover {
            transform: translateY(-3px);
        }

        .btn-primary {
            background: var(--burgundy);
            color: white;
            box-shadow: 0 9px 24px rgba(40, 15, 22, 0.2);
        }

        .btn-primary:hover {
            background: #77152b;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.13);
            border: 1px solid rgba(255, 255, 255, 0.55);
            color: white;
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.23);
        }

        .hero-note {
            margin-top: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #e7f5f2;
            font-size: 12px;
        }

        .hero-note .note-heart {
            color: #ffb3bf;
            font-size: 20px;
        }

        /* MISSION STRIP */

        .mission-strip {
            padding: 29px 7%;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 17px;
            text-align: center;
            color: white;
            background: var(--teal);
        }

        .mission-symbol {
            font-size: 29px;
            color: #ffd1d8;
        }

        .mission-text {
            font-size: 15px;
            font-weight: 700;
            line-height: 1.8;
        }

        .mission-text span {
            font-size: 13px;
            font-weight: 400;
            color: #d9efeb;
        }

        /* GENERAL SECTIONS */

        .section {
            padding: 90px 7%;
            text-align: center;
        }

        .section-label {
            margin-bottom: 15px;
            color: var(--burgundy);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
        }

        .section h2 {
            margin-bottom: 18px;
            font-size: clamp(28px, 3.5vw, 41px);
            line-height: 1.25;
            letter-spacing: -1px;
        }

        .section-description {
            max-width: 650px;
            margin: 0 auto;
            color: var(--muted);
            font-size: 14px;
            line-height: 1.9;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 24px;
            max-width: 1100px;
            margin: 48px auto 0;
            text-align: left;
        }

        .feature-card {
            padding: 30px 26px;
            border: 1px solid #dcece8;
            border-radius: 17px;
            background: white;
            transition: transform 0.25s, box-shadow 0.25s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 35px rgba(25, 74, 69, 0.09);
        }

        .feature-icon {
            width: 52px;
            height: 52px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 22px;
            border-radius: 14px;
            background: var(--aqua);
            color: var(--teal);
            font-size: 25px;
            font-weight: 800;
        }

        .feature-card h3 {
            margin-bottom: 13px;
            color: var(--dark);
            font-size: 17px;
        }

        .feature-card p {
            color: var(--muted);
            font-size: 13px;
            line-height: 1.9;
        }

        .how-section {
            background: #f1f8f6;
        }

        /* CALL TO ACTION */

        .cta-section {
            padding: 0 7% 85px;
        }

        .cta-box {
            position: relative;
            max-width: 1100px;
            margin: 0 auto;
            padding: 58px 30px;
            overflow: hidden;
            border-radius: 23px;
            background: linear-gradient(120deg, #1b5552, #39837b);
            color: white;
            text-align: center;
        }

        .cta-box h2 {
            position: relative;
            z-index: 1;
            margin-bottom: 16px;
            font-size: clamp(27px, 3.5vw, 39px);
        }

        .cta-box p {
            position: relative;
            z-index: 1;
            max-width: 620px;
            margin: 0 auto 27px;
            color: #e2f4f0;
            font-size: 14px;
            line-height: 1.9;
        }

        .cta-box .btn {
            position: relative;
            z-index: 1;
            background: white;
            color: var(--teal-dark);
        }

        .cta-box .btn:hover {
            background: #e7f5f1;
        }

        /* FOOTER */

        footer {
            padding: 30px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            border-top: 1px solid #dcece8;
            background: white;
        }

        .footer-brand {
            font-size: 16px;
            font-weight: 800;
        }

        .footer-message,
        .footer-links {
            color: var(--muted);
            font-size: 11px;
            line-height: 1.8;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: var(--muted);
        }

        .footer-links a:hover {
            color: var(--burgundy);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(18px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 850px) {

            .hero {
                min-height: 600px;
                padding: 60px 6%;
                justify-content: center;

                background:
                        linear-gradient(
                                rgba(20, 66, 64, 0.72),
                                rgba(20, 66, 64, 0.82)
                        ),
                        url("images/lifelink-background.webp") center / cover no-repeat;
            }

            .hero-content {
                width: 100%;
            }

            .feature-grid {
                grid-template-columns: 1fr;
                max-width: 550px;
            }
        }

        @media (max-width: 600px) {
            .navbar {
                min-height: 72px;
                padding: 14px 5%;
            }

            .brand-name {
                font-size: 19px;
            }

            .brand-tagline {
                font-size: 8px;
                letter-spacing: 1.2px;
            }

            .logo {
                width: 40px;
                height: 40px;
            }

            .nav-links {
                gap: 10px;
            }

            .nav-links a:not(.login-link) {
                display: none;
            }

            .nav-links .login-link {
                padding: 10px 15px;
            }

            .hero {
                min-height: 600px;
                padding: 65px 6%;
                background-position: 38% center;
                background-image:
                        linear-gradient(
                                90deg,
                                rgba(20, 66, 64, 0.86),
                                rgba(28, 83, 79, 0.66)
                        ),
                        url("images/lifelink-background.webp");
                background-size: cover;
            }

            h1 {
                font-size: clamp(37px, 10vw, 50px);
                letter-spacing: -1px;
            }

            .hero-description {
                font-size: 14px;
            }

            .btn {
                padding: 14px 19px;
            }

            .mission-strip {
                padding: 24px 6%;
                gap: 10px;
            }

            .mission-text {
                font-size: 13px;
            }

            .section {
                padding: 65px 6%;
            }

            .cta-section {
                padding: 0 5% 60px;
            }

            .cta-box {
                padding: 43px 20px;
            }

            footer {
                padding: 27px 6%;
                flex-direction: column;
                text-align: center;
            }

            .footer-links {
                justify-content: center;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation: none !important;
                scroll-behavior: auto !important;
                transition: none !important;
            }
        }
    </style>
</head>

<body>

<header class="navbar">
    <a class="brand" href="<%= contextPath %>/index.jsp">
        <div class="logo">+</div>
        <div>
            <div class="brand-name">LifeLink<span>.</span></div>
            <div class="brand-tagline">Campus Community</div>
        </div>
    </a>


    <nav class="nav-links" aria-label="Main navigation">
        <a href="#home">Home</a>
        <a href="#how-it-works">How It Works</a>
    </nav>

</header>

<main>

    <section class="hero" id="home">
        <div class="hero-content">

            <div class="eyebrow">
                <span class="eyebrow-dot"></span>
                COMPASSION STARTS HERE
            </div>

            <h1>
                One Campus.<br>
                Many Hearts.<br>
                <span class="highlight">One Life-Saving</span><br>
                Mission.
            </h1>

            <p class="hero-description">
                A single act of kindness can become someone's second chance.
                Join a community where students come together to support blood
                donation, respond to urgent needs, and turn compassion into
                meaningful action.
            </p>

            <div class="hero-buttons">
                <a class="btn btn-primary"
                   href="<%= contextPath %>/register.jsp">
                    Get Started <span>&rarr;</span>
                </a>

                <a class="btn btn-secondary" href="<%= contextPath %>/login.jsp">
                    Login to Your Account <span>&rarr;</span>
                </a>
            </div>

            <div class="hero-note">
                <span class="note-heart">&#9829;</span>
                <span><strong>Give hope.</strong> Share kindness. Make a difference.</span>
            </div>

        </div>
    </section>

    <section class="mission-strip">
        <div class="mission-symbol">&#9829;</div>
        <div class="mission-text">
            Your kindness could be someone's tomorrow.
            <br>
            <span>Let's make every connection count.</span>
        </div>
    </section>

    <section class="section" id="about">
        <p class="section-label">WHY LIFELINK CAMPUS?</p>
        <h2>Because every life matters.</h2>

        <p class="section-description">
            We believe a caring campus can do more than educate.
            It can connect people who want to help with opportunities to make
            a real difference, responsibly and together.
        </p>

        <div class="feature-grid">

            <article class="feature-card">
                <div class="feature-icon">&#9829;</div>
                <h3>Be a Helping Hand</h3>
                <p>
                    Register as a potential donor and share your availability
                    so authorized coordinators can contact you when relevant
                    opportunities arise.
                </p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">&#10010;</div>
                <h3>Connect When It Matters</h3>
                <p>
                    Support campus blood donation coordination by helping
                    connect requests with willing donors and responsible
                    coordinators.
                </p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">&#9827;</div>
                <h3>Build a Caring Community</h3>
                <p>
                    Discover donation camps, participate in campus initiatives,
                    and encourage a culture of kindness and awareness.
                </p>
            </article>

        </div>
    </section>

    <section class="section how-section" id="how-it-works">
        <p class="section-label">A SIMPLE WAY TO START</p>
        <h2>Small steps. Meaningful impact.</h2>

        <p class="section-description">
            Create your account, complete your profile, and choose how
            you want to contribute to your campus community.
            Authorized coordinators can help manage requests and activities.
        </p>

        <div class="feature-grid">

            <article class="feature-card">
                <div class="feature-icon">01</div>
                <h3>Create Your Account</h3>
                <p>
                    Register with your basic details and securely sign in
                    to access the LifeLink Campus platform.
                </p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">02</div>
                <h3>Complete Your Profile</h3>
                <p>
                    Add relevant information and, if you wish to donate,
                    register your donor details and contact preferences.
                </p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">03</div>
                <h3>Be Part of the Mission</h3>
                <p>
                    Explore available campus activities and respond to
                    appropriate opportunities through authorized channels.
                </p>
            </article>

        </div>
    </section>

    <section class="cta-section">
        <div class="cta-box">
            <h2>Someone's hope could start with you.</h2>

            <p>
                You don't have to change the whole world in one day.
                Sometimes, changing one person's world is enough.
                Join LifeLink Campus and be part of something meaningful.
            </p>

            <a class="btn" href="<%= contextPath %>/register.jsp">
                Join the LifeLink Community &rarr;
            </a>
        </div>
    </section>

</main>

<footer>
    <div class="footer-brand">LifeLink<span>.</span> Campus</div>

    <div class="footer-message">
        Built on compassion. United by the will to help.
    </div>

    <div class="footer-links">
        <a href="#home">Back to top &uarr;</a>
        <a href="<%= contextPath %>/login.jsp">Login</a>
    </div>
</footer>

</body>
</html>