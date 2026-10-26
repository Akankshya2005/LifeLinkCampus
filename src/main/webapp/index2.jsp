
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            --red: #bd263e;
            --red-dark: #941b30;
            --dark: #202535;
            --muted: #70788b;
            --light: #fff6f7;
            --white: #ffffff;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: var(--white);
            color: var(--dark);
            overflow-x: hidden;
        }

        a {
            text-decoration: none;
        }

        .navbar {
            width: 100%;
            min-height: 88px;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.96);
            border-bottom: 1px solid #f0e8eb;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo {
            height: 47px;
            width: 47px;
            border-radius: 15px;
            background: var(--red);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            font-weight: 800;
            box-shadow: 0 7px 18px rgba(189, 38, 62, 0.2);
        }

        .brand-name {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .brand-name span {
            color: var(--red);
        }

        .brand-tagline {
            color: var(--muted);
            font-size: 10px;
            letter-spacing: 1.6px;
            margin-top: 4px;
            text-transform: uppercase;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            font-size: 13px;
            font-weight: 600;
            color: #535c70;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: var(--red);
        }

        .nav-links .login-link {
            border: 1px solid #e4cbd0;
            padding: 12px 22px;
            border-radius: 9px;
            color: var(--red);
        }

        .nav-links .login-link:hover {
            background: var(--light);
        }

        .hero {
            min-height: 610px;
            padding: 75px 7% 85px;
            display: grid;
            grid-template-columns: 1.05fr 0.95fr;
            align-items: center;
            gap: 55px;
            background:
                    radial-gradient(ellipse at 85% 35%, #fff0f2 0%, transparent 43%),
                    linear-gradient(135deg, #ffffff 40%, #fffafb 100%);
        }

        .hero-content {
            max-width: 610px;
            animation: fadeUp 0.8s ease both;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 10px 15px;
            border-radius: 30px;
            background: #fff0f2;
            color: var(--red);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.3px;
            margin-bottom: 27px;
        }

        .eyebrow-dot {
            height: 7px;
            width: 7px;
            background: var(--red);
            border-radius: 50%;
        }

        h1 {
            font-size: clamp(42px, 5vw, 65px);
            line-height: 1.12;
            letter-spacing: -2.7px;
            font-weight: 800;
            margin-bottom: 24px;
        }

        h1 .highlight {
            color: var(--red);
            position: relative;
        }

        .hero-description {
            max-width: 510px;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.95;
            margin-bottom: 32px;
        }

        .hero-buttons {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 14px;
        }

        .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            padding: 16px 24px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            transition: transform 0.2s, box-shadow 0.2s,
            background 0.2s;
        }

        .btn:hover {
            transform: translateY(-3px);
        }

        .btn-primary {
            background: var(--red);
            color: white;
            box-shadow: 0 10px 22px rgba(189, 38, 62, 0.2);
        }

        .btn-primary:hover {
            background: var(--red-dark);
            box-shadow: 0 13px 25px rgba(189, 38, 62, 0.26);
        }

        .btn-secondary {
            border: 1px solid #e3e5eb;
            background: white;
            color: var(--dark);
        }

        .btn-secondary:hover {
            border-color: #e0a9b3;
        }

        .hero-note {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #7c8496;
            font-size: 11px;
            margin-top: 27px;
        }

        .hero-note strong {
            color: #525b6e;
        }

        .hero-art {
            min-height: 420px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: fadeUp 1s ease both;
        }

        .art-circle {
            width: min(390px, 100%);
            aspect-ratio: 1;
            border-radius: 50%;
            background: linear-gradient(145deg, #fff0f2, #f8d9df);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .art-circle::before {
            content: "";
            position: absolute;
            inset: 23px;
            border: 1px dashed rgba(189, 38, 62, 0.23);
            border-radius: 50%;
        }

        .heart {
            width: 180px;
            height: 180px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 135px;
            color: var(--red);
            line-height: 1;
            filter: drop-shadow(0 15px 15px rgba(189, 38, 62, 0.16));
            animation: heartbeat 2s ease-in-out infinite;
        }

        .floating-card {
            position: absolute;
            display: flex;
            align-items: center;
            gap: 12px;
            background: white;
            padding: 15px 18px;
            border-radius: 14px;
            box-shadow: 0 12px 35px rgba(44, 35, 55, 0.09);
            border: 1px solid #f5e9ec;
        }

        .card-one {
            top: 42px;
            right: -4px;
        }

        .card-two {
            bottom: 43px;
            left: -10px;
        }

        .floating-icon {
            width: 43px;
            height: 43px;
            border-radius: 12px;
            background: #fff0f2;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--red);
            font-size: 23px;
        }

        .floating-title {
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 5px;
        }

        .floating-subtitle {
            font-size: 10px;
            color: var(--muted);
        }

        .mission-strip {
            padding: 28px 7%;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 17px;
            background: var(--red);
            color: white;
            text-align: center;
        }

        .mission-symbol {
            font-size: 27px;
        }

        .mission-text {
            font-size: 15px;
            font-weight: 600;
            line-height: 1.7;
        }

        .mission-text span {
            font-weight: 400;
            opacity: 0.85;
        }

        .section {
            padding: 95px 7%;
            text-align: center;
        }

        .section-label {
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            color: var(--red);
            margin-bottom: 16px;
        }

        .section h2 {
            font-size: clamp(28px, 3.4vw, 39px);
            letter-spacing: -1.2px;
            margin-bottom: 17px;
        }

        .section-description {
            max-width: 620px;
            margin: 0 auto;
            font-size: 14px;
            line-height: 1.9;
            color: var(--muted);
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 23px;
            max-width: 1100px;
            margin: 48px auto 0;
            text-align: left;
        }

        .feature-card {
            border: 1px solid #eee9ed;
            padding: 29px 25px;
            border-radius: 17px;
            background: white;
            transition: transform 0.25s, box-shadow 0.25s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(40, 30, 45, 0.06);
        }

        .feature-icon {
            width: 51px;
            height: 51px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff0f2;
            color: var(--red);
            font-size: 25px;
            border-radius: 14px;
            margin-bottom: 22px;
        }

        .feature-card h3 {
            font-size: 17px;
            margin-bottom: 12px;
        }

        .feature-card p {
            color: var(--muted);
            font-size: 13px;
            line-height: 1.85;
        }

        .cta-section {
            padding: 0 7% 85px;
        }

        .cta-box {
            max-width: 1100px;
            margin: 0 auto;
            border-radius: 23px;
            background: linear-gradient(120deg, #a91e35, #d13b52);
            color: white;
            padding: 53px 35px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-box::before,
        .cta-box::after {
            content: "♥";
            position: absolute;
            font-size: 140px;
            color: rgba(255, 255, 255, 0.07);
        }

        .cta-box::before {
            left: 5%;
            top: -40px;
        }

        .cta-box::after {
            right: 5%;
            bottom: -65px;
        }

        .cta-box h2 {
            font-size: clamp(27px, 3.5vw, 38px);
            margin-bottom: 14px;
            position: relative;
            z-index: 1;
        }

        .cta-box p {
            max-width: 600px;
            margin: 0 auto 25px;
            font-size: 14px;
            line-height: 1.8;
            color: #ffe8ec;
            position: relative;
            z-index: 1;
        }

        .cta-box .btn {
            background: white;
            color: var(--red);
            position: relative;
            z-index: 1;
        }

        footer {
            padding: 30px 7%;
            border-top: 1px solid #eee9ed;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .footer-brand {
            font-size: 15px;
            font-weight: 800;
        }

        .footer-brand span {
            color: var(--red);
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
            color: var(--red);
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

        @keyframes heartbeat {
            0%, 100% {
                transform: scale(1);
            }
            15% {
                transform: scale(1.06);
            }
            30% {
                transform: scale(1);
            }
            45% {
                transform: scale(1.04);
            }
        }

        @media (max-width: 850px) {
            .hero {
                grid-template-columns: 1fr;
                gap: 30px;
                padding-top: 65px;
            }

            .hero-content {
                max-width: 700px;
            }

            .hero-art {
                min-height: 380px;
            }

            .art-circle {
                width: 320px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
                max-width: 550px;
            }
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 15px 5%;
                min-height: 75px;
            }

            .brand-name {
                font-size: 18px;
            }

            .logo {
                width: 40px;
                height: 40px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                display: none;
            }

            .nav-links .login-link {
                display: inline-flex;
                padding: 10px 15px;
            }

            .hero {
                padding: 55px 6% 45px;
            }

            h1 {
                letter-spacing: -1.7px;
            }

            .hero-description {
                font-size: 14px;
            }

            .hero-art {
                min-height: 310px;
            }

            .art-circle {
                width: 265px;
            }

            .heart {
                font-size: 100px;
            }

            .floating-card {
                padding: 10px;
                gap: 8px;
            }

            .card-one {
                right: -3px;
                top: 15px;
            }

            .card-two {
                left: -3px;
                bottom: 10px;
            }

            .floating-icon {
                width: 34px;
                height: 34px;
                font-size: 18px;
            }

            .floating-title {
                font-size: 10px;
            }

            .floating-subtitle {
                font-size: 9px;
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
                padding: 42px 20px;
            }

            footer {
                padding: 25px 6%;
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

<%
    String contextPath = request.getContextPath();
%>

<header class="navbar">
    <a class="brand" href="<%= contextPath %>/index2.jsp">
        <div class="logo">+</div>
        <div>
            <div class="brand-name">LifeLink<span>.</span></div>
            <div class="brand-tagline">Campus Community</div>
        </div>
    </a>

    <nav class="nav-links" aria-label="Main navigation">
        <a href="#home">Home</a>
        <a href="#about">Our Mission</a>
        <a href="#how-it-works">How It Works</a>
        <a class="login-link" href="<%= contextPath %>/login.jsp">
            Login &nbsp; &rarr;
        </a>
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

                <a class="btn btn-secondary" href="#about">
                    Discover Our Mission <span>&#8595;</span>
                </a>
            </div>

            <div class="hero-note">
                <span style="color: #bd263e; font-size: 17px;">&#9829;</span>
                <span><strong>Give hope.</strong> Share kindness. Make a difference.</span>
            </div>

        </div>

        <div class="hero-art" aria-label="Heart symbol representing lifesaving care">

            <div class="art-circle">
                <div class="heart">&#9829;</div>
            </div>

            <div class="floating-card card-one">
                <div class="floating-icon">&#10010;</div>
                <div>
                    <div class="floating-title">A Little Act</div>
                    <div class="floating-subtitle">Can mean everything</div>
                </div>
            </div>

            <div class="floating-card card-two">
                <div class="floating-icon">&#9829;</div>
                <div>
                    <div class="floating-title">Together We Care</div>
                    <div class="floating-subtitle">One community, one purpose</div>
                </div>
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

    <section class="section" id="how-it-works"
             style="background: #fffafb;">

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
                Join the LifeLink Community &nbsp; &rarr;
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

