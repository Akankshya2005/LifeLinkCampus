<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 21-10-2026
  Time: 02:25
  To change this template use File | Settings | File Templates.
--%>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  // Protect the dashboard from users who are not logged in
  if (session.getAttribute("userId") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }

  String userName = (String) session.getAttribute("userName");
  String userRole = (String) session.getAttribute("userRole");

  if (userName == null || userName.trim().isEmpty()) {
    userName = "Student";
  }

  if (userRole == null || userRole.trim().isEmpty()) {
    userRole = "STUDENT";
  }

  String firstLetter = userName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>LifeLink Campus | Dashboard</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

  <style>
    :root {
      --primary: #c6283d;
      --primary-dark: #a91e32;
      --primary-light: #fff0f2;
      --text: #202635;
      --muted: #7c8495;
      --border: #edf0f4;
      --background: #f7f8fc;
      --white: #ffffff;
      --green: #168568;
      --green-light: #e8f7f1;
      --blue: #356bd6;
      --blue-light: #edf3ff;
      --orange: #b96c1d;
      --orange-light: #fff3e5;
      --shadow: 0 8px 30px rgba(31, 42, 68, 0.045);
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'DM Sans', sans-serif;
      background: var(--background);
      color: var(--text);
    }

    a {
      text-decoration: none;
      color: inherit;
    }

    button {
      font-family: inherit;
    }

    .app-layout {
      display: flex;
      min-height: 100vh;
    }

    /* SIDEBAR */

    .sidebar {
      width: 248px;
      background: var(--white);
      border-right: 1px solid var(--border);
      padding: 28px 18px;
      display: flex;
      flex-direction: column;
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      z-index: 10;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 11px;
      padding: 0 10px;
      margin-bottom: 43px;
    }

    .brand-icon {
      width: 43px;
      height: 43px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--primary);
      color: white;
      font-size: 25px;
      font-weight: 700;
      box-shadow: 0 6px 15px rgba(198, 40, 61, 0.2);
    }

    .brand-name {
      font-family: 'Manrope', sans-serif;
      font-size: 19px;
      font-weight: 800;
      letter-spacing: -0.7px;
    }

    .brand-name span {
      color: var(--primary);
    }

    .brand-subtitle {
      color: var(--muted);
      font-size: 10px;
      margin-top: 3px;
      letter-spacing: 1.4px;
      text-transform: uppercase;
    }

    .menu-label {
      color: #a0a6b4;
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 1.5px;
      padding: 0 13px;
      margin-bottom: 13px;
    }

    .nav-menu {
      display: flex;
      flex-direction: column;
      gap: 7px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      gap: 13px;
      padding: 13px 14px;
      border-radius: 11px;
      color: #737c8f;
      font-size: 13px;
      font-weight: 600;
      transition: background 0.2s, color 0.2s;
    }

    .nav-link:hover {
      background: #faf0f2;
      color: var(--primary);
    }

    .nav-link.active {
      background: var(--primary-light);
      color: var(--primary);
    }

    .nav-icon {
      width: 22px;
      text-align: center;
      font-size: 18px;
    }

    .sidebar-bottom {
      margin-top: auto;
    }

    .support-card {
      background: #fff6f6;
      border: 1px solid #ffe6e9;
      border-radius: 14px;
      padding: 16px;
      margin-bottom: 19px;
    }

    .support-icon {
      font-size: 23px;
      margin-bottom: 10px;
    }

    .support-card h4 {
      font-size: 12px;
      margin-bottom: 6px;
    }

    .support-card p {
      color: var(--muted);
      font-size: 11px;
      line-height: 1.6;
      margin-bottom: 12px;
    }

    .support-link {
      color: var(--primary);
      font-size: 11px;
      font-weight: 700;
    }

    .sidebar-profile {
      border-top: 1px solid var(--border);
      padding: 19px 5px 0;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .avatar {
      width: 39px;
      height: 39px;
      border-radius: 50%;
      background: #ffe4e8;
      color: var(--primary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 15px;
      font-weight: 800;
      flex-shrink: 0;
    }

    .profile-info {
      min-width: 0;
      flex: 1;
    }

    .profile-info strong {
      display: block;
      font-size: 12px;
      overflow-wrap: anywhere;
    }

    .profile-info span {
      display: block;
      color: var(--muted);
      font-size: 10px;
      margin-top: 4px;
    }

    /* MAIN CONTENT */

    .main-content {
      margin-left: 248px;
      width: calc(100% - 248px);
      min-width: 0;
    }

    .topbar {
      height: 79px;
      padding: 0 38px;
      background: rgba(255, 255, 255, 0.94);
      border-bottom: 1px solid var(--border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 20px;
      position: sticky;
      top: 0;
      z-index: 5;
    }

    .breadcrumb {
      font-size: 12px;
      color: var(--muted);
    }

    .breadcrumb strong {
      color: var(--text);
    }

    .topbar-right {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .topbar-greeting {
      font-size: 12px;
      color: var(--muted);
    }

    .topbar-greeting strong {
      color: var(--text);
    }

    .topbar-avatar {
      width: 38px;
      height: 38px;
      border-radius: 50%;
      background: var(--primary);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 14px;
      font-weight: 700;
    }

    .page-content {
      max-width: 1500px;
      padding: 32px 38px 45px;
      margin: 0 auto;
    }

    .page-heading {
      margin-bottom: 27px;
    }

    .eyebrow {
      color: var(--primary);
      text-transform: uppercase;
      letter-spacing: 2px;
      font-size: 10px;
      font-weight: 800;
      margin-bottom: 10px;
    }

    .page-heading h1 {
      font-family: 'Manrope', sans-serif;
      font-size: clamp(24px, 3vw, 31px);
      letter-spacing: -1.1px;
      margin-bottom: 8px;
    }

    .page-heading h1 span {
      color: var(--primary);
    }

    .page-heading p:last-child {
      color: var(--muted);
      font-size: 13px;
      line-height: 1.7;
    }

    /* HERO */

    .hero {
      background: linear-gradient(115deg, #a91e32 0%, #cf3448 62%, #e65d6a 100%);
      border-radius: 20px;
      padding: 31px 34px;
      color: white;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      position: relative;
      overflow: hidden;
      margin-bottom: 27px;
      box-shadow: 0 13px 28px rgba(198, 40, 61, 0.13);
    }

    .hero::after {
      content: "";
      position: absolute;
      width: 250px;
      height: 250px;
      border: 38px solid rgba(255, 255, 255, 0.08);
      border-radius: 50%;
      right: 100px;
      top: -145px;
      pointer-events: none;
    }

    .hero-copy {
      max-width: 570px;
      position: relative;
      z-index: 1;
    }

    .hero-tag {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      background: rgba(255, 255, 255, 0.15);
      border: 1px solid rgba(255, 255, 255, 0.17);
      border-radius: 30px;
      padding: 7px 12px;
      font-size: 10px;
      font-weight: 700;
      margin-bottom: 16px;
    }

    .hero h2 {
      font-family: 'Manrope', sans-serif;
      font-size: clamp(22px, 3vw, 30px);
      letter-spacing: -0.8px;
      margin-bottom: 11px;
    }

    .hero p {
      color: rgba(255, 255, 255, 0.86);
      font-size: 12px;
      line-height: 1.8;
      max-width: 470px;
    }

    .hero-actions {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 22px;
    }

    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 12px 17px;
      border-radius: 9px;
      font-size: 11px;
      font-weight: 700;
      cursor: pointer;
      border: 1px solid transparent;
      transition: transform 0.2s, background 0.2s;
    }

    .btn:hover {
      transform: translateY(-2px);
    }

    .btn-white {
      background: white;
      color: var(--primary);
    }

    .btn-glass {
      background: rgba(255, 255, 255, 0.12);
      border-color: rgba(255, 255, 255, 0.35);
      color: white;
    }

    .hero-symbol {
      position: relative;
      z-index: 1;
      width: 145px;
      height: 145px;
      min-width: 145px;
      border: 1px solid rgba(255, 255, 255, 0.25);
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.10);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 73px;
    }

    /* SECTION HEADINGS */

    .section-heading {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 15px;
      margin: 30px 0 16px;
    }

    .section-heading h2 {
      font-family: 'Manrope', sans-serif;
      font-size: 17px;
      letter-spacing: -0.4px;
    }

    .section-heading p {
      color: var(--muted);
      font-size: 11px;
      margin-top: 5px;
    }

    .text-link {
      color: var(--primary);
      font-size: 11px;
      font-weight: 700;
      white-space: nowrap;
    }

    /* OVERVIEW CARDS */

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 17px;
    }

    .stat-card {
      background: white;
      border: 1px solid var(--border);
      border-radius: 15px;
      padding: 21px;
      box-shadow: var(--shadow);
    }

    .stat-top {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      margin-bottom: 19px;
    }

    .stat-icon {
      width: 43px;
      height: 43px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 12px;
      font-size: 21px;
    }

    .icon-red {
      background: var(--primary-light);
    }

    .icon-green {
      background: var(--green-light);
    }

    .icon-blue {
      background: var(--blue-light);
    }

    .stat-label {
      font-size: 11px;
      color: var(--muted);
      font-weight: 600;
    }

    .stat-number {
      font-family: 'Manrope', sans-serif;
      font-size: 25px;
      font-weight: 800;
      letter-spacing: -1px;
    }

    .stat-description {
      color: var(--muted);
      font-size: 10px;
      margin-top: 7px;
      line-height: 1.6;
    }

    /* QUICK ACTIONS */

    .actions-grid {
      display: grid;
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 17px;
    }

    .action-card {
      background: white;
      border: 1px solid var(--border);
      border-radius: 15px;
      padding: 22px;
      display: flex;
      flex-direction: column;
      min-height: 210px;
      box-shadow: var(--shadow);
      transition: transform 0.2s, border-color 0.2s;
    }

    .action-card:hover {
      transform: translateY(-3px);
      border-color: #f0b9c1;
    }

    .action-icon {
      width: 46px;
      height: 46px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 13px;
      font-size: 23px;
      margin-bottom: 18px;
    }

    .action-card h3 {
      font-size: 14px;
      margin-bottom: 9px;
    }

    .action-card p {
      font-size: 11px;
      color: var(--muted);
      line-height: 1.8;
      margin-bottom: 19px;
      flex: 1;
    }

    .action-link {
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: var(--primary);
      font-size: 11px;
      font-weight: 700;
    }

    /* LOWER PANELS */

    .lower-grid {
      display: grid;
      grid-template-columns: 1.15fr 0.85fr;
      gap: 18px;
      margin-top: 28px;
    }

    .panel {
      background: white;
      border: 1px solid var(--border);
      border-radius: 15px;
      padding: 23px;
      box-shadow: var(--shadow);
    }

    .panel h3 {
      font-family: 'Manrope', sans-serif;
      font-size: 15px;
      margin-bottom: 7px;
    }

    .panel-subtitle {
      color: var(--muted);
      font-size: 11px;
      line-height: 1.7;
      margin-bottom: 20px;
    }

    .info-row {
      display: flex;
      align-items: flex-start;
      gap: 13px;
      padding: 15px 0;
      border-top: 1px solid var(--border);
    }

    .info-icon {
      width: 39px;
      height: 39px;
      border-radius: 11px;
      background: var(--primary-light);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 19px;
      flex-shrink: 0;
    }

    .info-content {
      flex: 1;
    }

    .info-content h4 {
      font-size: 12px;
      margin: 2px 0 6px;
    }

    .info-content p {
      color: var(--muted);
      font-size: 10px;
      line-height: 1.7;
    }

    .status-pill {
      display: inline-block;
      color: var(--orange);
      background: var(--orange-light);
      border-radius: 20px;
      padding: 5px 8px;
      font-size: 9px;
      font-weight: 700;
      white-space: nowrap;
    }

    .tips-list {
      list-style: none;
    }

    .tips-list li {
      display: flex;
      align-items: flex-start;
      gap: 11px;
      padding: 12px 0;
      border-bottom: 1px solid var(--border);
      font-size: 11px;
      line-height: 1.8;
      color: #5f687a;
    }

    .tips-list li:last-child {
      border-bottom: none;
    }

    .tip-check {
      width: 23px;
      height: 23px;
      border-radius: 50%;
      background: var(--green-light);
      color: var(--green);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 11px;
      flex-shrink: 0;
    }

    .footer {
      text-align: center;
      color: #9aa1af;
      font-size: 10px;
      padding: 30px 10px 5px;
      line-height: 1.8;
    }

    /* RESPONSIVE */

    @media (max-width: 1100px) {
      .sidebar {
        width: 215px;
      }

      .main-content {
        margin-left: 215px;
        width: calc(100% - 215px);
      }

      .page-content {
        padding: 28px 24px 35px;
      }

      .topbar {
        padding: 0 24px;
      }

      .hero-symbol {
        width: 110px;
        height: 110px;
        min-width: 110px;
        font-size: 57px;
      }

      .stats-grid,
      .actions-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
      }
    }

    @media (max-width: 760px) {
      .sidebar {
        width: 68px;
        padding: 22px 8px;
        align-items: center;
      }

      .brand {
        padding: 0;
        margin-bottom: 35px;
      }

      .brand-icon {
        width: 42px;
        height: 42px;
      }

      .brand-text,
      .menu-label,
      .nav-text,
      .support-card,
      .profile-info,
      .sidebar-profile .avatar {
        display: none;
      }

      .nav-menu {
        width: 100%;
        align-items: center;
      }

      .nav-link {
        justify-content: center;
        padding: 13px 0;
        width: 49px;
        height: 47px;
      }

      .nav-icon {
        font-size: 20px;
      }

      .sidebar-profile {
        justify-content: center;
        padding: 15px 0 0;
        width: 100%;
      }

      .sidebar-profile::after {
        content: "↗";
        color: var(--primary);
        font-size: 18px;
      }

      .main-content {
        margin-left: 68px;
        width: calc(100% - 68px);
      }

      .topbar {
        height: 65px;
        padding: 0 17px;
      }

      .topbar-greeting {
        display: none;
      }

      .page-content {
        padding: 24px 16px 30px;
      }

      .hero {
        padding: 25px 22px;
      }

      .hero-symbol {
        display: none;
      }

      .stats-grid,
      .actions-grid,
      .lower-grid {
        grid-template-columns: 1fr;
      }

      .section-heading h2 {
        font-size: 15px;
      }
    }

    @media (max-width: 400px) {
      .hero-actions {
        flex-direction: column;
        align-items: stretch;
      }

      .hero-actions .btn {
        width: 100%;
      }

      .topbar {
        padding: 0 12px;
      }

      .page-heading h1 {
        font-size: 24px;
      }
    }

    /* =========================================
       LIFELINK CAMPUS — MATCHED BRAND THEME
       Add this at the END of the existing CSS
    ========================================= */

    :root {
      --primary: #246b68;
      --primary-dark: #194e4b;
      --primary-light: #e7f3f0;

      --text: #193735;
      --muted: #657a78;
      --border: #dce9e5;
      --background: #f4f8f6;
      --white: #ffffff;

      --green: #287d68;
      --green-light: #e6f4ef;

      --blue: #397c83;
      --blue-light: #e8f3f4;

      --orange: #a66a32;
      --orange-light: #fff2e5;

      --shadow: 0 8px 28px rgba(25, 78, 75, 0.07);
    }

    /* Overall page */

    body {
      font-family: "Trebuchet MS", "Segoe UI", Arial, sans-serif;
      background: var(--background);
      color: var(--text);
    }

    button,
    input,
    select,
    textarea {
      font-family: inherit;
    }

    .brand-name,
    .page-heading h1,
    .hero h2,
    .section-heading h2,
    .stat-number,
    .panel h3 {
      font-family: "Trebuchet MS", "Segoe UI", Arial, sans-serif;
    }

    /* Sidebar */

    .sidebar {
      background: #ffffff;
      border-right-color: #dce9e5;
    }

    .brand-icon {
      background: #246b68;
      box-shadow: 0 6px 15px rgba(36, 107, 104, 0.22);
      border-radius: 12px;
    }

    .brand-name span {
      color: #941b36;
    }

    .brand-subtitle {
      color: #657a78;
    }

    .menu-label {
      color: #879c98;
    }

    .nav-link {
      color: #657a78;
      border-radius: 10px;
    }

    .nav-link:hover {
      background: #eaf4f1;
      color: #246b68;
    }

    .nav-link.active {
      background: #e4f1ed;
      color: #246b68;
      font-weight: 700;
    }

    .nav-link.active .nav-icon {
      color: #941b36;
    }

    /* Sidebar support card */

    .support-card {
      background: #f0f7f4;
      border: 1px solid #d8e9e2;
    }

    .support-icon {
      color: #941b36;
    }

    .support-card h4 {
      color: #193735;
    }

    .support-link {
      color: #941b36;
    }

    .support-link:hover {
      color: #246b68;
    }

    /* User profile in sidebar */

    .sidebar-profile {
      border-top-color: #dce9e5;
    }

    .avatar {
      background: #e7f3f0;
      color: #246b68;
    }

    .profile-info strong {
      color: #193735;
    }

    .profile-info span {
      color: #657a78;
    }

    /* Top navigation */

    .topbar {
      background: rgba(255, 255, 255, 0.96);
      border-bottom-color: #dce9e5;
      backdrop-filter: blur(12px);
    }

    .breadcrumb {
      color: #657a78;
    }

    .breadcrumb strong {
      color: #246b68;
    }

    .topbar-greeting {
      color: #657a78;
    }

    .topbar-greeting strong {
      color: #193735;
    }

    .topbar-avatar {
      background: #246b68;
    }

    .text-link {
      color: #941b36;
    }

    .text-link:hover {
      color: #246b68;
    }

    /* Page heading */

    .eyebrow {
      color: #941b36;
      letter-spacing: 1.8px;
    }

    .page-heading h1 {
      color: #193735;
    }

    .page-heading h1 span {
      color: #246b68;
    }

    .page-heading p:last-child {
      color: #657a78;
    }

    /* Main hero banner */

    .hero {
      background: linear-gradient(
              115deg,
              #194e4b 0%,
              #246b68 60%,
              #39837b 100%
      );
      border: 1px solid rgba(255, 255, 255, 0.16);
      box-shadow: 0 14px 30px rgba(25, 78, 75, 0.16);
    }

    .hero::after {
      border-color: rgba(255, 255, 255, 0.09);
    }

    .hero-tag {
      background: rgba(255, 255, 255, 0.12);
      border-color: rgba(255, 255, 255, 0.24);
    }

    .hero h2 {
      color: #ffffff;
    }

    .hero p {
      color: rgba(255, 255, 255, 0.88);
    }

    .btn {
      border-radius: 9px;
    }

    .btn-white {
      background: #ffffff;
      color: #246b68;
    }

    .btn-white:hover {
      background: #eaf4f1;
      color: #194e4b;
    }

    .btn-glass {
      background: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.38);
      color: #ffffff;
    }

    .btn-glass:hover {
      background: rgba(255, 255, 255, 0.20);
    }

    .hero-symbol {
      background: rgba(255, 255, 255, 0.09);
      border-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
    }

    /* Section headings */

    .section-heading h2 {
      color: #193735;
    }

    .section-heading p {
      color: #657a78;
    }

    .section-heading .text-link {
      color: #941b36;
    }

    /* Overview cards */

    .stat-card,
    .action-card,
    .panel {
      background: #ffffff;
      border: 1px solid #dce9e5;
      box-shadow: var(--shadow);
      border-radius: 15px;
    }

    .stat-card:hover {
      border-color: #b9d8cf;
    }

    .icon-red {
      background: #f8e9ed;
      color: #941b36;
    }

    .icon-green {
      background: #e6f4ef;
      color: #287d68;
    }

    .icon-blue {
      background: #e8f3f4;
      color: #397c83;
    }

    .stat-label {
      color: #657a78;
    }

    .stat-number {
      color: #246b68;
    }

    .stat-description {
      color: #657a78;
    }

    /* Quick action cards */

    .action-card {
      transition: transform 0.2s ease, border-color 0.2s ease,
      box-shadow 0.2s ease;
    }

    .action-card:hover {
      transform: translateY(-3px);
      border-color: #a8cec3;
      box-shadow: 0 12px 28px rgba(25, 78, 75, 0.10);
    }

    .action-card h3 {
      color: #193735;
    }

    .action-card p {
      color: #657a78;
    }

    .action-link {
      color: #941b36;
    }

    .action-card:hover .action-link {
      color: #246b68;
    }

    /* Information panels */

    .panel h3 {
      color: #193735;
    }

    .panel-subtitle {
      color: #657a78;
    }

    .info-row {
      border-top-color: #e5eeea;
    }

    .info-icon {
      background: #e7f3f0;
      color: #246b68;
    }

    .info-content h4 {
      color: #193735;
    }

    .info-content p {
      color: #657a78;
    }

    .status-pill {
      color: #98602b;
      background: #fff2e5;
    }

    /* Tips */

    .tips-list li {
      color: #536b67;
      border-bottom-color: #e5eeea;
    }

    .tip-check {
      background: #e6f4ef;
      color: #287d68;
    }

    /* Footer */

    .footer {
      color: #81938f;
    }

    /* Mobile sidebar */

    @media (max-width: 760px) {
      .nav-link.active {
        background: #e4f1ed;
        color: #246b68;
      }

      .sidebar-profile::after {
        color: #941b36;
      }
    }

    /* Accessibility */

    @media (prefers-reduced-motion: reduce) {
      *,
      *::before,
      *::after {
        animation: none !important;
        transition: none !important;
        scroll-behavior: auto !important;
      }
    }

  </style>
