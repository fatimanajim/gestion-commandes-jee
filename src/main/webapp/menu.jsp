<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    * { box-sizing: border-box; }
    body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0 auto; padding: 20px;
           max-width: 1150px; background: #f0f2f5; color: #2c3e50; }

    /* ===== Navbar ===== */
    .main-navbar { background: linear-gradient(135deg, #14213d, #1d3557); padding: 18px 28px;
        border-radius: 12px; margin-bottom: 28px; box-shadow: 0 5px 18px rgba(20,33,61,.18); }
    .navbar-top { display: flex; justify-content: space-between; align-items: center;
        flex-wrap: wrap; gap: 16px; margin-bottom: 18px; }
    .brand { color: #fff; font-size: 22px; font-weight: bold; letter-spacing: .5px; }
    .brand small { display: block; color: #cbd5e1; font-size: 12px; font-weight: normal; margin-top: 5px; }
    .navbar-links { display: flex; flex-wrap: wrap; gap: 10px; }
    .navbar-links a { display: inline-block; color: #eaf0f8; text-decoration: none; padding: 11px 16px;
        border-radius: 8px; font-size: 14px; font-weight: 600; transition: background .2s, color .2s; }
    .navbar-links a:hover { background: #fff; color: #14213d; }
    .navbar-links a.active { background: #fca311; color: #14213d; }
    .navbar-footer { border-top: 1px solid rgba(255,255,255,.18); padding-top: 12px;
        margin-top: 14px; color: #cbd5e1; font-size: 12px; }

    /* ===== Contenu ===== */
    .content { background: #fff; padding: 25px 30px; border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,.07); }
    h1, h2, h3 { margin-top: 0; color: #14213d; }
    h2 { border-bottom: 3px solid #fca311; padding-bottom: 8px; display: inline-block; }

    /* ===== Tableaux ===== */
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th { background: #1d3557; color: #fff; text-align: left; padding: 12px; font-size: 14px; }
    td { padding: 10px 12px; border-bottom: 1px solid #e5e8eb; font-size: 14px; }
    tr:nth-child(even) td { background: #f8f9fa; }
    tr:hover td { background: #fff5e0; }

    /* ===== Boutons ===== */
    .btn { display: inline-block; background: #2a9d8f; color: #fff; padding: 8px 15px; margin: 2px;
        text-decoration: none; border: none; border-radius: 6px; cursor: pointer;
        font-size: 13px; font-weight: 600; transition: opacity .2s; }
    .btn:hover { opacity: .85; }
    .btn-danger { background: #e63946; }
    .btn-edit { background: #3a86ff; }
    .btn-gray { background: #7f8c8d; }

    /* ===== Messages ===== */
    .error { background: #fdecea; color: #c0392b; padding: 12px 15px; margin-bottom: 15px;
        border-left: 4px solid #e63946; border-radius: 4px; }

    /* ===== Formulaires ===== */
    form.f label { display: inline-block; width: 130px; margin: 8px 0; font-weight: 600; }
    form.f input, form.f select { padding: 9px 10px; width: 300px; max-width: 100%;
        border: 1px solid #ccd1d6; border-radius: 6px; font-size: 14px; }
    form.f input:focus, form.f select:focus { outline: none; border-color: #fca311;
        box-shadow: 0 0 0 3px rgba(252,163,17,.2); }

    /* ===== Accueil : cartes de statistiques ===== */
    .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
        gap: 18px; margin: 20px 0 30px; }
    .stat { color: #fff; padding: 22px; border-radius: 12px; text-decoration: none;
        box-shadow: 0 3px 10px rgba(0,0,0,.12); transition: transform .2s; display: block; }
    .stat:hover { transform: translateY(-4px); }
    .stat .nb { font-size: 34px; font-weight: bold; }
    .stat .lib { font-size: 14px; opacity: .9; margin-top: 4px; }
    .s1 { background: linear-gradient(135deg, #3a86ff, #1d5fd1); }
    .s2 { background: linear-gradient(135deg, #2a9d8f, #1b7a6e); }
    .s3 { background: linear-gradient(135deg, #fca311, #e08e00); }
    .s4 { background: linear-gradient(135deg, #8e44ad, #6c3483); }

    @media (max-width: 600px) {
        .navbar-links { flex-direction: column; }
        form.f label { display: block; width: auto; }
    }
</style>

<%
    String context = request.getContextPath();
    String path = request.getRequestURI().substring(context.length());

    String activePage = "";
    if (path.startsWith("/client")) activePage = "clients";
    else if (path.startsWith("/produit")) activePage = "produits";
    else if (path.startsWith("/commande")) activePage = "commandes";
    else if (path.equals("/") || path.startsWith("/accueil") || path.startsWith("/index")) activePage = "accueil";
%>

<nav class="main-navbar">
    <div class="navbar-top">
        <div class="brand">
            GESTION
            <small>Gestion des clients, produits et commandes</small>
        </div>
    </div>

    <div class="navbar-links">
        <a class="<%= "accueil".equals(activePage) ? "active" : "" %>" href="<%= context %>/accueil">&#127968; Accueil</a>
        <a class="<%= "clients".equals(activePage) ? "active" : "" %>" href="<%= context %>/clients">&#128101; Espace Client</a>
        <a class="<%= "produits".equals(activePage) ? "active" : "" %>" href="<%= context %>/produits">&#128722; Espace Produit</a>
        <a class="<%= "commandes".equals(activePage) ? "active" : "" %>" href="<%= context %>/commandes">&#128203; Espace Commande</a>
    </div>

    <div class="navbar-footer">Application Java Web &bull; Servlet, JSP, JSTL &bull; MVC 1 &bull; Tomcat 9</div>
</nav>