</head>

<body>

<div class="app-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">

    <a href="<%= request.getContextPath() %>/dashboard.jsp" class="brand">
      <div class="brand-icon">+</div>

      <div class="brand-text">
        <div class="brand-name">LifeLink<span>.</span></div>
        <div class="brand-subtitle">Campus Community</div>
      </div>
    </a>

    <div class="menu-label">MAIN MENU</div>

    <nav class="nav-menu">

      <a href="<%= request.getContextPath() %>/dashboard.jsp"
         class="nav-link active" title="Dashboard">
        <span class="nav-icon">⌂</span>
        <span class="nav-text">Dashboard</span>
      </a>

      <a href="<%= request.getContextPath() %>/profile.jsp"
         class="nav-link" title="My Profile">
        <span class="nav-icon">♙</span>
        <span class="nav-text">My Profile</span>
      </a>

      <a href="<%= request.getContextPath() %>/donor"
         class="nav-link" title="Donor Registration">
        <span class="nav-icon">♡</span>
        <span class="nav-text">Become a Donor</span>
      </a>

      <a href="#emergency" class="nav-link" title="Emergency Requests">
        <span class="nav-icon">✚</span>
        <span class="nav-text">Emergency Requests</span>
      </a>

      <a href="#camps" class="nav-link" title="Donation Camps">
        <span class="nav-icon">▦</span>
        <span class="nav-text">Donation Camps</span>
      </a>

      <a href="#blood-banks" class="nav-link" title="Blood Banks">
        <span class="nav-icon">⌖</span>
        <span class="nav-text">Blood Bank Directory</span>
      </a>

    </nav>

    <div class="sidebar-bottom">

      <div class="support-card">
        <div class="support-icon">❤️</div>
        <h4>Every Drop Matters</h4>
        <p>Your small act of kindness can make a meaningful difference.</p>
        <a href="<%= request.getContextPath() %>/donor-profile.jsp"
           class="support-link">Join the donor network →</a>
      </div>

      <div class="sidebar-profile">
        <div class="avatar"><%= firstLetter %></div>

        <div class="profile-info">
          <strong><%= userName %></strong>
          <span><%= userRole %></span>
        </div>
      </div>

    </div>

  </aside>

  <!-- MAIN CONTENT -->
  <main class="main-content">

    <!-- TOP NAVBAR -->
    <header class="topbar">

      <div class="breadcrumb">
        LifeLink Campus &nbsp; / &nbsp; <strong>Dashboard</strong>
      </div>

      <div class="topbar-right">

        <div class="topbar-greeting">
          Welcome back, <strong><%= userName %></strong>
        </div>

        <div class="topbar-avatar">
          <%= firstLetter %>
        </div>

        <a href="<%= request.getContextPath() %>/logout"
           class="text-link" title="Logout">Logout ↗</a>

      </div>

    </header>

    <div class="page-content">

      <!-- PAGE HEADING -->
      <section class="page-heading">
        <p class="eyebrow">YOUR COMMUNITY. YOUR IMPACT.</p>
        <h1>Welcome back, <span><%= userName %></span>!</h1>
        <p>
          Together, we can build a campus community where help reaches
          people when they need it most.
        </p>
      </section>

      <!-- HERO BANNER -->
      <section class="hero">

        <div class="hero-copy">

          <div class="hero-tag">
            <span>♥</span>
            LIFE LINK INITIATIVE
          </div>

          <h2>Be someone's reason to hope.</h2>

          <p>
            Join the campus blood donation community, discover
            donation camps, and help connect people with verified
            blood-bank resources during emergencies.
          </p>

          <div class="hero-actions">

            <a href="<%= request.getContextPath() %>/donor-profile.jsp"
               class="btn btn-white">
              ♡ &nbsp; Register as Donor
            </a>

            <a href="#camps" class="btn btn-glass">
              Explore Donation Camps &nbsp; →
            </a>

          </div>

        </div>

        <div class="hero-symbol">♥</div>

      </section>

      <!-- OVERVIEW -->
      <div class="section-heading">
        <div>
          <h2>Your Dashboard</h2>
          <p>A quick overview of your LifeLink Campus activities.</p>
        </div>
      </div>

      <section class="stats-grid">

        <div class="stat-card">
          <div class="stat-top">
            <div class="stat-icon icon-red">♡</div>
            <span class="stat-label">YOUR CONTRIBUTION</span>
          </div>

          <div class="stat-number">Get Started</div>
          <p class="stat-description">
            Register as a donor to join the campus donor network.
          </p>
        </div>

        <div class="stat-card">
          <div class="stat-top">
            <div class="stat-icon icon-green">▦</div>
            <span class="stat-label">CAMPUS ACTIVITIES</span>
          </div>

          <div class="stat-number">Explore</div>
          <p class="stat-description">
            Discover upcoming blood donation camps and events.
          </p>
        </div>

        <div class="stat-card">
          <div class="stat-top">
            <div class="stat-icon icon-blue">⌖</div>
            <span class="stat-label">FIND RESOURCES</span>
          </div>

          <div class="stat-number">Connect</div>
          <p class="stat-description">
            Find blood-bank contact information and official resources.
          </p>
        </div>

      </section>

      <!-- QUICK ACTIONS -->
      <div class="section-heading">
        <div>
          <h2>Explore LifeLink</h2>
          <p>Choose how you would like to participate.</p>
        </div>
      </div>

      <section class="actions-grid">

        <a href="<%= request.getContextPath() %>/donor-profile.jsp"
           class="action-card">

          <div class="action-icon icon-red">♥</div>

          <h3>Become a Blood Donor</h3>

          <p>
            Submit your donor details and consent to be contacted
            about relevant donation opportunities.
          </p>

          <div class="action-link">
            <span>Complete donor registration</span>
            <span>→</span>
          </div>

        </a>

        <a href="#emergency" class="action-card">

          <div class="action-icon icon-blue">✚</div>

          <h3>Emergency Blood Requests</h3>

          <p>
            Explore the emergency coordination section for request
            information and available response options.
          </p>

          <div class="action-link">
            <span>View emergency section</span>
            <span>→</span>
          </div>

        </a>

        <a href="#camps" class="action-card">

          <div class="action-icon icon-green">▦</div>

          <h3>Donation Camps</h3>

          <p>
            Stay informed about campus blood donation drives,
            registration opportunities, and event details.
          </p>

          <div class="action-link">
            <span>Explore camps</span>
            <span>→</span>
          </div>

        </a>

      </section>

      <!-- LOWER PANELS -->
      <section class="lower-grid">

        <!-- EMERGENCY SECTION -->
        <div class="panel" id="emergency">

          <h3>Emergency Coordination</h3>

          <p class="panel-subtitle">
            A dedicated space for coordinating blood requests.
            Live requests will appear here after the backend is
            connected.
          </p>

          <div class="info-row">

            <div class="info-icon">✚</div>

            <div class="info-content">
              <h4>Blood Request Management</h4>
              <p>
                Requests can be submitted, reviewed, and
                tracked through the emergency coordination
                workflow.
              </p>
            </div>

            <span class="status-pill">Coming soon</span>

          </div>

          <div class="info-row">

            <div class="info-icon">♡</div>

            <div class="info-content">
              <h4>Donor Notifications</h4>
              <p>
                Future notifications will depend on donor
                consent, preferences, and verified request
                information.
              </p>
            </div>

          </div>

        </div>

        <!-- QUICK INFORMATION -->
        <div class="panel">

          <h3>Make a Meaningful Difference</h3>

          <p class="panel-subtitle">
            A few things to keep in mind when using LifeLink.
          </p>

          <ul class="tips-list">

            <li>
              <span class="tip-check">✓</span>
              <span>
                                Keep your profile details accurate and
                                up to date.
                            </span>
            </li>

            <li>
              <span class="tip-check">✓</span>
              <span>
                                Register as a donor only if you wish to
                                participate and consent to contact.
                            </span>
            </li>

            <li>
              <span class="tip-check">✓</span>
              <span>
                                Follow medical professionals' guidance
                                regarding donation eligibility.
                            </span>
            </li>

            <li>
              <span class="tip-check">✓</span>
              <span>
                                Confirm blood availability directly with
                                the relevant blood bank or medical facility.
                            </span>
            </li>

          </ul>

        </div>

      </section>

      <!-- DONATION CAMPS -->
      <div class="section-heading" id="camps">
        <div>
          <h2>Donation Camps & Events</h2>
          <p>Campus donation drives and community activities.</p>
        </div>
      </div>

      <section class="panel">

        <div class="info-row" style="border-top: none; padding-top: 0;">

          <div class="info-icon">▦</div>

          <div class="info-content">
            <h4>Campus Events</h4>
            <p>
              The event schedule will be displayed here once
              the camp-management module is connected.
            </p>
          </div>

          <span class="status-pill">Coming soon</span>

        </div>

      </section>

      <!-- BLOOD BANKS -->
      <div class="section-heading" id="blood-banks">
        <div>
          <h2>Blood Bank Directory</h2>
          <p>Access verified contact information and official resources.</p>
        </div>
      </div>

      <section class="panel">

        <div class="info-row" style="border-top: none; padding-top: 0;">

          <div class="info-icon">⌖</div>

          <div class="info-content">
            <h4>Blood Bank Information</h4>
            <p>
              Verified blood-bank details and official contact
              links will be added through the directory module.
              Please contact a medical facility directly to
              confirm availability.
            </p>
          </div>

          <span class="status-pill">Coming soon</span>

        </div>

      </section>

      <!-- FOOTER -->
      <footer class="footer">
        <p>Made with ♥ for the LifeLink Campus community.</p>
        <p>
          LifeLink helps coordinate information; blood availability
          and medical eligibility must be confirmed by the
          appropriate medical professionals.
        </p>
      </footer>

    </div>

  </main>

</div>

</body>
</html>
```